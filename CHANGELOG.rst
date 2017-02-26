Nomad formula
=============

0.0.3 (2017-02-26)

- Added gcc dependency to build Nomad from source.
- Added integration tests with Test Kitchen, testinfra, and Travis CI.
- Added golang-formula as test dependency.
- Fixed binary ownership when installed from binary to match installed from source.
- Fixed documentation regarding data removal during uninstallation.

0.0.2 (2017-02-13)

- Support for installing from official binaries on amd64 and arm platforms.
- Changed default installation method to install the official binaries instead 
  of building Nomad from source on officially supported platforms.
- Changed deployment to stop service before installing a new binary or new
  service definition.

0.0.1 (2017-02-06)

- Initial version of the Nomad formula.
