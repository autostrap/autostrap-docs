{!macros.md!}

Depending on the platform Autostrap is deployed on, there are various entry
points into the bootstrapping process. We refer to these entry points as _Bootstrapping
Stage 0_. The first common point for all platforms is the
[initialize_instance](/lifecycle/#s2-initialize) script.
This script we also refer to as _Bootstrapping Stage 1_. It is the starting
point for the actual bootstrapping process.  Currently, there are the following
Stage 0 mechanisms for calling it:

# Heat Resource

{!entry/heat.md!}

# autostrap.standalone

{!entry/standalone.md!}
