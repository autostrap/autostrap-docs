{!macros.md!}

[TOC]

In this section we will describe the life cycle of a Autostrap deployed
service stack, from instantiating a heat template to the finished application,
in particular this includes:

1. The components a Heat template needs for the instances within to be deployed
  by Autostrap

1. The individual stages in an instance's bootstrapping proces.

Read this section to get a high-level overview of what happens during the
Autostrap bootstrapping process and how it is kicked off. You can later
complement it with the [Configuration Sources](/config) section for an in-depth
discussion of the configuration sources that govern Autostrap's behaviour.

# Starting Point: A Heat Template

{!lifecycle/heat.md!}

# First Bootstrapping Stage: The AS::autostrap Heat resource

{!lifecycle/bootstrap1.md!}

# Second Bootstraping Stage: The bootstrap-scripts repository

{!lifecycle/bootstrap2/index.md!}

<a name='s2-initialize'></a>
## Starting Point: initialize_instance

{!lifecycle/bootstrap2/initialize_instance.md!}

## Puppet Setup: Configuration Repository Retrieval

{!lifecycle/bootstrap2/setup_repos.md!}

## Packages and System Setup

{!lifecycle/bootstrap2/setup_system.md!}

## Puppet Setup: Temporary Module Installation

{!lifecycle/bootstrap2/setup_puppet_modules.md!}

## Puppet Setup: Hiera Configuration and Repository Checkouts

{!lifecycle/bootstrap2/setup_hiera.md!}

<a name='s2-run_puppet_hiera'></a>
## Puppet Setup: First Puppet Run

{!lifecycle/bootstrap2/run_puppet_hiera.md!}

