# Helm Templates and Named Templates for using Bitnami Database Charts

This repository contains Templates and Named Templates for using Bitnami Database Charts ([MariaDB](https://artifacthub.io/packages/helm/bitnami/mariadb), [MySQL](https://artifacthub.io/packages/helm/bitnami/mysql), [PostgreSQL](https://artifacthub.io/packages/helm/bitnami/postgresql) and [Redis](https://artifacthub.io/packages/helm/bitnami/redis)) as a dependency in your own Helm Charts.

They are an implementation of the concepts I have explained in this [blog article](https://blog.knell.it/best-way-to-use-bitnamis-database-helm-charts/).

## Variants

- [Redis](https://github.com/christianknell/helm-templates-for-bitnami/tree/main/redis)
- [One database](https://github.com/christianknell/helm-templates-for-bitnami/tree/main/one-database/)
  - [MariaDB only]
  - [MySQL only]
  - [PostgreSQL only](https://github.com/christianknell/helm-templates-for-bitnami/tree/main/one-database/postgresql-only)
- [Multiple databases]
  - [MariaDB and MySQL]
  - [MariaDB and PostgreSQL]
  - [MySQL and PostgreSQL]
  - [MariaDB, MySQL and PostgreSQL]
