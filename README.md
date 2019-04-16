# Tools.sh

This is a simple bash script that allows you to have a collection of bash commands without needing to remember the things.

In some cases, commands are too big to be put in an alias. And if you have a lot of aliases, it can be hard to remember all of them. That's why I created this tool. It allows me to group some commands together without needing to remeber all of them.

## Installation

1. Clone this repository
2. cd into the project directory
3. `chmod +x tools.sh`
4. `ln -s "$(pwd)/tools.sh" /usr/local/bin/tools`

## Usage

### Show all commands

```bash
❯ tools

Available commands
-------------------------

#### acme ####
acme:foo
        Description of acme foo command
acme:bar
        A shor intro about acme:bar

#### example ####
example:foo
        Description of example foo command
example:bar
  
#### util ####
util:create-command
        Create a new command for this tools script
```

### Show all commands in a namespace

```bash
❯ tools util

#### util ####
util:create-command
        Create a new command for this tools script

```

### Execute a command

```bash
❯ tools util:create-command
```

### Create a new command

```bash
❯ tools util:create-command
What namespace do you want to use
git
What action name do you want to use
remove new files
Give a short description for the command
Remove new files from a git repo

Command git:remove-new-files has been created.
```

The file can be found in `./git/remove-new-files.sh` and can be executed using `tools git:remove-new-files`.

## How it works

Each namespace has its own folder in the project root. So if you create a new namespace, a new folder is created.  
The commands for a workspace are separate files in the namespace folder.

For example: The `util:create-command` command links to `./util/create-command.sh`

Only the code in the `performAction` funcion will be executed.

## Todo

- Make things case insensitive
- Add basic commands by default as example