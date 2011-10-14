Description
===========

This cookbook provides a library to extend the current Chef package provider to support the Solaris Image Packaging System (IPS).

Requirements
============

## Platforms

At present this cookbook is designed to work on the Atalanta Systems Solaris hosting platform.  This is pre-bootstrapped to use IPS also known as pkg(5).

This provider should work on OpenSolaris, Solaris 11 and OpenIndiana, but has only been tested on Solaris 10 with IPS.

Recipes
=======

default
-------

The default recipe currently takes no action, as the only platform it has been used on already has IPS installed.

Resources/Providers
===================

The libarary `ips_package.rb` extends the default provider to provide the install and uninstall actions.  In the current version there is no 'upgrade' action and no 'purge' action.

Usage
=====

Ensure the `ips` cookbook is at the of the run list to provide access to this provider to all subsequent recipes.

Changes/Roadmap
===============

## Future

* Ideally this should go into upstream Chef, so this cookbook/library may not have a future.
* Extend the provider to support upgrades and named versions

## 1.0.0:

* Initial release

License and Author
==================

Author:: Atalanta Systems (<support@atalanta-systems.com>)

Copyright:: 2011, Atalanta Systems Ltd