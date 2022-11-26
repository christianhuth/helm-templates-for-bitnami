# Helm Templates and Named Templates for using Bitnami Database Charts

This repository contains Templates and Named Templates for using Bitnami Database Charts ([MariaDB](https://artifacthub.io/packages/helm/bitnami/mariadb), [MySQL](https://artifacthub.io/packages/helm/bitnami/mysql), [PostgreSQL](https://artifacthub.io/packages/helm/bitnami/postgresql) and [Redis](https://artifacthub.io/packages/helm/bitnami/redis)) as a dependency in your own Helm Charts.

They are an implementation of the concepts I have explained in this [blog article](https://blog.knell.it/best-way-to-use-bitnamis-database-helm-charts/).

## Variants

- [Redis](https://github.com/christianknell/helm-templates-for-bitnami/tree/main/redis)
- [One database](https://github.com/christianknell/helm-templates-for-bitnami/tree/main/one-database/)
  - [MariaDB only](https://github.com/christianknell/helm-templates-for-bitnami/tree/main/one-database/mariadb-only)
  - [MySQL only](https://github.com/christianknell/helm-templates-for-bitnami/tree/main/one-database/mysql-only)
  - [PostgreSQL only](https://github.com/christianknell/helm-templates-for-bitnami/tree/main/one-database/postgresql-only)
- [Multiple databases](https://github.com/christianknell/helm-templates-for-bitnami/tree/main/multiple-databases/)
  - [MariaDB and MySQL](https://github.com/christianknell/helm-templates-for-bitnami/tree/main/multiple-databases/mariadb-and-mysql)
  - [MariaDB and PostgreSQL](https://github.com/christianknell/helm-templates-for-bitnami/tree/main/multiple-databases/mariadb-and-postgresql)
  - [MySQL and PostgreSQL](https://github.com/christianknell/helm-templates-for-bitnami/tree/main/multiple-databases/mysql-and-postgresql)
  - [MariaDB, MySQL and PostgreSQL](https://github.com/christianknell/helm-templates-for-bitnami/tree/main/multiple-databases/mariadb-mysql-and-postgresql)
