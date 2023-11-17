# Config Files

My configurations of various software I use (or used to use). Feel free to copy whatever you find helpful.

# Setup

Many of these directories should be placed in your `$XDG_CONFIG_HOME` directory (most of the time `$HOME/.config`). Others are more ad-hoc and depend on which base system they're on, so I won't specify anything for those here.

There are several tools to manage dotfiles. Mine are simple enough, so I prefer to just create symlinks for them, e.g.

```sh
ln -s "$HOME/dotfiles/nvim" "$HOME/.config/nvim"
```
