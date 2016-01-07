For environments without Heat and cloud-init we developed
[autostrap.standalone][bootstrap-scripts::autostrap.standalone].
This script provides the same environment as the
[AS::autostrap][heat::autostrap] Heat
resource and invokes initialize_instance as well. It emulates the Heat based
parametrization mechanisms detailed in the [Life of a Stack](/lifecycle) section with the
following two mechanisms:

* Parameters that are passed into [AS::autostrap][heat::autostrap] as Heat properties are retrieved from identically named environment variables.

* cloud-init metadata parameters are passed as `=` delimited key-value arguments to `autostrap.standalone`'s `-m` option.

Example: 

```
autostrap.standalone -m topics=puppet-agent \
                      -m nodetype=appserver
```
