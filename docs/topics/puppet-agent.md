This topic configures a puppet agent. It is part of our standard puppet setup
process for stacks of two or more instances. If you have a puppet master that
is not named `puppetmaster.local`, you will need to set the `puppetmaster` meta
data entry to its host name on all instances you deploy this topic to.

## Declared Classes

|||
|-|-|
| `autopuppet::role::agent` | Configures a puppet agent. |
