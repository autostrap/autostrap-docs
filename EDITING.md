# Editing

Below you will find a short guide to editing the documentation in this
repository. A basic familiarity with the
[Markdown format](https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet)
is assumed. If you plan on delving deeper you will probably have to familiarize
yourself with [mkdocs](http://mkdocs.org).

## Document structure

The high-level document structure (chapters) is defined in the file
`mkdocs.yaml`. It is in [YAML](http://www.yaml.org) format and contains the
`pages` array among other things. Each entry in this array is a one-entry hash
mapping a chapter title to the file name this chapter's markdown source is to
be read from. File names are relative to the `docs/` directory, i.e.
`introduction/index.md` will resolve.

## Adding Chapters

1. Think of a chapter title and a short name (e.g. `documentation` and `Writing
   Documentation`) and add an entry to the `pages` array in `mkdocs.yml`:

   ```
   pages:
     [...]
     - 'Writing Documentation': 'documentation/index.md'
   ```

2. Create the corresponding directory under `docs/` and an index.md for your
   chapter:

   ```
   mkdir docs/documentation
   touch docs/documentation/index.md
   ```

Our current convention is to have each chapter in its own directory, in a file
named `index.md'. If you need to split up your document into multiple files you
can use include directives (see below).

## Graphics and Other Static Content

There are two ways to include graphics:

### Fully static

You can store arbitrary files in the `docs/` directory and link to them using
relative links (they will be copied to the `site/` directory. For example, if
you have a file named `apicture.jpeg` in the directory
`docs/documentation/graphics/apicture.jpeg` and want to link to it from
`docs/documentation/index.md` you can do so as follows:

```
[This points at a picture](graphics/apicture.jpeg)
```

To include it as a picture you would use the following code:

```
![This is a picture](graphics/apicture.jpeg)
```

### In Graphviz dot format

You can store graphics in graphviz'
[dot](http://www.graphviz.org/content/dot-language) format. The Makefile will
take care of compiling them to SVG. You can link to them just as you'd link to
static content. Just substitute the `.dot` extension by `.svg`, e.g. to link
link to the SVG file resulting from `docs/documentation/apicture.dot` from the
file `docs/documentation/index.md` you would use the following code:

```
[This points at the picture compiled from graphics/apicture.dot](graphics/apicture.svg)
```

`[This is the picture compiled from graphics/apicture.dot](graphics/apicture.svg)`

To include it as a picture you would use the following code:

[This points at the picture compiled from graphics/apicture.dot](graphics/apicture.svg)


## Additional Markdown Features

We use a few Markdown extensions that provide us with the following
functionality:

### Include Directive

You can include arbitrary Markdown files from a central markdown file (similar
to the C preprocessor's `#include` or LaTeX's `\input` directive. This
is useful for structuring documentation.

Use the following syntax for including files:

```
{!<filename>!}
```

Where <filename> is a path relative to the `docs/` directory.

Example:

```
{!documentation/howto.md!}
```

This would insert the content of the file `docs/documentation/howto.md` at
build time.

### Comments

If you add HTML style comments beginning with 3 dashes they will not show up in
the generated HTML:

```
<!---
Editor's note: comment text liberally.
-->
```

This can be used for communication between author and reviewer or TODO comments
in the text.

### Internal links

Relative links (without a leading slash, e.g. `graphics/apicture.jpeg`) are
always relative to the current file's location. Absolute links (with a leading
slash but without the protocol/domain part, e.g.  /documentation/graphics/apicture.jpeg)

### Reusable Links

If you use the same external link multiple times you can define reference style
links in `docs/macros.md`. For this to work it needs to be included with the
following directive in each chapter's index.md:

```
{!macros.md!}
```

In macros.md you can define a link as follows...

```
[example]: http://www.example.com
```

...and insert it in any document that pulls in `macros.md` as follows:

```
[This link leads to example.com][example]
```

### Tables

You can create tables as follows:

```
| left header | right header |
|-|-|
| Table cell content | More cell content |
| Even more cell content | |
```

This uses python-markdown's
[tables](https://pythonhosted.org/Markdown/extensions/tables.html) extension.

Pitfalls:

* The header line must be present (its cells can be empty, though)
* The separator line (i.e. the table's second line) must be present and contain
  at least one dash in each cell.
* Each table row must be on one line.

### Table of Contents

You can add the `[TOC]` directive anywhere in a chapter to insert an
automatically generated table of contents for this chapter. Usually we do this
at the top of a chapter's `index.md`.
