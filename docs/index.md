{!macros.md!}

[TOC]

# What is Autostrap?

[Autostrap][autostrap] is a framework for deploying, configuring and orchestrating a set of
virtual or physical machines that act in concert to provide a service, such as
a web shop. It consists of known-good sample configuration for a range of
services, sample [Heat][ext::heat] templates for
service clouds (or stacks, as Heat terms them) of one or more machines
providing these services, and a set of bootstrapping scripts for setting the
machines up for [Puppet][ext::puppet] configuration. It is designed to
be easily extended with user or project specific configuration and Puppet code.
All components are available under an [Apache 2.0 license][ext::apl].

Autostrap has been developed and tested on Ubuntu 14.04. It may work for other
Debian flavoured systems, but none have been tested so far.

# Environment

Cloudstrap can either run standalone on any Ubuntu 14.04 with an Internet
connection or it can be launched through Openstack's [Heat][ext::heat]
orchestration tool. Porting to Cloud environments other than Openstack should
not pose too great a challenge, but so far this has not been put to the test.

# History

Autostrap started out as an internal Project at [Syseleven][ext::sys11], where
it was used to configure various services running as [Heat][ext::heat] stacks
on Syseleven's Openstack cloud. While it eventually turned out not to be ideal
for Syseleven's intended use in managed hosting, it is nonetheless a very
useful tool for building infrastructure automatically and reproducibly. 
Syseleven kindly gave permission to release the code base to the community, the
results of which you are looking at now.

# How to Read this Document

If you are entirely new to Autostrap, we recommend starting with the
[Components](components/index.md) and [Entry Points](entry/index.md) sections. The former will
give you an overview of what components Autostrap consists of, the latter will
give you an idea of how and where you can kick off the bootstrapping process.
Once you are through with these two sections it's probably best to take some
time to read [Life of a Stack](lifecycle/index.md). It will give you a birds-eye
overview of how Autostrap bootstraps a blank VM to a point where it can run
puppet.

After that, it's probably best to get your hands dirty and follow the
instructions in the [Deployment Workflow](workflow/index.md) section to deploy your
first Autostrap based service stack.

Finally, you will find detailed reference documentation in the following
sections:

| | |
| - | - |
| [Configuration Sources](config/index.md) | Discusses all knobs and dials available for configuring Autostrap in detail. Be sure to read this section before building a Autostrap based production setup. |
| [Glossary](glossary/index.md)            | A glossary of terms we use in this document. |
| [How do I...](howto/index.md)            | Short howto guides for various common tasks. |

# Contact and Contributions

For now, use our IRC channel `#autostrap` on
[FreeNode][ext::freenode] to get in touch. We do not have a mailing
list, yet. For Bug reports/feature requests, please raise an issue on
our [Github page][autostrap].

There is no formal contribution process right now. Just submit a pull request
on Github. We recommend discussing large and/or breaking changes in the IRC
channel first.
