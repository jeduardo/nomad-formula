=============
nomad-formula
=============

A saltstack formula created to setup `Hashicorp's Nomad
<https://www.nomadproject.io>`_ on a single machine or in a machine cluster.

.. notes::

    It is mandatory to have Go installed on a machine that will build Nomad.
    Nomad must run as root for it to be able to use all execution drivers.

.. image:: https://travis-ci.org/saltstack-formulas/nomad-formula.svg?branch=master
    :target: https://travis-ci.org/saltstack-formulas/nomad-formula


Available states
================

.. contents::
    :local:

``init``
--------

The essential Nomad state running both ``install`` and ``config``.

``install``
------------

Install the Nomad package from source, and register the appropriate service
definition with systemd.

This state can be called independently.

``config``
-----------

Deploy the configuration files required to run the service, and enable the
service if configured to do so.

Configuration is done through the ``nomad`` pillar.

This state can be called independently.

``uninstall``
-------------

Remove the service, binaries, and configuration files. The data itself will be kept and needs
to be removed manually, just to be on the safe side.

This is state must always be called independently.
