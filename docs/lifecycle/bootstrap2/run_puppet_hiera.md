![](figures/overview-run_puppet_hiera.svg)

At the end of the puppet bootstrapping process, `run_puppet_hiera` will run
puppet, driven by the `hiera.yaml` just generated. This puppet run will deploy
all [topics](/glossary/#topic) listed in the machine's `topics` metadata entry. This list
usually includes either `puppet-masterless` or `puppet-agent`. Hence this first
puppet run ensures continuing management of the machine's configuration by
regular puppet runs from now on.
