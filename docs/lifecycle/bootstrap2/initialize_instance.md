![](figures/overview-initialize_instance.svg)

`initialize_instance` is primarily a wrapper for starting the various scripts
in the second bootstrapping stage. It keeps track of progress (and writes
status messages to `/dev/console` for outside visibility) and ensures all
second stage output is logged to `/var/log/initialize_instance.log`. Once all
second stage scripts have run, `initialize_instance` will report conclusion of
the bootstrapping process to `/dev/console`.

All second stage bootstrapping scripts are drawn from two sources:

1. The `bootstrap.d/` subdirectory of the [global-config](/config/#global) repository.

1. The `bootstrap.d/` subdirectory of your [project-config](/config/#project) repository.

The contents of both these directories are symlinked to the
`/opt/scripts/stage/` directory. All files in this directory are executed in
shell globbing order, i.e. a script named `000-first` will be executed before
111-last (much like in sysvinit's rc*.d directories). All scripts in
`global-config` are prefixed with a zero-padded, three digit multiple of 20,
e.g. `000-first`, `020-second`, `040-third`, ...

If you add any scripts to your [project-config](/config/#project) repository's
`bootstrap.d` directory please do not prefix them with multiples of 20 since
these are reserved for scripts from [global-config](/config/#global).
Apart from that anything goes. I.e. you can number them in a way that places
them between any two scripts from [global-config](/config/#global). If,
for instance, you wanted your own script to run between `020-setup_system` and
`040-setup_puppet_modules`, you could name it `030-myscript`.

The rest of this section will give a rundown of the bootstrapping scripts
pulled in from the [global-config](/config/#global) repository.
