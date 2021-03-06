Last, but not least, [cloud-init][ext::cloudinit], is the glue that binds the
other two configuration sources together. It is used in two ways: to inject a
user-data script into an instance and to pass so-called 'metadata', a set of
key-value parameters. The user-data script kicks off the bootstrapping process,
the metadata parameters influence its behaviour.

### cloud-init user-data script

The user-data script generated by [AS::autostrap][heat::autostrap] 
is parametrized by its parent heat template and passed to to all servers in a
service stack. Through this mechanism the servers receive their deploy keys
and their configuration repositories' URLs. This script is usually generated
once per service stack and passed to all machines unchanged.

One notable parameter to this script is
[override_yaml][heat::autostrap::override_yaml]. It contains
the contents of `override.yaml`, a file that will appear at the very top of
the machine's `hiera.yaml` and override all other configuration. This
mechanism is very useful for deploying development stacks based off one or
more development branches, or for any other temporary configuration you don't
want to commit to your project-config repository.

If you require additional high-level entries, for instance to pull in passwords
automatically generated by your bootstraping scripts, you can use the
[extra_overrides][heat::autostrap::extra_overrides] parameter to
add arbitrary hierarchy entries between `override.yaml` and
[additional-config](/config/#additional)/[project-config](/config/#project).

## cloud-init metadata parameters

Various `cloud-init` metadata paremeters influence the behaviour of puppet,
pass information (such as its floating IP address), or control the
[topics](/glossary/#topic) deployed on a given machine. Metadata parameters can
vary on a per-machine basis (e.g. typically only one machine will be assigned
the `puppet-master` topic while all others are assigned the `puppet-agent`
topic).
