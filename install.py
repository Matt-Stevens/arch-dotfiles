#!/usr/bin/env python

"""
Safe (no clobbering and atomic) installation of Arch Dotfiles.

Monday, 20 March 09:30:32 GMT 2017
"""
__author__ = 'Matt Deacalion Stevens'


from pathlib import Path
import os
import sys
import subprocess


install_dir = Path(os.path.expanduser('~'))


def get_file_state(filename, install_path, dotfile_path):
    target = install_path / ('.' + filename)
    dotfile = str(dotfile_path / filename)

    if not target.exists():
        return 'free'
    else:
        if target.is_symlink() and os.readlink(str(target)) == dotfile:
            return 'installed'
        else:
            return 'clash'


class Output:
    BOLD = '\033[1m'
    GREEN = '\033[92m'
    ORANGE = '\033[93m'
    RED = '\033[91m'
    END = '\033[0m'

    @classmethod
    def status_output(cls, dotfiles, states_to_show=None):
        print_msgs = {
            'clash': 'Clashes with existing file',
            'free': 'Installed',
            'installed': 'Already installed',
        }
        print_funcs = {
            'clash': cls.fail,
            'free': cls.ok,
            'installed': cls.warning,
        }
        to_show = {}

        if states_to_show is None:
            states_to_show = ['clash', 'free', 'installed']

        for dotfile, state in dotfiles.items():
            if state in states_to_show:
                to_show[dotfile] = state

        longest = len(max(to_show.keys(), key=len)) + 5

        for dotfile, state in to_show.items():
            print_funcs[state](
                '{:.<{}} {}'.format(
                    dotfile,
                    longest,
                    print_msgs[state],
                )
            )

    @classmethod
    def ok(cls, text):
        print(cls.BOLD + cls.GREEN + text + cls.END)

    @classmethod
    def warning(cls, text):
        print(cls.BOLD + cls.ORANGE + text + cls.END)

    @classmethod
    def fail(cls, text):
        print(cls.BOLD + cls.RED + text + cls.END)


# Run from curl
if sys.argv[0] == '-':
    subprocess.run(['git', 'clone', 'git@github.com:Matt-Deacalion/arch-dotfiles.git'])
    repo_dir = Path.cwd() / 'arch-dotfiles'
# Run from the repo
else:
    repo_dir = Path(__file__).parent.resolve()

dotfiles_dir = repo_dir / 'dotfiles'
dotfiles = {}

for dotfile in os.listdir(dotfiles_dir):
    dotfiles[dotfile] = get_file_state(dotfile, install_dir, dotfiles_dir)

states = set(dotfiles.values())

if 'clash' in states:
    Output.status_output(dotfiles, ['clash'])
    print('\nFile clash, Arch dotfiles installation aborted.')
else:
    if 'free' in states:
        for f, state in dotfiles.items():
            if state == 'free':
                os.symlink(dotfiles_dir / f, install_dir / ('.' + f))

        Output.status_output(dotfiles)
        print('\nInstalled Arch dotfiles successfully.')
        print('Now read "~/.vimrc" to see how to set up Vim.')
    else:
        Output.status_output(dotfiles)
        print('\nArch dotfiles already installed.')
