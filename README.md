# Ansible THREDDS clustering

[![Build Status](https://travis-ci.org/SantanderMetGroup/ansible-thredds-cluster.svg?branch=devel)](https://travis-ci.org/SantanderMetGroup/ansible-thredds-cluster)

The THREDDS project is developing middleware to bridge the gap between
data providers and data users. The goal is to simplify the discovery and
use of scientific data and to allow scientific publications and
educational materials to reference scientific data. Due to THREDDS’s
lack of horizontal scalability and automatic configuration management
and deployment, this service usually deals with service downtimes and
time consuming configuration tasks, mainly when an intensive use is done
as is usual within the scientific community (e.g. climate).

This project aims to improve the scalability of the THREDDS Data Server
through the implementation of a cluster of TDS instances that are
deployed in the backend and that are only visible from the outside
through a reverse proxy in the frontend. This project also aims to
improve the management of the TDS catalogs by partitioning the hierarchy
of catalogs into multiple TDS instances that are deployed in the
backend, allowing high availability of the datasets and tackling the
current problem of large waiting times after performing a THREDDS reinit
when publishing new catalogs.

This solution is based on Ansible playbooks, used to automate the
deployment and management of the agents that conform the cluster. The
playbooks are based on modules (or roles) of different backends and
frontends load balancing setups and solutions. This implementation
allows to configure different infrastructure and deployment setups, as
more workers are easily added to the cluster by simply declaring them as
Ansible variables and executing the playbooks.

## Roles

Roles deploy the underlying infrastructure required to deploy specific scenarios for the end-user. They accept variables to customize deployments.

## Scenarios

Scenarios are concrete use cases that make use of roles to create end-user deployments.

## Utils

`utils/test-authentication.yml` is a playbook that configures a simple setup in the THREDDS instances for testing of authentication and authorization. This playbooks creates a user named "alice" with password "1234" who has access to the datasets in the collection2 (see data/ directory).

## Tests

Run `cd tests && ./test.sh` to test deployments using Docker containers.

## Development files

server.crt was generated using: (see https://gist.github.com/croxton/ebfb5f3ac143cd86542788f972434c96)

```bash
openssl req -new -sha256 -out server.csr -key insecure_private_key -config san.cnf
openssl x509 -req -sha256 -days 3650 -in server.csr -signkey insecure_private_key -out server.crt -extensions req_ext -extfile san.cnf
openssl x509 -in server.crt -out server.pem -outform PEM
openssl pkcs12 -export -in server.pem -inkey insecure_private_key -out server.p12 -name lxdock -CAfile server.pem -caname root -chain
```
