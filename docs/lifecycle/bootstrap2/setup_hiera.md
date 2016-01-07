![](figures/overview-setup_hiera.svg)

`setup_hiera` is the centerpiece of Autostrap's puppet bootstrapping process.
It performs two tasks:

1. It generates a `hiera.yaml` configuration file. This file contains a list of
  all the configuration files that are consulted by puppet running on this
  machine (both in masterless mode, and by a puppet master if this machine
  happens to be one).

1. It clones the additional configuration repositories specified in the
  [`additional_config`](/config/#additional) Heat parameter and adds
  corresponding entries in hiera.yaml.

1. It runs [puppet-repodeploy][src::puppet-repodeploy] to retrieve
  the repositories defined in the `repodeploy::repos` hash. This hash may occur
  anywhere in the files listed in `hiera.yaml`. Multiple occurences are merged.

The contents of `hiera.yaml` vary based on the following parameters:

|||
|-|-|
| The `cloud-init` metadata entry `topics` | This is a space delimited list that determines the topics to be deployed by (a) `run_puppet_hiera` and (b) subsequent puppet runs, if the `puppet-masterless` topic has been deployed to this machine. All configuration files that make up the topic in question will be entered in `hiera.yaml`. |
| The contents of `puppet/topics` in the [project-config](/glossary/#project-config) repository | This is mainly relevant for a Puppet master. This file contains a list of all the topics this puppet master serves to its agents. `setup_hiera` will add the contents of these topics' `config.d` and `repos.d` subdirectories to `hiera.yaml`. Thus both the configuration relevant to the topics in question and the puppet modules required for their deployment will be available on the puppet master. |

Once `hiera.yaml` has been generated and repodeploy has retrieved all
repositories, `setup_hiera` will remove `/etc/puppet/modules`, since it has
served its purpose: the modules therein were only required to run
`puppet-repodeploy`. From this point onward, only puppet modules retrieved by
`puppet-repodeploy` will be used. The system is now ready for its first
masterless puppet run.
