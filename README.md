# tmpmail

[![lint](https://github.com/jonlabelle/tmpmail/actions/workflows/lint.yml/badge.svg)](https://github.com/jonlabelle/tmpmail/actions/workflows/lint.yml)

> *Temporary email from the terminal.*

## What does it do?

[tmpmail] creates a temporary email address for *receiving* messages right from
the terminal. It's a command-line utility written in POSIX sh and uses the
[1secmail API].

## Dependencies

[w3m](https://www.commandlinux.com/man-page/man1/w3m.1.html), [curl](https://curl.se), [jq](https://stedolan.github.io/jq/)

... and of course [tmpmail].

## Installation

### Downloading

First, you'll need to clone [this repository](https://github.com/jonlabelle/tmpmail):

```bash
git clone https://github.com/jonlabelle/tmpmail.git
```

### Installing

Installing will grab latest version of [tmpmail] and symlink it to
`~/bin/tmpmail`. `cd` to the `tmpmail/` directory and run the install script
with the `-i` option:

```bash
bash install.sh -i
```

### Uninstalling

To uninstall the `~/bin/tmpmail` symlink, `cd` to the `tmpmail/` directory and
run the install script with the `-u` option:

```bash
bash install.sh -u
```

## Usage

```bash
$ tmpmail
tmpmail -h | --version
tmpmail -g [ADDRESS]
tmpmail [-t | -b BROWSER] -r | ID

When called with no option and no argument, tmpmail lists the messages in
the inbox and their numeric IDs.  When called with one argument, tmpmail
shows the email message with specified ID.

-b, --browser BROWSER
        Specify BROWSER (default: w3m) that is used to render the HTML of
        the email
-g, --generate [ADDRESS]
        Generate a new email address, either the specified ADDRESS, or
        randomly create one
-h, --help
        Show help
-r, --recent
        View the most recent email message
-t, --text
        View the email as raw text, where all the HTML tags are removed.
        Without this option, HTML is used.
--version
        Show version
```

## Examples

```bash
# To create a temporary/random email inbox:
tmpmail --generate

# To use a custom email inbox:
tmpmail --generate mycustomemail@1secmail.com

# To list messages and their numeric ID:
tmpmail

# To display the most recent received email:
tmpmail --recent

# To open a specific message:
tmpmail <email_id>

# To view email as raw text without HTML tags:
tmpmail --text <email_id>

# To open email with a specific browser (default is w3m):
tmpmail --browser <browser> <email_id>
```

[tmpmail]: https://github.com/sdushantha/tmpmail
[1secmail API]: https://www.1secmail.com/api/
