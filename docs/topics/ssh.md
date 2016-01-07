This topic configures an instance's `ssh` daemon in a secure manner and
deploys SSH public keys from several Hiera hashes to the `root` user's
`authorized_keys` file (see our [key deployment HOWTO](/howto/#sshkeys) for
details on configuring authorized keys).

## Declared Classes

|||
|-|-|
`ssh` | Our [puppet module][src::puppet-ssh] for ssh configuration. |
|'base::role::sshkeys` | Deploys authorized keys. |
