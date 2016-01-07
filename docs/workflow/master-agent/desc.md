For larger setups a Puppet master can be automatically deployed, with all nodes
(including the Puppet master itself) running Puppet agents. This approach is
recommended for any setup beyond two nodes. This approach consists of a
masterless first stage that sets up the Puppet master and its agent, with
configuration being provided through the Puppet master from there on out.

