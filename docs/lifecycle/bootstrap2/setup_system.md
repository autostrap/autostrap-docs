![](figures/overview-setup_system.svg)

`setup_system` is the first real step in the second bootstrapping stage. It
configures `apt` repositories, installs packages required during the second
bootstrapping stage, and configures various things in a sensible manner. Once
it has finished, [Puppet][ext::puppet] setup begins.
