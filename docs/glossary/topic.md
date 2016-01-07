A topic is a self-contained unit of default configuration from the
[global-config][src::global-config] repository. It has a
topic name (henceforth referred to by the placeholder 'name') and consists of
the following directories in `global-config/puppet/hieradata`:

|||
|-|-|
| classes.d/`name` | This directory typically contains a file named `classes.yaml` which holds the Hiera array `classes`. The elements of this array are all the puppet classes required to deploy the topic in question. |
| config.d/`name` | This directory contains all configuration data required by this topic. This configuration can be overriden partially or completely by the configuration in a [project-config](/glossary/#project-config) repository. |
| repos.d/`name` | This directory contains [puppet-repodeploy][src::puppet-repodeploy] configuration specifying the repositories to be checked out when deploying the topic in question. Commonly these repositories are puppet modules required for deployment. |

Topics can be deployed using [masterless Puppet](/workflow/#masterless-topics)
or by by [adding](/workflow/#master-agent-topics) it to a Puppet master's
configuration. If a topic is deployed to a node in masterless fashion, all the
YAML files in the abovementioned directories are added to this node's
hiera.yaml. If it is added to the Puppet master's list of topics, only its
`config.d` and `repos.d` subdirectories will be added to the Puppet master's
hiera.yaml. Class declarations for nodes/node types will have to be
[configured](/workflow/#master-agent-classes) on a per-node/nodetype basis.
