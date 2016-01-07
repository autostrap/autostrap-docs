# Prerequisites

Unless stated otherwise, all commands should be run on a machine with a working
scloud setup that uses the `openstack_stuff` deploy key.

# Development Environment

To work on this documentation, first create a topic branch of
[autostrap-docs](https://github.com/autostrap/autostrap-docs.git) and push it
somewhere accessible from the Internet (this example assumes you've got your
own local fork of the repository):

```
cd /tmp
git clone git@github.com:my-user-name/autostrap-docs.git
cd cloud-docs
git checkout -b fix-typos
git push -u origin fix-types
```

Next, create an override.yaml for the sys11-docs Heat stack:

```
cat > /tmp/override.yaml <<EOF
sys11doc::repos:
  '/opt/doc/autostrap':
    source: git@gitub.com:my-user-name/autostrap-docs.git
    provider: git
    revision: fix-typos
    post-checkout: "%{hiera('sys11doc::post-checkout')}"
EOF
```

This override.yaml ensures the Heat stack's working copy is not overwritten by
the current master branch every time puppet runs.

Now create the [nginx-server Heat
stack](https://github.com/autostrap/project-config/blob/master/heat-templates/nginx-masterless.yaml):

```
git clone https://github.com/autostrap/project-config.git /tmp/cloud-docs
cd /tmp/cloud-docs/heat-templates
scloud nginx-masterless.conf -P override_yaml=/tmp/override.yaml --stackname=my_docs_stack
```

Once the stack is up and running you can log in to the instance it contains and
edit the markdown source in the `autostrap-docs` working copy in
`/opt/doc/autostrap`. A `git checkout` will trigger a rebuild, with the result
ending up in the web server's document root
(`/usr/share/nginx/html/autostrap/`).
