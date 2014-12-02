# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
umask 022

# if running bash
if test -n "${BASH_VERSION}" ; then
    # include .bashrc if it exists
    if test -f "${HOME}/.bashrc" ; then
	. "${HOME}/.bashrc"
    fi
fi

# We assume the user's private bin exists because we are using pathfilter
PATH=$(${HOME}/bin/pathfilter \
    "${HOME}/bin:/usr/local/sbin:/usr/local/bin:${PATH}:/usr/sbin:/sbin")
export HOST=$(uname -n)

if test -f "${HOME}/.extra_login" ; then
    . ${HOME}/.extra_login
fi
