First of all, you need to enable the [ssh topic](/topics/#ssh) on the machines
you wish to deploy authorized keys on.

Authorized SSH keys can be then be stored anywhere in your Hiera configuration
(i.e. in your [project-config](/config/#project) or an
[additional_config](/config/#additional) repository). Variables containing SSH
keys must be hashes and have the following format:

```
ssh::keys:
  'mykeyname':
    type: ssh-rsa | ssh-dss
    user: <user>
    key: <raw key>
    ensure: present | absent
```

This hash is keyed by free-form SSH key names.  Entries in this hash in turn
contain a hash with the following keys/values:

|||
|-|-|
|type (required) | The key's type, e.g. `ssh-dss` or `ssh-rsa`. |
|user (required) | The user whose `~/.ssh/authorized_keys` this key should be added to |
key (required) | The raw public key, without the type and comment fields, (e.g. what you'd get from an `awk '{print $2}' ~/.ssh/*.pub`). |
ensure (optional) | Whether to ensure the key being present or absent (defaults to present). |

There may be multiple variables containing such hashes. You can control which
of these are merged to form the final hash of authorized keys in one of two
ways:

By default, Autostrap uses the hash `ssh::keys` if the `ssh`
[topic](/glossary/#topic) is enabled for a machine. Typically you would create
this as a default hash in global-config and add to it in project-config. To
prevent such a hash in global-config (e.g. if you create a project-config for a
setup restricted to a smaller circle of keys than the ones found in your
global-config repository) from being used you can use one of the following
methods:

1. You can set the Hiera variable `ssh::key_sources`. This is an array
   containing the Hiera variables to retrieve authorized keys from.

1. You can supply the same thing as a space-delimited list of hiera variable
   names in the metadata parameter `sshkeys`. This is ok for testing, but not
   recommended in production. If the Hiera variable `ssh::key_sources` is set,
   it will take precedence over this metadata parameter, i.e. the metadata
   parameter will be ignored.

If you do not set the list of SSH key sources explicitely, it will default to
the following variable:

* `ssh::keys`

Additionally, `ssh::authorized_keys::authorized_keys` will be appended to
`ssh::key_sources` if it is defined anywhere in your Hiera configuration. This
ensures legacy setups that still store their SSH keys in
`ssh::authorized_keys::authorized_keys` will continue to function.

## Examples

In this section you will find examples for configuring a custom list of Hiera
variables to retrieve SSH authorized keys from, for both approaches outlined
above. While you can use either of these approaches, we strongly recommend
using the `ssh::key_sources` Hiera variable (it will also take precedence over
the metadata approach if both types of configuration are used).

### Configuring the SSH key hash names through Hiera

To retrieve your SSH key hashes from the variables `ssh::keys::mykeys` and
`ssh::keys::myotherkeys` you would add the following to your Hiera
configuration:

```
ssh::key_sources:
 - ssh::keys::mykeys
 - ssh::keys::myotherkeys
```

### Configuring the SSH key hash names through the `sshkeys` metadata entry

To retrieve your SSH key hashes from the variables `ssh::keys::mykeys` and
`ssh::keys::myotherkeys` you would add the following entry to the `metadata`
key of your `OS::Nova::Server` resources:

```
mynode:
  type: OS::Nova::Server
  properties:
    [...]
    metadata:
      sshkeys: 'ssh::keys::mykeys ssh::keys::myotherkeys'
```
