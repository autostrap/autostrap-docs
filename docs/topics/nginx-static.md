This topic sets up a [nginx][ext::nginx] web server that responds to
your instance's floating IP address and serves the static files it finds in
`/usr/share/nginx/html`. It is meant for very simple setups, i.e. if you want
to do anything beyond serving a bunch of static files through unencrypted HTTP
do not use this topic.

## Declared Classes

|||
|-|-|
|`nginx` |Configures `nginx`. |
