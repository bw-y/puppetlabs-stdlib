# Class: stdlib::stages
#
# This class manages a standard set of run stages for Puppet. It is managed by
# the stdlib class, and should not be declared independently.
#
# The high level stages are (in order):
#
#  * setup
#  * main
#  * runtime
#  * jdk
#  * jdk_app
#
# Parameters: none
#
# Actions:
#
#   Declares various run-stages for deploying infrastructure,
#   language runtimes, and application layers.
#
# Requires: nothing
#
# Sample Usage:
#
#  node default {
#    include stdlib
#    class { java: stage => 'runtime' }
#  }
#
class stdlib::stages {

  stage { 'setup':  before => Stage['main'] }
  stage { 'runtime': require => Stage['main'] } -> 
  stage { 'db': } ->
  stage { 'db_app': } -> 
  stage { 'jdk': } -> 
  stage { 'java_app': } 

}
