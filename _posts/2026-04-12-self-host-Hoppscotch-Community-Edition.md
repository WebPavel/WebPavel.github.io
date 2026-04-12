---
layout: post
title: "Self-host Hoppscotch Community Edition"
date: 2026-04-12
excerpt: "Self-host Hoppscotch Community Edition on your own infrastructure with full data ownership."
tags: [ Hoppscotch, Self-Host, Docker ]
comments: true
---

# Self-host Hoppscotch Community Edition

Self-host Hoppscotch Community Edition on your own infrastructure with full data ownership.

You can install and run Hoppscotch on any operating system that can run
a [Docker Engine](https://docs.docker.com/engine).

## Install Docker

It is recommended to use [Docker Compose](https://docs.docker.com/compose/) to define and run multi-container
applications.

- [Docker installation guide](https://docs.docker.com/engine/install)
- [Install Docker Compose](https://docs.docker.com/compose/install/)

Verify Docker installation by running the following command in your terminal:

```shell
docker -v
docker compose version
```

## Install Hoppscotch

Once the instance of Hoppscotch is up, you need to run migrations on the database to ensure that it has the relevant
tables.

Note: Please use the following command to run the migration.

```shell
pnpm exec prisma migrate deploy && node /usr/src/app/aio_run.mjs
```

Once the migration has been successfully run and the database populated with tables, the backend containers can be
started normally.

```yaml
services:
    hoppscotch-db:
        image: postgres:15
        restart: unless-stopped
        ports:
            - "5432:5432"
        # set shared memory limit when using docker compose
        shm_size: 128mb
        # or set shared memory limit when deploy via swarm stack
        #volumes:
        #  - type: tmpfs
        #    target: /dev/shm
        #    tmpfs:
        #      size: 134217728 # 128*2^20 bytes = 128Mb
        environment:
            - TZ=${TZ:-Asia/Shanghai}
            - LANG=${LANG:-en_US.utf8}
            - POSTGRES_USER=postgres
            # NOTE: Please UPDATE THIS PASSWORD!
            - POSTGRES_PASSWORD=testpass
            - POSTGRES_DB=hoppscotch
        healthcheck:
            test: [
                "CMD-SHELL",
                "sh -c 'pg_isready -U $${POSTGRES_USER} -d $${POSTGRES_DB}'",
            ]
            interval: 5s
            timeout: 3s
            retries: 5
            start_period: 10s
        volumes:
            - "$PWD/hoppscotch-db/data:/var/lib/postgresql/data"

    # https://docs.hoppscotch.io/documentation/self-host/community-edition/getting-started
    hoppscotch:
        image: hoppscotch/hoppscotch
        restart: unless-stopped
        ports:
            - "3000:3000"
            # admin dashboard port
            - "3100:3100"
            - "3170:3170"
            # To enable desktop app support for your self-hosted Hoppscotch instance
            - "3200:3200"
        environment:
            #-----------------------Backend Config------------------------------#

            # Prisma Config
            - DATABASE_URL=postgresql://postgres:testpass@hoppscotch-db:5432/hoppscotch?connect_timeout=300 # or replace with your database URL
            # (Optional) By default, the AIO container (when in subpath access mode) exposes the endpoint on port 80. Use this setting to specify a different port if needed.
            - HOPP_AIO_ALTERNATE_PORT=80

            # Sensitive Data Encryption Key while storing in Database (32 character)
            - DATA_ENCRYPTION_KEY=D5FD2F9558AB49279AEEC2EE65EFEFEC # uuidgen | tr -d '-'

            # Whitelisted origins for the Hoppscotch App.
            # This list controls which origins can interact with the app through cross-origin comms.
            # - localhost ports (3170, 3000, 3100): app, backend, development servers and services
            # - app://localhost_3200: Bundle server origin identifier
            #   NOTE: `3200` here refers to the bundle server (port 3200) that provides the bundles,
            #   NOT where the app runs. The app itself uses the `app://` protocol with dynamic
            #   bundle names like `app://{bundle-name}/`
            - WHITELISTED_ORIGINS=http://localhost:3170,http://localhost:3000,http://localhost:3100,app://localhost_3200,app://hoppscotch

            #-----------------------Frontend Config------------------------------#

            # Base URLs
            - VITE_BASE_URL=http://localhost:3000
            - VITE_SHORTCODE_BASE_URL=http://localhost:3000
            - VITE_ADMIN_URL=http://localhost:3100

            # Backend URLs
            - VITE_BACKEND_GQL_URL=http://localhost:3170/graphql
            - VITE_BACKEND_WS_URL=wss://localhost:3170/graphql
            - VITE_BACKEND_API_URL=http://localhost:3170/v1

            # Terms Of Service And Privacy Policy Links (Optional)
            - VITE_APP_TOS_LINK=https://docs.hoppscotch.io/support/terms
            - VITE_APP_PRIVACY_POLICY_LINK=https://docs.hoppscotch.io/support/privacy

            # Set to `true` for subpath based access
            - ENABLE_SUBPATH_BASED_ACCESS=false
        depends_on:
            hoppscotch-db:
                condition: service_healthy
        command: [
            "sh",
            "-c",
            "pnpm exec prisma migrate deploy && node /usr/src/app/aio_run.mjs",
        ]
        healthcheck:
            test: [
                "CMD",
                "curl",
                "-f",
                "-s",
                "-o",
                "/dev/null",
                "-w",
                "'%{http_code}\n'",
                "http://localhost:3000",
            ]
            interval: 2s
            timeout: 10s
            retries: 30
            start_period: 10s

```

### Setup and access

#### Create an administrator account

1. Open a new browser tab and visit [http://localhost:3100](http://localhost:3100).
2. This will grant you access to the admin dashboard.
3. Login using your credentials or create a new account.
4. The first user to log in will be given administrator privileges.

#### With SMTP

- Select authentication methods for your Hoppscotch instance: **SMTP**.

- Add auth configurations using custom SMTP configurations

| requirement             | description                                               | format                                                                   |
|-------------------------|-----------------------------------------------------------|--------------------------------------------------------------------------|
| Mailer From Address     | Subject + ` ` + <email address\>                          | Hoppscotch <user@126.com\>                                               |
| SMTP Host               | Address of your SMTP server                               | smtp.126.com                                                             |
| SMTP Port               | Communication port used by your SMTP server               | `587` for **TLS** or `465` for **SSL**                                   |
| SMTP User               | Username for your SMTP account                            | your email address, user@126.com                                         |
| SMTP Password           | Corresponding password for your SMTP account              | custompass                                                               |
| SMTP Secure             | Whether to use TLS from the start                         | default value: not checked.<br>checked, if `true`, connect to port `465` |
| SMTP Ignore TLS         | if `true`, the connection remains unencrypted.            | keep default value: not checked                                          |
| TLS Reject Unauthorized | set `false` to accept self-signed or invalid certificates | keep default value: not checked                                          |

#### Hard reset configurations

If you need to perform a hard reset of the server configurations, execute the following command in your terminal to
reset all your environment variables.

```shell
psql -U postgres -d hoppscotch -c "TRUNCATE \"InfraConfig\";"
```

#### Access the Hoppscotch app

1. Open a new browser tab and visit [http://localhost:3000](http://localhost:3000).
2. Begin testing and developing your APIs seamlessly with Hoppscotch.

## Reference

- [self-hosting documentation](https://docs.hoppscotch.io/documentation/self-host/getting-started)
- [Hoppscotch](https://github.com/hoppscotch/hoppscotch)
- [Nodemailer](https://nodemailer.com/)
