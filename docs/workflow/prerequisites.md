Following the deployment instructions described in this section requires the following:

* A user account on an Openstack cloud
* The Openstack [command-line clients][ext::openstack-clients]
* git
* A remotely accessible (e.g. through SSH or HTTPS) git repository for storing
  project specific configuration. This repository should start out as a fork of
  Autostrap's [sample project-config repository][src::project-config]. Throughout this section we will
  refer to this repository with the placeholder _my-config_ and to its url with
  the placeholder _my-config-url_.
* An editor with syntax highlighting for [YAML][ext::yaml] (optional, but recommended)
* The syseleven.cloudutils package for smoother handling of heat stacks
  (optional, but recommended). A simple `pip install syseleven.cloudutils`
  should take care of this.
