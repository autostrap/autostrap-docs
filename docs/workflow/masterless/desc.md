This approach is meant for small setups that typically consist of only one or
two servers. In this case a Puppet master is not really needed. Consequently,
all configuration and Puppet modules relevant to the node in question will be
locally available on any node. A cronjob will run puppet locally on a regular
basis. The diagram below gives an overview of the steps involved in a
masterless puppet setup:


