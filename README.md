# utils
Various bash scripts to ensure my experience in the terminal remains consistent whatever computer or server I'm using.

# installing

* clone this repository in to whatever folder
* add `source /path/to/whatever-folder/_all.bash` (or just the ones you like) in your `.profile` or `.bash_profile`

# contents

### `_all.bash`

This just loads all other files in here.

### `aliases.bash`

Contains general aliases I'm used to like using `la` to mean `ls -la`.

### `completions.bash`

* Sets up auto complete for git via `~/.git-completion.bash`
* Sets up auto complete for ssh based on `~/.ssh/known_hosts` and `~/.ssh/config`

### `dock.bash`

Sets up shortcuts for my commonly used docker commands. It also provides features like filtering and formatting the way i like it.

### `exports.bash`

Ensures my terminal looks exactly how I like it to look. Also makes `vim` the default editor.

![Imgur](https://i.imgur.com/IiLmAXF.png)

### `git.bash`

Sets up git aliases I'm used to as well as default values for me.
