The second pilar of configuration is the [project-config](/glossary/#project-config) repository. 
This is where a Autostrap user will store most of their configuration. Since a
fair amount of configuration is provided by global-config, this repository's
configuration payload can be fairly small. For instance, the [project
configuration content][ex::docserver] required to set up a web server building and serving this
documentation consists of 69 lines at the time of this writing.

Usually a `project-config` repository starts out as a fork of Autostrap's
[example project-config repository][src::project-config]. We
recommend you store this fork in a private Git repository which is accessible
with an SSH deploy key provided to machines using the `deploy_key` parameter of
the [AS::autostrap Heat resource][heat::autostrap].
The `project-config` repository's URL and revision are specified
through the [`config_repo`][heat::autostrap::config_repo]
and [`config_branch`][heat::autostrap::config_branch]
parameters to the
[AS::autostrap Heat resource][heat::autostrap], respectively.

### Entry Position in hiera.yaml

Hierarchy entries pointing to the project-config repository will appear before
entries from the [global-config](/config/#global) repository and after entries
from [additional config repositories](/config/#additional).
