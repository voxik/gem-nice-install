# gem-nice-install

A RubyGems plugin that improves gem installation user experience.

## usage

You don't need to do nothing special, just use 'gem install' as you always do. gem-nice-install will not stand in your way, but it will try to install system dependencies needed to install your gems with binary extensions.

Please note, that the currently, only Fedora is supported. However, it should be pretty forward to add support for your favorite system in similar manner.

## bundler

To make bundler to use this gem as well, you need to load the rubygems_plugin before. The easiest way is to make an alias in your `~/.bashrc` or so:

```
alias bundle='RUBYOPT="-rrubygems/nice_install" bundle'
```

## license

This software is licensed under terms of MIT license.
