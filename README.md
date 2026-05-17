# homebrew-tap

Homebrew tap for small macOS utilities.

## ddc-mirror

```sh
brew install emin93/tap/ddc-mirror
brew services start ddc-mirror
```

`ddc-mirror` mirrors the active built-in display brightness to external DDC/CI monitors. It has no UI, hotkeys, or display management.

Optional external display calibration:

```sh
defaults write ch.emin.ddc-mirror externalBrightnessOffset -float 0.10
brew services restart ddc-mirror
```
