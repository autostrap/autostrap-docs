The repository [global-config][src::global-config] contains
collections of Puppet classes along with matching
[Hiera][ext::hiera] configuration to deploy on Openstack
instances. We refer to these collections as [topics](/glossary/#topic)). Topics can
be deployed to instances in two ways: directly, using the `topics`
metadata parameter, or indirectly by
[integrating](/workflow/#master-agent-topics) them in a
[project-config](/glossary/#project-config) repository.

The `global-config` repository is meant as default configuration, to be overriden and extended
by the [project-config](/glossary/#project-config) repository described in the next
section.

### Entry Position in hiera.yaml

Hierarchy entries pointing to the global-config repository will appear at the
very bottom of the hierarchy in `hiera.yaml`. This means that configuration
from either [project-config](/config/#project) or any of the repositories
specified through the [additional_config parameter](/config/#additional) will
override it.
