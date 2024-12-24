#!/bin/bash

alias python="python3"
alias apt-list="aptitude search '~i!~M'"
alias mkvenv="sudo python3 -m venv .venv/"
alias activenv="source $PWD/.venv/bin/activate"
alias rmvenv="rm -rf .venv/"
alias pip="pip3"
alias update="paru && gup update && cargo install-update --all && flatpak update"
