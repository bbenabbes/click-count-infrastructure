# Click Count Infrastructure

[![Build Status](https://travis-ci.org/bbenabbes/click-count-infrastructure.svg?branch=master)](https://travis-ci.org/bbenabbes/click-count-infrastructure)

This project allows you to configure and deploy, via Ansible, the click count application 
infrastructure (illustrated below) on servers provisioned automatically via Vagrant and VirtualBox:

                       ---------------------------------
                      |  clickcount (Apache Tomcat)     |
                      |  192.168.2.3                    |
                       ---------------------------------
                                      |
                       ---------------------------------
                      |  db (Redis)                     |
                      |  192.168.2.4                    |
                       ---------------------------------

*IP addresses and hostnames in this diagram are modeled after VirtualBox/Vagrant-based VMs.* 

**Apache Tomcat** is an open source implementation of a web container that allows you to run 
web applications based on technologies servlets and JSP.

**Redis** is used to persist application data.

## Prerequisites

Before you can run any of these playbooks, you will need to 
[install Ansible](http://docs.ansible.com/intro_installation.html), and run the following 
command to download dependencies (from within the same directory as this README file):

    $ ansible-galaxy install -r requirements.yml

If you would like to build the infrastructure locally, you will also need to install 
the latest versions of [VirtualBox](https://www.virtualbox.org/wiki/Downloads) and 
[Vagrant](https://www.vagrantup.com/downloads.html).

## Provision infrastructure and deploy application

To build the VMs and configure them using Ansible, follow these steps:

  1. Run `vagrant up`.
  2. Run `ansible-playbook configure.yml -e artifact="/path/to/war/file/to/be/deployed`.

After everything is booted, configured and deployed, visit http://clickcount/ (if you 
configured the domain in your hosts file with the line `192.168.2.2  clickcount`) 
in a browser.
