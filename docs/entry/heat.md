For Openstack platforms we developed the [AS::autostrap][heat::autostrap] Heat
resource. It generates a user-data script ready to be passed into
[OS::Nova::Server][ext::heat-nova] instances. This script turns the parameters
it receives through Heat into environment variables, clones
[bootstrap-scripts][src::bootstrap-scripts] and launches
[initialize_instance](/lifecycle/#s2-initialize) in this environment. Usually
you will only need one instance of this resource per Heat stack, i.e. you can
pass the same generated script to all Nova servers in your stack.
