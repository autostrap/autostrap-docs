This topic loads most of Autostrap's [puppet-base][src::puppet-base]
module (the key handling logic of the [ssh topic](/topics/#ssh) are part of
`puppet-base` but not loaded by the `base` topic. `puppet-base` handles basic
system configuration. This includes among other things:

* Setting a root password

* Setting various sysctls to sensible values

* apt(8) configuration

* Installing a few useful packages

* Sane bash, vim and screen settings

## Declared Classes

|||
|-|-|
| `base::role::common` | Declares most profiles from [puppet-base][src::puppet-base].  It does 'not' load `base::role::sshkeys`, for instance (that is declared in the [ssh](/topics/#ssh)). |
