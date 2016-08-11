dotfiles
========

yup, finally

Using [dotbot](https://github.com/anishathalye/dotbot) to manage, err... my dotfiles ;)

Just clone and run *./.install* (configuration on *.install.conf.yaml*)

branches
--------
I've eliminated the concept of HOME/WORK branches, now will create branches per machine.

'Why?' you can ask. Well, it's nice to do substantial adjustments on my master branch (common things, you know), and keep branches updated with that (like key bindings and common environment variables settings).

Scripts
------
There are some scripts bundled on my dotfiles (more like "helpers"), related to specific things (e.g. managing audio volume on i3).  
For other scripts, see my [dotbins repo](https://github.com/rodrigogolive/dotbins) ;)

Note for Slackware users
------------------------

As my main operating system is [Slackware](http://www.slackware.com/), I let some packages I've built for my own use on my server. They are built against slackware-current x86_64, and you can grab them on the following links:
* [i3](http://thecoreme.org/slack/pkgs/x86_64/i3/): also including some additional tools
* [mutt](http://thecoreme.org/slack/pkgs/x86_64/mutt/): based on the [official SlackBuild](http://mirrors.slackware.com/slackware/slackware64-current/source/n/mutt/), just applying some additional patches, [see here](http://thecoreme.org/slack/pkgs/SlackBuilds/mutt.tar.xz) my version (with patches from [mutt-sidebar](https://aur.archlinux.org/packages/mutt-sidebar/))
