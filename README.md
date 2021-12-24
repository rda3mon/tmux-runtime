# Tmux configuration
Customized, self-contained tmux customization with many unique features

# Table of contents
* [Installation](#installation)
* [Features](#features)
  * [Remote connection](#remote-connection)
  * [Status line](#status-line)
  * [Copy Mode](#copy-mode)
* [Key bindings](#key-bindings)

## Installation

1) Clone the repository

`git clone git@github.com:rda3mon/tmux.git ~/.tmux_runtime`

2) Install tmux

`ln -s ~/.tmux_runtime/tmux.conf ~/.tmux.conf && tmux source-file ~/.tmux.conf`

## Features

**1) Duplicate ssh sessions:** This will be very useful if you often work on remote machines. With a single keypress, you will be able to login to the same remote machine.

![GIF](resources/gifs/duplicate_session.gif)

**2) Custom pane title:** Pane title has a lot of information about the what is going on in that particular pane. More information is available if pane is running a ssh connection to a remote host.

* Parent Process ID of the pane shell
* Command that is running
* Process id of the command
* CPU, memory and load factor by that process
* If ssh into a remote box, cpu memory and load factor of the remote instance

![GIF](resources/gifs/pane_title.gif)

**3) Copy paste functionality:** Copy paste works in 2 modes.

NOTE: Works only if you have `xclip` installed. 

* Using Vi Mode: This config has vi mode enabled, using short cuts. `<prefix> + [` to enter into vi mode and once selection is done, press `Enter` to copy text into clipboard

* Using Mouse: In this mode, you can drag using mouse to select any text, at the end of mouse drag release, the selected text will be copied to clipboard

![GIF](resources/gifs/copy_mode.gif)

**4) Customized shortcuts:** Lot of convenient shortcuts were added which are listed below

## Key bindings

The power of tmux comes from its configurability and every action can be controlled by key-bindings. Here are the list of keybindings which are configured with this configuration. `prefix` means <kbd>ctrl</kbd> + <kbd>a</kbd> pressed together.


* `prefix`: <kbd>ctrl</kbd> + <kbd>a</kbd>. If you are using tmux, you are well aware of `prefix`.
* `prefix` + `?`: All of the key-bindings are availble here, you need not visit this page at all.
* `prefix` + `r`: Reload tmux config to pick up the latest one.
* `prefix` + C-p: Show copy buffer last 10 items

Session related bindings

* `prefix` + `$`: Rename session
* `prefix` + `d`: Detach the tmux session
* `prefix` + `s`: Show tmux sessions
* `prefix` + `(`: Switch previous session and rotate backwords
* `prefix` + `)`: Switch next session and rotate forwards

Window related bindings

* `prefix` + `c`: Create a new window and switch to it
* `prefix` + `n`: Rotate to next window
* `prefix` + `p`: Rotate to previous window
* `prefix` + `0` to `9`: To go to specific window
* `prefix` + `,`: Rename current window

Pane related bindings

* `prefix` + `"`: Split pane vertically
* `prefix` + `%`: Split pane horizontally
* `prefix` + `!`: Move current pane to new window
* `prefix` + `q`: Show pane numbers
* `prefix` + `x`: Kill selected pane
* `prefix` + `space`: To change pane layout
* `prefix` + `{`: To move pane left
* `prefix` + `}`: To move pane right
* `prefix` + `z`: To toggle pane zoom
* `prefix` + `C-d`: Duplicate pane with copy command of what is currently running. Such as ssh into some instance. `C-d` means you have to press <kbd>Ctrl</kbd> + <kbd>d</kbd> together.
* `prefix` + `C-p`: Toggle logging of current pane to `/tmp/tmux_{pane_pid}.log`
* `prefix` + `C-s`: Toggle pane synchronisation. Meaning type on all panes together.

Copy mode related bindings

* `prefix` + `[`: Enter Copy mode. In this mode, you can perform following sub commands
  * `?`: Search upwards
  * `/`: Search downwards
  * `v`: vi visual mode for text selection
  * `y`: vi copy text
  * `r`: vi rectangle copy
  * `q`: quit copy mode
  * `C-u`: Page up
  * `C-d`: Page down
  * Most of the vi navigation key-bindings work here, such as `h`, `j`, `k`, `l`, `n`, `N`, etc

Misc bindings. Following are without prefix

* `Meta` + `1` to `Meta` + `9`: For selecting windows from 1 to 9
* `Ctrl` + `up` / `down` / `left` / `right`: For navigating between panes
