{!macros.md!}

In this section we will describe deployment workflows for two kinds of
Puppet configuration approaches: masterless Puppet (for single-instance stacks)
and a traditional Puppet master/agent setup (for stacks of two or more
instances). Both approaches follow the same basic basic steps:

![](figures/overview.svg)

These workflows assume you are deploying to an Openstack cloud, but they can be
adapted to [autostrap.standalone](/entry/#autostrap.standalone) if you do not
have access to an Openstack cloud.

We will start this section off with a check list of common prerequisites you
will need for both approaches. Once you have the items on this list covered you
can dive right into deploying your first stack using either the
[master/agent](/workflow/#master-agent) or [masterless](/workflow/#masterless)
approach.

# Prerequisites

{!workflow/prerequisites.md!}

<a name='master-agent'/></a>
# Puppet Master/Agent Based Configuration

{!workflow/master-agent/desc.md!}

{!workflow/master-agent/workflow.md!}

<a name='masterless'/></a>
# Masterless Puppet Configuration

{!workflow/masterless/desc.md!}

{!workflow/masterless/workflow.md!}

