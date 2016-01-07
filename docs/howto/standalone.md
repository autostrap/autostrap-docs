First of all you need a blank machine which fullfills the following
requirements:

* Ubuntu 14.04

* Internet Access

* Bash, Python, Git

* A deploy key for the private repositories you might use during bootstrapping
  in `/root/deploy` (optional, but usually neccessary).

We recommend using a throwaway vagrant instance for this purpose.

On your machine, run the following commands:

```
git clone https://github.com/autostrap/bootstrap-scripts.git \
         /tmp/bootstrap-scripts
unset SSH_AUTH_SOCK     # This ensures the deploy key is used 
                        # (as opposed to a key an SSH agent might
                        # be forwarding)
cd /tmp/bootstrap-scripts/stage0
deploy_key="$(cat /root/deploy)" ./autostrap.standalone  \
           -m topics="base puppet-masterless" \
           -m nodetype=docbox
```

This example will give you a nginx web server managed through masterless
puppet, hosting this documentation. You can vary topics and other metadata
parameters and/or environment variables (the Heat properties recognized by
`AS::autostrap` are retrieved from identically named environment variables by
`autostrap.standalone`) as needed to create other setups.

Note: `autostrap.standalone` will not output anything on the console. To
monitor progress tail the following files:

* /var/log/autostrap/stage0.log

* /var/log/initialize_instance.log (only appears once initialize_instance has been launched)
