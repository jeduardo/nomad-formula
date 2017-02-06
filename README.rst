=============
nomad-formula
=============

A saltstack formula created to setup `Hashicorp's Nomad
<https://www.nomadproject.io>`_ on a single machine or in a machine cluster.

.. note::

    This formula was primarily tested on Raspbian deployments.
    It also requires golang to be installed in all target machines, as it builds
    Nomad from source.
    Finally, Nomad must run as root for it to be able to use all execution
    drivers.


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

Remove the service, binaries, data, and configuration files.

This is state must always be called independently.
