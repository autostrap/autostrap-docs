![](figures/overview-setup_puppet_modules.svg)

With the preliminaries out of the way, [Puppet][ext::puppet] 
deployment can now begin in earnest. As a first step, `setup_puppet_modules`
performs for puppet what `setup_system` performed for the whole system: it
installs a small selection of Puppet modules into `/etc/puppet/modules`. These
modules are the bare minimum required for a first run of
[puppet-repodeploy][src::puppet-repodeploy].
