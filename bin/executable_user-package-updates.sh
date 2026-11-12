#!/bin/sh

rustup update
cargo install-update -a
flatpak update --user
/usr/bin/pkill -SIGUSR2 i3status-rs
