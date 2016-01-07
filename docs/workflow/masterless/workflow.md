## Step 1: Creating a Heat Template

First of all you will need to describe your projects requirements in terms of a
Heat template. As a starting point, the Heat project provides some 
[guidelines][ext::heat-guide]
on writing heat templates.

Autostrap requires various meta data parameters and an Autostrap provided
user-data script, so we recommend you modify one of our example templates in
the heat-templates directory of [project-config][src::project-config]
to fit your project's requirements.

## Adding a AS::autostrap resource

The custom Heat resource `AS::autostrap` generates a user-data script that
will kick off the autostrap deployment process. This user-data script is then
passed to your instances (`OS::Nova::Server` resources) as user-data property.

### Properties

The following properties of `AS::autostrap` are most likely to be relevant
to deploying a new project (refer to the `AS::autostrap` documentation for
the rest):

* `config_repo`: The URL of your project specific configuration repository, i.e.
  _my-config-url_. <a name='masterless-config_repo'></a>

* `config_branch`: An optional branch/revision of your configuration repository
  to check out. This is mainly useful for development and best sourced from a
  Heat parameter that defaults to 'master' (thus allowing you to specify
  experimental/development branches at run-time, while defaulting to a
  known-good stable branch otherwise).'

* `deploy_key`: A SSH private key with access to all non-public repositories
  you specified in your repository configuration (i.e. all instances of
  `repodeploy::repos` occuring in your configuration). We strongly recommend
  against adding this deploy key to your heat template. Current best practice
  is to pass it as a parameter (with the `hidden` attribute enabled). <a name='masterless-deploy_key'></a>

### Declaration Example

```
  bootstrap:
      type: AS::autostrap::v1
      properties:
        deploy_key: { get_param: deploy_key }
        config_repo: <my-config-url>
        config_branch: 
```

### Instance Attachment Example

```
  my_machine:
    type: OS::Nova::Server
      properties:
        name: my_machine
        user_data: { get_attr: [ bootstrap, script ] }
        user_data_format: RAW
```

Note the "::v1" trailing the resource declaration. Like all of Autostrap's
custom resources, this resource is versioned: whenever we introduce breaking
API changes we increment the version number. This way you can generally rely on
a given version continuing to behave as as expected.

## Required Metadata parameters for instances

You will need to pass at least the following heat parameters to instances
(`OS::Nova::Server` resources) to be deployed using Autostrap:

* `topics` - The configuration topics to deploy on the instance in question
  (see [Adding Configuration Topics from global-config](/workflow/#masterless-topics)).

Additionally, it is recommended to set the following metadata parameters:

* `stack_name` - Available to puppet through the fact `openstack_stack_name`
  (requires the puppet module openstackfacts)

* `floating_ip` - Available to puppet through the fact `openstack_floating_ip`
  (requires the puppet module openstackfacts)

If you have followed the recommendations above, a machine's metadata property
might look as follows:

```
      metadata:
        stack_name: { get_param: 'OS::stack_name' }
          topics: "base ssh puppet-masterless"
          stack_name: { get_param: 'OS::stack_name' }
          floating_ip: { get_attr: [ my_port, floating_ip_address ] }
          topics: "base ssh puppet-masterless"

```

<a name='masterless-topics'></a>
## Step 2: Adding Configuration Topics From global-config

Now you will have to pick configuration [topics](/glossary/#topic) to deploy from
[global-config][src::global-config]. Each topic consists of
a set of puppet classes required to deploy the service or other configuration
it deploys, hiera configuration and a list of repositories containing the
puppet modules it uses.

At a minimum, you will need the `puppet-masterless` topic. Additionally,
`base` (sensible configuration and useful packages) and `ssh` (sensible sshd
configuration and rollout of ssh authorized keys) are highly recommended.

Once you have picked topics, edit your heat template and add them to the
`topics` metadata entry of the instances they are to be deployed on. This
metadata entry is a simple space separated list. If we assume you picked all
topics recommended in the previous paragraph, a machine's meta data would contain
the following entry:

```
      metadata:
        topics: "base ssh puppet-masterless"
```

## Step 3: Forking and Customizing project-config

Since you probably want to add custom configuration of your own beyond that
provided by [global-config][src::global-config], you will
now need to fork [project-config][src::project-config].  This fork is the
repository we referred to as _my-config_ in the
[Prerequisites](/workflow/#prerequisites) section above.

### Controlling access to _my-config_

_my-config_ must be reachable from the Internet, so your Openstack instances
can use it to retrieve your projects's configuration. It can be reachable
through a public HTTPS URL, but we strongly recommend to make it accessible
through SSH with public-key authentication. 

If you do make _my-config_ non-public you will have to supply a
[deploy_key](/workflow/#masterless-deploy_key) property to your
`As::autostrap` resource. This property must contain a SSH private key that
can access _my-config_.

### Customizing _my-config_

Now you can modify _my-config_ to your heart's content. The changes and
additions will then be deployed on your heat stack's machines. You can put
Hiera configuration into the following subdirectories of _my-config_:

* `puppet/hieradata/config.d`: This directory contains hiera configuration
  relevant to all nodes/node types. It should contain all configuration that is
  not confined to any specific node or node type. One example for such a
  configuration value would be the list of SSH authorized keys, configured in
  the `ssh::keys` hash.  File and directory names in this directory are
  free-form (every file with a .yaml extension will be included), but it is
  recommended to organize configuration by topic name for easier navigation by
  developers.

* `puppet/hieradata/repos.d`: This directory contains
  [puppet-repodeploy][src::puppet-repodeploy] configuration, i.e. zero or more
  instances of the `repodeploy::repos` hash.  This hash specifies repositories
  to be checked out by [puppet-repodeploy][src::puppet-repodeploy]. File and
  directory names in this directory are free-form (every file with a .yaml
  extension will be included), but it is recommended to organize configuration
  by topic name for easier navigation by developers.


* `puppet/hieradata/nodes.d`: This directory contains node specific
  configuration. It should only contain configuration that is relevant to
  specific nodes. All file names in this directory must be the target node's
  FQDN plus a '.yaml' extension, e.g. `puppetmaster.local.yaml`. All nodes
  start out with a FQDN of 'hostname'.local.

* `puppet/hieradata/nodetypes.d`: This directory contains node type specific
  configuration. A node's node type (such as `appserver`) is assigned by
  setting the `nodetype` metadata entry. All file names in this directory must
  be the target node type's name as given in the `nodetype` metadata entry,
  plus a '.yaml' extension, e.g. `appserver.yaml`.

All classes to be included in puppet's catalog should be declared either on a
per-node or a per-nodetype basis, unless they are part of a topic from the
`topics` metadata entry already, of course. This means adding a `classes` array
to a file in `puppet/hieradata/nodes.d` and/or `puppet/hieradata/nodetypes.d`.

Refer to the  example project-config repository's [README.md
file][project-config::readme] file for more detailed information on these
directories and their contents.

Last but not least, you can add last-minute commands to be run at the end of the
bootstrapping process to ``bootstrap.d/additional``. This is the place for
everything that cannot be handled using puppet. This script will run on all
nodes using _my-config_ as its project configuration repository.


### Configuring _my-config_ in your Heat template

As a final step, you will need to make the Heat stack you are creating aware of
your _my-config_ repository. To this end, simply pass _my-config-url_ as
[config_repo](/workflow/#masterless-config_repo) property to
your `AS::autostrap` resource.

## Step 5: Deploying From Your Heat Template

Once configuration is finished and pushed to the _my-config_ repository and
your heat template contains the neccessary elements you can deploy a heat stack
roughly as follows:

```
heat stack-create -f mycloud.yaml \
                  -P key_name=<nova key name> \
                  -P deploy_key="$(cat ~/.ssh/deploy_key)" \
                  my-masterless-stack
```

Substitute the key name you specified when uploading your SSH key to nova for
`<nova key name>`. You may also have to supply a `public_net_id` parameter.

Other parameters supplied to `heat stack-create` may vary. This example assumes a
largely unmodified copy of the `nginx-masterless.yaml` example template with
just the `config_repo` parameter's default changed to _my-config-url_.
