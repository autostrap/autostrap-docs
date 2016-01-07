{!macros.md!}

[TOC]

![Overview of Autostrap configuration sources](overview.svg)

Machines deployed through Autostrap draw their configuration from various
sources. The schematic above shows a big-picture view of these sources and how
they interact with each other. In this section we will discuss the four sources
for configuration information Autostrap uses: 

* Default configuration from [global-config][src::global-config]
* project specific configuration from a [project-config](/config/#project)
  repository
* Additional user specified configuration repositories
* [cloud-init][ext::cloudinit] user-data and metadata.

Read this section to get an in-depth tour of the configuration sources at your
disposal. If you are itching to try Autostrap you can skip this section. Just
create a private fork of [project-config][src::project-config] and
move on to the [Deployment Workflow](/workflow) section.

# Configuration Sources

<a name='global'></a>
## global-config: Default Configuration

{!config/global-config.md!}

<a name='project'></a>
## Project Configuration

{!config/project-config.md!}

<a name='additional'></a>
## Additional Configuration

{!config/additional_config.md!}

## cloud-init: User Data Script and Metadata Parameters

{!config/cloud-init.md!}
