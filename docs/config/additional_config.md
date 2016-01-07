Finally, autostrap contains a mechanism for inserting arbitrary snippets of
Hiera configuration. This mechanism is controlled through the
[AS::autostrap Heat resource's `additional_config` parameter][heat::autostrap::additional_config]
which contains a space delimited list of git repositories. These repositories
are cloned during bootstrapping, and entries in hiera.yaml referencing them are
generated.

### additional_config Parameter Format

Entries in the list of repositories are formatted as follows:

```
<repository url>[#<revision>]::[[<path>][:<path> ...]]
```

An entry consists of the following components:

| | |
|-|-|
|`repository url` | The Repository's  URL (mandatory). |
|`revision` | A revision (branch or commit ID) of the repository to check out (optional). |
|`path` | A path referencing a YAML file (the .yaml extension may be omitted), relative to the repository's root directory. Each of these paths will result in an entry in hiera.yaml. There may be multiple paths, separated by colons as in a `$PATH` variable. Paths my include shell wildcards (`*`, `?`, etc.) which will be expanded. |

### additional_config Example

This is what the contents of an `additional_config` parameter might look like: 

```
'https://example.com/my-additional-config.git::ssh/mykeys.yaml \
git@gitlab.example.com:my-team/my-config.git#devel::config/ssh/keys:apache/*'
```

This will trigger the following actions:

* Clone `https://example.com/my-additional-config.git` and symlink it to `/etc/puppet/hieradata/my-additional-config`.
* Add `my-additional-config/ssh/mykeys` to Hiera's hierarchy.
* Clone `git@gitlab.example.com:my-team/my-config.git`, checkout revision `devel` and symlink it to `/etc/puppet/hieradata/my-team`.
* Add `my-team/ssh/keys`, and all contents of the `apache/` subdirectory to Hiera's hierarchy.

### Entry Position in hiera.yaml

Hierarchy entries resulting from the `additional_config` parameter will appear
before entries from the [project-config](/glossary/#project-config) repository.

Repositories will appear in the order their repository specifications appear in
`additional_config`.

Paths associated with a given repository will appear in the order they were
given in the repository's `additional_config` entry.
