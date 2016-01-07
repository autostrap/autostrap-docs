![](figures/overview-setup_repos.svg)

The `setup_repos` script clones the two main configuration repositories that combine
into the service stack's configuration ([global-config][src::global-config] and a
[project-config repository](/glossary/#project-config)), as well as the [repodeploy][src::puppet-repodeploy]
puppet module. The URLs and revisions for these repositories are supplied as environment variables 
passed through from the user-data script.
