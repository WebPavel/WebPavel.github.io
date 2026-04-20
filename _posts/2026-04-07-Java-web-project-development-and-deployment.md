---
layout: post
title: "Java web project development and deployment"
date: 2026-04-07
excerpt: "Java web project development and deployment reply on several runtime environments and build tools."
tags: [ Java, development, deployment ]
comments: true
---

# Java web project development and deployment

Java web project development and deployment reply on several runtime environments and build tools.

## Prerequisites

| app        | version           | homepage                                            | download (* recommended)                                                                                                                                                                                                                                                                                                                                                                       |
|------------|-------------------|-----------------------------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| JDK        | 8                 | https://www.oracle.com/java/technologies/java8.html | https://www.oracle.com/java/technologies/downloads/#java8 (*login required*)                                                                                                                                                                                                                                                                                                                   |
| Maven      | 3.6.3             | https://maven.apache.org/                           | [macOS/Linux](https://archive.apache.org/dist/maven/maven-3/3.6.3/binaries/apache-maven-3.6.3-bin.tar.gz)<br>[Windows](https://archive.apache.org/dist/maven/maven-3/3.6.3/binaries/apache-maven-3.6.3-bin.zip)                                                                                                                                                                                |
| Docker     | latest            | https://www.docker.com/                             | [macOS](https://desktop.docker.com/mac/main/arm64/Docker.dmg)<br>[Windows](https://desktop.docker.com/win/main/amd64/Docker%20Desktop%20Installer.exe)<br>[Linux](https://desktop.docker.com/linux/main/amd64/docker-desktop-amd64.deb)                                                                                                                                                        |
| MySQL      | 5.7               | https://www.mysql.com/                              | [Windows](https://dev.mysql.com/get/Downloads/MySQLInstaller/mysql-installer-community-5.7.44.0.msi)<br>[Linux](https://downloads.mysql.com/archives/get/p/23/file/mysql-5.7.44-linux-glibc2.12-x86_64.tar.gz)<br>[Docker](https://hub.docker.com/_/mysql)*                                                                                                                                    |
| Postgres   | 15.x              | https://www.postgresql.org/                         | [macOS](https://get.enterprisedb.com/postgresql/postgresql-15.17-2-osx.dmg)<br>[Windows](https://get.enterprisedb.com/postgresql/postgresql-15.17-2-windows-x64.exe)<br>[Docker](https://hub.docker.com/_/postgres)*                                                                                                                                                                           |
| Redis      | 5.x               | https://redis.io/open-source/                       | [macOS](https://redis.io/docs/latest/operate/oss_and_stack/install/install-stack/homebrew/)<br>[Docker](https://hub.docker.com/_/redis)*                                                                                                                                                                                                                                                       |
| RabbitMQ   | 3.13.6-management | https://www.rabbitmq.com/                           | [macOS/Linux](https://github.com/rabbitmq/rabbitmq-server/releases/download/v3.13.6/rabbitmq-server-generic-unix-3.13.6.tar.xz)<br>[Windows](https://github.com/rabbitmq/rabbitmq-server/releases/download/v3.13.6/rabbitmq-server-3.13.6.exe)<br>[Docker](https://hub.docker.com/_/rabbitmq/)*                                                                                                |
| nginx      | 1.27.0            | https://nginx.org/                                  | [Windows](https://nginx.org/download/nginx-1.27.0.zip)<br>[Linux](https://nginx.org/download/nginx-1.27.0.tar.gz)<br>[Docker](https://hub.docker.com/_/nginx)*                                                                                                                                                                                                                                 |
| Jenkins    | 2.516.1-lts-jdk17 | https://www.jenkins.io/                             | [macOS](https://www.jenkins.io/download/lts/macos)<br>[Windows](https://get.jenkins.io/windows-stable/2.516.1/jenkins.msi)<br>[Linux](https://www.jenkins.io/doc/book/installing/linux/)<br>[Docker](https://hub.docker.com/r/jenkins/jenkins)                                                                                                                                                 |
| Postman    | 9.31.x            | https://www.postman.com/                            | [macOS](https://go.pstmn.io/dl-macos-arm64-v9-latest)<br>[Windows](https://go.pstmn.io/dl-win64-v9-latest)<br>[Linux](https://go.pstmn.io/dl-linux64-v9-latest)                                                                                                                                                                                                                                |
| Hoppscotch | latest(2026.3.1)  | https://hoppscotch.com/                             | [macOS](https://github.com/hoppscotch/releases/releases/latest/download/Hoppscotch_mac_aarch64.dmg)<br>[Windows](https://github.com/hoppscotch/releases/releases/latest/download/Hoppscotch_win_x64.msi)<br>[Linux](https://github.com/hoppscotch/releases/releases/latest/download/Hoppscotch_linux_x64.deb)<br>[Docker](https://docs.hoppscotch.io/documentation/self-host/getting-started)* |
| Ollama     | 0.20.5            | https://ollama.com/                                 | [macOS](https://github.com/ollama/ollama/releases/download/v0.20.5/Ollama.dmg)<br>[Windows](https://github.com/ollama/ollama/releases/download/v0.20.5/OllamaSetup.exe)<br>[Linux](https://github.com/ollama/ollama/releases/download/v0.20.5/ollama-linux-amd64.tar.zst)<br>[Docker](https://hub.docker.com/r/ollama/ollama)*                                                                 |

### Install and build

```shell
docker pull --platform linux/amd64 mysql:5.7.44
docker pull --platform linux/arm64 postgres:15.14
docker pull --platform linux/arm64 redis:5.0.14
docker pull --platform linux/arm64 rabbitmq:3.13.6-management
docker pull --platform linux/arm64 nginx:1.27.0
docker pull --platform linux/arm64 mysql:8.4.2
docker pull --platform linux/arm64 jenkins/jenkins:2.516.1-lts-jdk17
docker pull --platform linux/arm64 hoppscotch/hoppscotch:2026.3.1
docker pull --platform linux/arm64 ollama/ollama:0.20.5
docker save -o mysql-5.7.44-x64.tar mysql:5.7.44
docker save -o postgres-15.14.tar postgres:15.14
docker save -o redis-5.0.14.tar redis:5.0.14
docker save -o rabbitmq-3.13.6-management.tar rabbitmq:3.13.6-management
docker save -o nginx-1.27.0.tar nginx:1.27.0
docker save -o mysql-8.4.2.tar mysql:8.4.2
docker save -o jenkins-lts-2.516.1-lts-jdk17.tar jenkins/jenkins:2.516.1-lts-jdk17
docker save -o hoppscotch-2026.3.1.tar hoppscotch/hoppscotch:2026.3.1
docker save -o ollama-0.20.5.tar ollama/ollama:0.20.5
docker load -i ./mysql-5.7.44-x64.tar
docker load -i ./postgres-15.14.tar
docker load -i ./redis-5.0.14.tar
docker load -i ./rabbitmq-3.13.6-management.tar
docker load -i ./nginx-1.27.0.tar
docker load -i ./mysql-8.4.2.tar
docker load -i ./jenkins-lts-2.516.1-lts-jdk17.tar
docker load -i ./hoppscotch-2026.3.1.tar
docker load -i ./ollama-0.20.5.tar
docker compose -f ./docker-compose.yaml -p demo up -d
docker compose -f ./docker-compose.yaml -p demo down
```

docker-compose.yaml (or compose.yaml)

```yaml
services:
    postgres:
        image: postgres:15.14
        platform: linux/arm64
        restart: always
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
            - POSTGRES_PASSWORD=bE4h22sYSp86XLan
            - POSTGRES_DB=cloudlab
        healthcheck:
            test: [
                "CMD-SHELL",
                "sh -c 'pg_isready -U $${POSTGRES_USER} -d $${POSTGRES_DB}'"
            ]
            interval: 5s
            timeout: 3s
            retries: 5
            start_period: 10s
        volumes:
            - "$PWD/postgres/data:/var/lib/postgresql/data"

    hoppscotch-db:
        image: postgres:15.14
        platform: linux/arm64
        restart: unless-stopped
        ports:
            - "35432:5432"
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
        image: hoppscotch/hoppscotch:2026.3.1
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

    # https://docs.ollama.com/docker
    ollama:
        image: ollama/ollama:0.20.5
        restart: unless-stopped
        ports:
            - "11434:11434"
        environment:
            - TZ=${TZ:-Asia/Shanghai}
            - LANG=${LANG:-en_US.utf8}
        volumes:
            - "$PWD/ollama:/root/.ollama"

    # https://redis.io/tutorials/operate/orchestration/docker/
    redis:
        image: redis:5.0.14
        restart: unless-stopped
        ports:
            - "6379:6379"
        environment:
            - TZ=${TZ:-Asia/Shanghai}
            - LANG=${LANG:-en_US.utf8}
            - REDIS_ARGS=--requirepass your_password --appendonly yes
        volumes:
            - "$PWD/redis:/data"
        command: [
            "sh",
            "-c",
            "redis-server --requirepass your_password --appendonly yes",
        ]
        healthcheck:
            test: [
                "CMD-SHELL",
                "sh -c 'redis-cli -h 127.0.0.1 -p 6379 -a your_password PING'",
            ]
            interval: 5s
            timeout: 3s
            retries: 5
            start_period: 10s

```

> **Note**:
> run the command `uuidgen | tr -d '-'` to generate 32 characters.

## Common file types

Common file types in Java web project development.

* Script
  - .sh, .ps1, .bat, .cmd, .vbs
* XML
  - .xml
* JSON
  - .json
* YAML
  - .yml, .yaml
* HTML
  - .html
* JavaScript
  - .js, .ts, .vue
* CSS
  - .css
* Markdown
  - .md
* Java
  - .java

| file           | type           | description                                                                                                                                                                     |
|----------------|----------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| .editorconfig  | .editorconfig  | EditorConfig defines rules for how to format different programming languages or other structured text files with conventions, which aims to maintain a consistent coding style. |
| .gitignore     | .gitignore     | A `gitignore` file specifies intentionally untracked files that Git should ignore.                                                                                              |
| .gitattributes | .gitattributes | A `gitattributes` file is a simple text file that gives `attributes` to pathnames.                                                                                              |
| LICENSE.txt    | LICENSE        | Licenses grant the recipient the rights to use the software, examine the source code, modify it, and distribute the modifications.                                              |
| README.md      | README         | A README file contains descriptive and important information about the content of a repository.                                                                                 |
| robots.txt     | robots.txt     | A robots.txt file is a set of guidelines for `bots`, such as `web crawlers` that scan content on webpages all over the Internet.                                                |

### .editorconfig

```editorconfig
root = true

[*]
charset = utf-8
end_of_line = lf
indent_size = 4
indent_style = space
insert_final_newline = false
max_line_length = 120
tab_width = 4
ij_continuation_indent_size = 8
ij_formatter_off_tag = @formatter:off
ij_formatter_on_tag = @formatter:on
ij_formatter_tags_enabled = false
ij_smart_tabs = false
ij_visual_guides = none
ij_wrap_on_typing = false

[*.css]
ij_css_align_closing_brace_with_properties = false
ij_css_blank_lines_around_nested_selector = 1
ij_css_blank_lines_between_blocks = 1
ij_css_brace_placement = end_of_line
ij_css_enforce_quotes_on_format = false
ij_css_hex_color_long_format = false
ij_css_hex_color_lower_case = false
ij_css_hex_color_short_format = false
ij_css_hex_color_upper_case = false
ij_css_keep_blank_lines_in_code = 2
ij_css_keep_indents_on_empty_lines = false
ij_css_keep_single_line_blocks = false
ij_css_properties_order = font,font-family,font-size,font-weight,font-style,font-variant,font-size-adjust,font-stretch,line-height,position,z-index,top,right,bottom,left,display,visibility,float,clear,overflow,overflow-x,overflow-y,clip,zoom,align-content,align-items,align-self,flex,flex-flow,flex-basis,flex-direction,flex-grow,flex-shrink,flex-wrap,justify-content,order,box-sizing,width,min-width,max-width,height,min-height,max-height,margin,margin-top,margin-right,margin-bottom,margin-left,padding,padding-top,padding-right,padding-bottom,padding-left,table-layout,empty-cells,caption-side,border-spacing,border-collapse,list-style,list-style-position,list-style-type,list-style-image,content,quotes,counter-reset,counter-increment,resize,cursor,user-select,nav-index,nav-up,nav-right,nav-down,nav-left,transition,transition-delay,transition-timing-function,transition-duration,transition-property,transform,transform-origin,animation,animation-name,animation-duration,animation-play-state,animation-timing-function,animation-delay,animation-iteration-count,animation-direction,text-align,text-align-last,vertical-align,white-space,text-decoration,text-emphasis,text-emphasis-color,text-emphasis-style,text-emphasis-position,text-indent,text-justify,letter-spacing,word-spacing,text-outline,text-transform,text-wrap,text-overflow,text-overflow-ellipsis,text-overflow-mode,word-wrap,word-break,tab-size,hyphens,pointer-events,opacity,color,border,border-width,border-style,border-color,border-top,border-top-width,border-top-style,border-top-color,border-right,border-right-width,border-right-style,border-right-color,border-bottom,border-bottom-width,border-bottom-style,border-bottom-color,border-left,border-left-width,border-left-style,border-left-color,border-radius,border-top-left-radius,border-top-right-radius,border-bottom-right-radius,border-bottom-left-radius,border-image,border-image-source,border-image-slice,border-image-width,border-image-outset,border-image-repeat,outline,outline-width,outline-style,outline-color,outline-offset,background,background-color,background-image,background-repeat,background-attachment,background-position,background-position-x,background-position-y,background-clip,background-origin,background-size,box-decoration-break,box-shadow,text-shadow
ij_css_space_after_colon = true
ij_css_space_before_opening_brace = true
ij_css_use_double_quotes = true
ij_css_value_alignment = do_not_align

[*.java]
ij_java_align_consecutive_assignments = false
ij_java_align_consecutive_variable_declarations = false
ij_java_align_group_field_declarations = false
ij_java_align_multiline_annotation_parameters = false
ij_java_align_multiline_array_initializer_expression = false
ij_java_align_multiline_assignment = false
ij_java_align_multiline_binary_operation = false
ij_java_align_multiline_chained_methods = false
ij_java_align_multiline_extends_list = false
ij_java_align_multiline_for = true
ij_java_align_multiline_method_parentheses = false
ij_java_align_multiline_parameters = true
ij_java_align_multiline_parameters_in_calls = false
ij_java_align_multiline_parenthesized_expression = false
ij_java_align_multiline_records = true
ij_java_align_multiline_resources = true
ij_java_align_multiline_ternary_operation = false
ij_java_align_multiline_text_blocks = false
ij_java_align_multiline_throws_list = false
ij_java_align_subsequent_simple_methods = false
ij_java_align_throws_keyword = false
ij_java_annotation_parameter_wrap = off
ij_java_array_initializer_new_line_after_left_brace = false
ij_java_array_initializer_right_brace_on_new_line = false
ij_java_array_initializer_wrap = off
ij_java_assert_statement_colon_on_next_line = false
ij_java_assert_statement_wrap = off
ij_java_assignment_wrap = off
ij_java_binary_operation_sign_on_next_line = false
ij_java_binary_operation_wrap = off
ij_java_blank_lines_after_anonymous_class_header = 0
ij_java_blank_lines_after_class_header = 0
ij_java_blank_lines_after_imports = 1
ij_java_blank_lines_after_package = 1
ij_java_blank_lines_around_class = 1
ij_java_blank_lines_around_field = 0
ij_java_blank_lines_around_field_in_interface = 0
ij_java_blank_lines_around_initializer = 1
ij_java_blank_lines_around_method = 1
ij_java_blank_lines_around_method_in_interface = 1
ij_java_blank_lines_before_class_end = 0
ij_java_blank_lines_before_imports = 1
ij_java_blank_lines_before_method_body = 0
ij_java_blank_lines_before_package = 0
ij_java_block_brace_style = end_of_line
ij_java_block_comment_at_first_column = true
ij_java_builder_methods = none
ij_java_call_parameters_new_line_after_left_paren = false
ij_java_call_parameters_right_paren_on_new_line = false
ij_java_call_parameters_wrap = off
ij_java_case_statement_on_separate_line = true
ij_java_catch_on_new_line = false
ij_java_class_annotation_wrap = split_into_lines
ij_java_class_brace_style = end_of_line
ij_java_class_count_to_use_import_on_demand = 50
ij_java_class_names_in_javadoc = 1
ij_java_do_not_indent_top_level_class_members = false
ij_java_do_not_wrap_after_single_annotation = false
ij_java_do_while_brace_force = never
ij_java_doc_add_blank_line_after_description = true
ij_java_doc_add_blank_line_after_param_comments = false
ij_java_doc_add_blank_line_after_return = false
ij_java_doc_add_p_tag_on_empty_lines = true
ij_java_doc_align_exception_comments = true
ij_java_doc_align_param_comments = true
ij_java_doc_do_not_wrap_if_one_line = false
ij_java_doc_enable_formatting = true
ij_java_doc_enable_leading_asterisks = true
ij_java_doc_indent_on_continuation = false
ij_java_doc_keep_empty_lines = true
ij_java_doc_keep_empty_parameter_tag = true
ij_java_doc_keep_empty_return_tag = true
ij_java_doc_keep_empty_throws_tag = true
ij_java_doc_keep_invalid_tags = true
ij_java_doc_param_description_on_new_line = false
ij_java_doc_preserve_line_breaks = false
ij_java_doc_use_throws_not_exception_tag = true
ij_java_else_on_new_line = false
ij_java_enum_constants_wrap = off
ij_java_extends_keyword_wrap = off
ij_java_extends_list_wrap = off
ij_java_field_annotation_wrap = split_into_lines
ij_java_finally_on_new_line = false
ij_java_for_brace_force = never
ij_java_for_statement_new_line_after_left_paren = false
ij_java_for_statement_right_paren_on_new_line = false
ij_java_for_statement_wrap = off
ij_java_generate_final_locals = false
ij_java_generate_final_parameters = false
ij_java_if_brace_force = never
ij_java_imports_layout = *,|,javax.**,java.**,|,$*
ij_java_indent_case_from_switch = true
ij_java_insert_inner_class_imports = false
ij_java_insert_override_annotation = true
ij_java_keep_blank_lines_before_right_brace = 2
ij_java_keep_blank_lines_between_package_declaration_and_header = 2
ij_java_keep_blank_lines_in_code = 2
ij_java_keep_blank_lines_in_declarations = 2
ij_java_keep_builder_methods_indents = false
ij_java_keep_control_statement_in_one_line = true
ij_java_keep_first_column_comment = true
ij_java_keep_indents_on_empty_lines = false
ij_java_keep_line_breaks = true
ij_java_keep_multiple_expressions_in_one_line = false
ij_java_keep_simple_blocks_in_one_line = false
ij_java_keep_simple_classes_in_one_line = false
ij_java_keep_simple_lambdas_in_one_line = false
ij_java_keep_simple_methods_in_one_line = false
ij_java_label_indent_absolute = false
ij_java_label_indent_size = 0
ij_java_lambda_brace_style = end_of_line
ij_java_layout_static_imports_separately = true
ij_java_line_comment_add_space = true
ij_java_line_comment_at_first_column = false
ij_java_method_annotation_wrap = split_into_lines
ij_java_method_brace_style = end_of_line
ij_java_method_call_chain_wrap = off
ij_java_method_parameters_new_line_after_left_paren = false
ij_java_method_parameters_right_paren_on_new_line = false
ij_java_method_parameters_wrap = off
ij_java_modifier_list_wrap = false
ij_java_names_count_to_use_import_on_demand = 30
ij_java_new_line_after_lparen_in_record_header = false
ij_java_packages_to_use_import_on_demand = java.awt.*,javax.swing.*
ij_java_parameter_annotation_wrap = off
ij_java_parentheses_expression_new_line_after_left_paren = false
ij_java_parentheses_expression_right_paren_on_new_line = false
ij_java_place_assignment_sign_on_next_line = false
ij_java_prefer_longer_names = true
ij_java_prefer_parameters_wrap = false
ij_java_record_components_wrap = normal
ij_java_repeat_synchronized = true
ij_java_replace_instanceof_and_cast = false
ij_java_replace_null_check = true
ij_java_replace_sum_lambda_with_method_ref = true
ij_java_resource_list_new_line_after_left_paren = false
ij_java_resource_list_right_paren_on_new_line = false
ij_java_resource_list_wrap = off
ij_java_rparen_on_new_line_in_record_header = false
ij_java_space_after_closing_angle_bracket_in_type_argument = false
ij_java_space_after_colon = true
ij_java_space_after_comma = true
ij_java_space_after_comma_in_type_arguments = true
ij_java_space_after_for_semicolon = true
ij_java_space_after_quest = true
ij_java_space_after_type_cast = true
ij_java_space_before_annotation_array_initializer_left_brace = false
ij_java_space_before_annotation_parameter_list = false
ij_java_space_before_array_initializer_left_brace = false
ij_java_space_before_catch_keyword = true
ij_java_space_before_catch_left_brace = true
ij_java_space_before_catch_parentheses = true
ij_java_space_before_class_left_brace = true
ij_java_space_before_colon = true
ij_java_space_before_colon_in_foreach = true
ij_java_space_before_comma = false
ij_java_space_before_do_left_brace = true
ij_java_space_before_else_keyword = true
ij_java_space_before_else_left_brace = true
ij_java_space_before_finally_keyword = true
ij_java_space_before_finally_left_brace = true
ij_java_space_before_for_left_brace = true
ij_java_space_before_for_parentheses = true
ij_java_space_before_for_semicolon = false
ij_java_space_before_if_left_brace = true
ij_java_space_before_if_parentheses = true
ij_java_space_before_method_call_parentheses = false
ij_java_space_before_method_left_brace = true
ij_java_space_before_method_parentheses = false
ij_java_space_before_opening_angle_bracket_in_type_parameter = false
ij_java_space_before_quest = true
ij_java_space_before_switch_left_brace = true
ij_java_space_before_switch_parentheses = true
ij_java_space_before_synchronized_left_brace = true
ij_java_space_before_synchronized_parentheses = true
ij_java_space_before_try_left_brace = true
ij_java_space_before_try_parentheses = true
ij_java_space_before_type_parameter_list = false
ij_java_space_before_while_keyword = true
ij_java_space_before_while_left_brace = true
ij_java_space_before_while_parentheses = true
ij_java_space_inside_one_line_enum_braces = false
ij_java_space_within_empty_array_initializer_braces = false
ij_java_space_within_empty_method_call_parentheses = false
ij_java_space_within_empty_method_parentheses = false
ij_java_spaces_around_additive_operators = true
ij_java_spaces_around_assignment_operators = true
ij_java_spaces_around_bitwise_operators = true
ij_java_spaces_around_equality_operators = true
ij_java_spaces_around_lambda_arrow = true
ij_java_spaces_around_logical_operators = true
ij_java_spaces_around_method_ref_dbl_colon = false
ij_java_spaces_around_multiplicative_operators = true
ij_java_spaces_around_relational_operators = true
ij_java_spaces_around_shift_operators = true
ij_java_spaces_around_type_bounds_in_type_parameters = true
ij_java_spaces_around_unary_operator = false
ij_java_spaces_within_angle_brackets = false
ij_java_spaces_within_annotation_parentheses = false
ij_java_spaces_within_array_initializer_braces = false
ij_java_spaces_within_braces = false
ij_java_spaces_within_brackets = false
ij_java_spaces_within_cast_parentheses = false
ij_java_spaces_within_catch_parentheses = false
ij_java_spaces_within_for_parentheses = false
ij_java_spaces_within_if_parentheses = false
ij_java_spaces_within_method_call_parentheses = false
ij_java_spaces_within_method_parentheses = false
ij_java_spaces_within_parentheses = false
ij_java_spaces_within_record_header = false
ij_java_spaces_within_switch_parentheses = false
ij_java_spaces_within_synchronized_parentheses = false
ij_java_spaces_within_try_parentheses = false
ij_java_spaces_within_while_parentheses = false
ij_java_special_else_if_treatment = true
ij_java_subclass_name_suffix = Impl
ij_java_ternary_operation_signs_on_next_line = false
ij_java_ternary_operation_wrap = off
ij_java_test_name_suffix = Test
ij_java_throws_keyword_wrap = off
ij_java_throws_list_wrap = off
ij_java_use_external_annotations = false
ij_java_use_fq_class_names = false
ij_java_use_relative_indents = false
ij_java_use_single_class_imports = true
ij_java_variable_annotation_wrap = off
ij_java_visibility = public
ij_java_while_brace_force = never
ij_java_while_on_new_line = false
ij_java_wrap_comments = false
ij_java_wrap_first_method_in_call_chain = false
ij_java_wrap_long_lines = false

[.editorconfig]
ij_editorconfig_align_group_field_declarations = false
ij_editorconfig_space_after_colon = false
ij_editorconfig_space_after_comma = true
ij_editorconfig_space_before_colon = false
ij_editorconfig_space_before_comma = false
ij_editorconfig_spaces_around_assignment_operators = true

[{*.ant,*.fxml,*.jhm,*.jnlp,*.jrxml,*.pom,*.qrc,*.rng,*.tld,*.wadl,*.wsdd,*.wsdl,*.xjb,*.xml,*.xsd,*.xsl,*.xslt,*.xul}]
ij_xml_align_attributes = true
ij_xml_align_text = false
ij_xml_attribute_wrap = normal
ij_xml_block_comment_at_first_column = true
ij_xml_keep_blank_lines = 2
ij_xml_keep_indents_on_empty_lines = false
ij_xml_keep_line_breaks = true
ij_xml_keep_line_breaks_in_text = true
ij_xml_keep_whitespaces = false
ij_xml_keep_whitespaces_around_cdata = preserve
ij_xml_keep_whitespaces_inside_cdata = false
ij_xml_line_comment_at_first_column = true
ij_xml_space_after_tag_name = false
ij_xml_space_around_equals_in_attribute = false
ij_xml_space_inside_empty_tag = false
ij_xml_text_wrap = normal

[{*.bash,*.sh,*.zsh}]
indent_size = 2
tab_width = 2
ij_shell_binary_ops_start_line = false
ij_shell_keep_column_alignment_padding = false
ij_shell_minify_program = false
ij_shell_redirect_followed_by_space = false
ij_shell_switch_cases_indented = false
ij_shell_use_unix_line_separator = true

[{*.cjs,*.js}]
ij_continuation_indent_size = 4
ij_javascript_align_imports = false
ij_javascript_align_multiline_array_initializer_expression = false
ij_javascript_align_multiline_binary_operation = false
ij_javascript_align_multiline_chained_methods = false
ij_javascript_align_multiline_extends_list = false
ij_javascript_align_multiline_for = true
ij_javascript_align_multiline_parameters = true
ij_javascript_align_multiline_parameters_in_calls = false
ij_javascript_align_multiline_ternary_operation = false
ij_javascript_align_object_properties = 0
ij_javascript_align_union_types = false
ij_javascript_align_var_statements = 0
ij_javascript_array_initializer_new_line_after_left_brace = false
ij_javascript_array_initializer_right_brace_on_new_line = false
ij_javascript_array_initializer_wrap = off
ij_javascript_assignment_wrap = off
ij_javascript_binary_operation_sign_on_next_line = false
ij_javascript_binary_operation_wrap = off
ij_javascript_blacklist_imports = rxjs/Rx,node_modules/**,**/node_modules/**,@angular/material,@angular/material/typings/**
ij_javascript_blank_lines_after_imports = 1
ij_javascript_blank_lines_around_class = 1
ij_javascript_blank_lines_around_field = 0
ij_javascript_blank_lines_around_function = 1
ij_javascript_blank_lines_around_method = 1
ij_javascript_block_brace_style = end_of_line
ij_javascript_call_parameters_new_line_after_left_paren = false
ij_javascript_call_parameters_right_paren_on_new_line = false
ij_javascript_call_parameters_wrap = off
ij_javascript_catch_on_new_line = false
ij_javascript_chained_call_dot_on_new_line = true
ij_javascript_class_brace_style = end_of_line
ij_javascript_comma_on_new_line = false
ij_javascript_do_while_brace_force = never
ij_javascript_else_on_new_line = false
ij_javascript_enforce_trailing_comma = keep
ij_javascript_extends_keyword_wrap = off
ij_javascript_extends_list_wrap = off
ij_javascript_field_prefix = _
ij_javascript_file_name_style = relaxed
ij_javascript_finally_on_new_line = false
ij_javascript_for_brace_force = never
ij_javascript_for_statement_new_line_after_left_paren = false
ij_javascript_for_statement_right_paren_on_new_line = false
ij_javascript_for_statement_wrap = off
ij_javascript_force_quote_style = false
ij_javascript_force_semicolon_style = false
ij_javascript_function_expression_brace_style = end_of_line
ij_javascript_if_brace_force = never
ij_javascript_import_merge_members = global
ij_javascript_import_prefer_absolute_path = global
ij_javascript_import_sort_members = true
ij_javascript_import_sort_module_name = false
ij_javascript_import_use_node_resolution = true
ij_javascript_imports_wrap = on_every_item
ij_javascript_indent_case_from_switch = true
ij_javascript_indent_chained_calls = true
ij_javascript_indent_package_children = 0
ij_javascript_jsx_attribute_value = braces
ij_javascript_keep_blank_lines_in_code = 2
ij_javascript_keep_first_column_comment = true
ij_javascript_keep_indents_on_empty_lines = false
ij_javascript_keep_line_breaks = true
ij_javascript_keep_simple_blocks_in_one_line = false
ij_javascript_keep_simple_methods_in_one_line = false
ij_javascript_line_comment_add_space = true
ij_javascript_line_comment_at_first_column = false
ij_javascript_method_brace_style = end_of_line
ij_javascript_method_call_chain_wrap = off
ij_javascript_method_parameters_new_line_after_left_paren = false
ij_javascript_method_parameters_right_paren_on_new_line = false
ij_javascript_method_parameters_wrap = off
ij_javascript_object_literal_wrap = on_every_item
ij_javascript_parentheses_expression_new_line_after_left_paren = false
ij_javascript_parentheses_expression_right_paren_on_new_line = false
ij_javascript_place_assignment_sign_on_next_line = false
ij_javascript_prefer_as_type_cast = false
ij_javascript_prefer_explicit_types_function_expression_returns = false
ij_javascript_prefer_explicit_types_function_returns = false
ij_javascript_prefer_explicit_types_vars_fields = false
ij_javascript_prefer_parameters_wrap = false
ij_javascript_reformat_c_style_comments = false
ij_javascript_space_after_colon = true
ij_javascript_space_after_comma = true
ij_javascript_space_after_dots_in_rest_parameter = false
ij_javascript_space_after_generator_mult = true
ij_javascript_space_after_property_colon = true
ij_javascript_space_after_quest = true
ij_javascript_space_after_type_colon = true
ij_javascript_space_after_unary_not = false
ij_javascript_space_before_async_arrow_lparen = true
ij_javascript_space_before_catch_keyword = true
ij_javascript_space_before_catch_left_brace = true
ij_javascript_space_before_catch_parentheses = true
ij_javascript_space_before_class_lbrace = true
ij_javascript_space_before_class_left_brace = true
ij_javascript_space_before_colon = true
ij_javascript_space_before_comma = false
ij_javascript_space_before_do_left_brace = true
ij_javascript_space_before_else_keyword = true
ij_javascript_space_before_else_left_brace = true
ij_javascript_space_before_finally_keyword = true
ij_javascript_space_before_finally_left_brace = true
ij_javascript_space_before_for_left_brace = true
ij_javascript_space_before_for_parentheses = true
ij_javascript_space_before_for_semicolon = false
ij_javascript_space_before_function_left_parenth = true
ij_javascript_space_before_generator_mult = false
ij_javascript_space_before_if_left_brace = true
ij_javascript_space_before_if_parentheses = true
ij_javascript_space_before_method_call_parentheses = false
ij_javascript_space_before_method_left_brace = true
ij_javascript_space_before_method_parentheses = false
ij_javascript_space_before_property_colon = false
ij_javascript_space_before_quest = true
ij_javascript_space_before_switch_left_brace = true
ij_javascript_space_before_switch_parentheses = true
ij_javascript_space_before_try_left_brace = true
ij_javascript_space_before_type_colon = false
ij_javascript_space_before_unary_not = false
ij_javascript_space_before_while_keyword = true
ij_javascript_space_before_while_left_brace = true
ij_javascript_space_before_while_parentheses = true
ij_javascript_spaces_around_additive_operators = true
ij_javascript_spaces_around_arrow_function_operator = true
ij_javascript_spaces_around_assignment_operators = true
ij_javascript_spaces_around_bitwise_operators = true
ij_javascript_spaces_around_equality_operators = true
ij_javascript_spaces_around_logical_operators = true
ij_javascript_spaces_around_multiplicative_operators = true
ij_javascript_spaces_around_relational_operators = true
ij_javascript_spaces_around_shift_operators = true
ij_javascript_spaces_around_unary_operator = false
ij_javascript_spaces_within_array_initializer_brackets = false
ij_javascript_spaces_within_brackets = false
ij_javascript_spaces_within_catch_parentheses = false
ij_javascript_spaces_within_for_parentheses = false
ij_javascript_spaces_within_if_parentheses = false
ij_javascript_spaces_within_imports = false
ij_javascript_spaces_within_interpolation_expressions = false
ij_javascript_spaces_within_method_call_parentheses = false
ij_javascript_spaces_within_method_parentheses = false
ij_javascript_spaces_within_object_literal_braces = false
ij_javascript_spaces_within_object_type_braces = true
ij_javascript_spaces_within_parentheses = false
ij_javascript_spaces_within_switch_parentheses = false
ij_javascript_spaces_within_type_assertion = false
ij_javascript_spaces_within_union_types = true
ij_javascript_spaces_within_while_parentheses = false
ij_javascript_special_else_if_treatment = true
ij_javascript_ternary_operation_signs_on_next_line = false
ij_javascript_ternary_operation_wrap = off
ij_javascript_union_types_wrap = on_every_item
ij_javascript_use_chained_calls_group_indents = false
ij_javascript_use_double_quotes = true
# ij_javascript_use_explicit_js_extension = global
ij_javascript_use_explicit_js_extension = auto
ij_javascript_use_path_mapping = always
ij_javascript_use_public_modifier = false
ij_javascript_use_semicolon_after_statement = true
ij_javascript_var_declaration_wrap = normal
ij_javascript_while_brace_force = never
ij_javascript_while_on_new_line = false
ij_javascript_wrap_comments = false

[{*.har,*.jsb2,*.jsb3,*.json,.babelrc,.eslintrc,.stylelintrc,bowerrc,jest.config}]
indent_size = 2
ij_json_keep_blank_lines_in_code = 0
ij_json_keep_indents_on_empty_lines = false
ij_json_keep_line_breaks = true
ij_json_space_after_colon = true
ij_json_space_after_comma = true
ij_json_space_before_colon = true
ij_json_space_before_comma = false
ij_json_spaces_within_braces = false
ij_json_spaces_within_brackets = false
ij_json_wrap_long_lines = false

[{*.htm,*.html,*.ng,*.sht,*.shtm,*.shtml}]
ij_html_add_new_line_before_tags = body,div,p,form,h1,h2,h3
ij_html_align_attributes = true
ij_html_align_text = false
ij_html_attribute_wrap = normal
ij_html_block_comment_at_first_column = true
ij_html_do_not_align_children_of_min_lines = 0
ij_html_do_not_break_if_inline_tags = title,h1,h2,h3,h4,h5,h6,p
ij_html_do_not_indent_children_of_tags = html,body,thead,tbody,tfoot
ij_html_enforce_quotes = false
ij_html_inline_tags = a,abbr,acronym,b,basefont,bdo,big,br,cite,cite,code,dfn,em,font,i,img,input,kbd,label,q,s,samp,select,small,span,strike,strong,sub,sup,textarea,tt,u,var
ij_html_keep_blank_lines = 2
ij_html_keep_indents_on_empty_lines = false
ij_html_keep_line_breaks = true
ij_html_keep_line_breaks_in_text = true
ij_html_keep_whitespaces = false
ij_html_keep_whitespaces_inside = span,pre,textarea
ij_html_line_comment_at_first_column = true
ij_html_new_line_after_last_attribute = never
ij_html_new_line_before_first_attribute = never
ij_html_quote_style = double
ij_html_remove_new_line_before_tags = br
ij_html_space_after_tag_name = false
ij_html_space_around_equality_in_attribute = false
ij_html_space_inside_empty_tag = false
ij_html_text_wrap = normal

[{*.markdown,*.md}]
ij_markdown_force_one_space_after_blockquote_symbol = true
ij_markdown_force_one_space_after_header_symbol = true
ij_markdown_force_one_space_after_list_bullet = true
ij_markdown_force_one_space_between_words = true
ij_markdown_keep_indents_on_empty_lines = false
ij_markdown_max_lines_around_block_elements = 1
ij_markdown_max_lines_around_header = 1
ij_markdown_max_lines_between_paragraphs = 1
ij_markdown_min_lines_around_block_elements = 1
ij_markdown_min_lines_around_header = 1
ij_markdown_min_lines_between_paragraphs = 1

[{*.properties,spring.handlers,spring.schemas}]
ij_properties_align_group_field_declarations = false
ij_properties_keep_blank_lines = false
ij_properties_key_value_delimiter = equals
ij_properties_spaces_around_key_value_delimiter = false

[{*.yaml,*.yml}]
indent_size = 2
ij_yaml_align_values_properties = do_not_align
ij_yaml_autoinsert_sequence_marker = true
ij_yaml_block_mapping_on_new_line = false
ij_yaml_indent_sequence_value = true
ij_yaml_keep_indents_on_empty_lines = false
ij_yaml_keep_line_breaks = true
ij_yaml_sequence_on_new_line = false
ij_yaml_space_before_colon = false
ij_yaml_spaces_within_braces = true
ij_yaml_spaces_within_brackets = true

```

### .gitattributes

```text
# https://github.com/gitattributes/gitattributes
### Common ###
# Common settings that generally should always be used with your language specific settings

# Auto detect text files and perform LF normalization
*          text=auto

#
# The above will handle all files NOT found below
#

# Documents
*.bibtex   text diff=bibtex
*.doc      diff=astextplain
*.DOC      diff=astextplain
*.docx     diff=astextplain
*.DOCX     diff=astextplain
*.dot      diff=astextplain
*.DOT      diff=astextplain
*.pdf      diff=astextplain
*.PDF      diff=astextplain
*.rtf      diff=astextplain
*.RTF      diff=astextplain
*.md       text diff=markdown
*.mdx      text diff=markdown
*.tex      text diff=tex
*.adoc     text
*.textile  text
*.mustache text
*.csv      text eol=crlf
*.tab      text
*.tsv      text
*.txt      text
*.sql      text
*.epub     diff=astextplain

# Graphics
*.png      binary
*.jpg      binary
*.jpeg     binary
*.gif      binary
*.tif      binary
*.tiff     binary
*.ico      binary
# SVG treated as text by default.
*.svg      text
# If you want to treat it as binary,
# use the following line instead.
# *.svg    binary
*.eps      binary

# Scripts
*.bash     text eol=lf
*.fish     text eol=lf
*.ksh      text eol=lf
*.sh       text eol=lf
*.zsh      text eol=lf
# These are explicitly windows files and should use crlf
*.bat      text eol=crlf
*.cmd      text eol=crlf
*.ps1      text eol=crlf

# Serialisation
*.json     text
*.toml     text
*.xml      text
*.yaml     text
*.yml      text

# Archives
*.7z       binary
*.bz       binary
*.bz2      binary
*.bzip2    binary
*.gz       binary
*.lz       binary
*.lzma     binary
*.rar      binary
*.tar      binary
*.taz      binary
*.tbz      binary
*.tbz2     binary
*.tgz      binary
*.tlz      binary
*.txz      binary
*.xz       binary
*.Z        binary
*.zip      binary
*.zst      binary

# Text files where line endings should be preserved
*.patch    -text

#
# Exclude files from exporting
#

.gitattributes export-ignore
.gitignore     export-ignore
.gitkeep       export-ignore

### Java ###
# Java sources
*.java          text diff=java
*.kt            text diff=kotlin
*.groovy        text diff=java
*.scala         text diff=java
*.gradle        text diff=java
*.gradle.kts    text diff=kotlin

# These files are text and should be normalized (Convert crlf => lf)
*.css           text diff=css
*.scss          text diff=css
*.sass          text
*.df            text
*.htm           text diff=html
*.html          text diff=html
*.js            text
*.mjs           text
*.cjs           text
*.jsp           text
*.jspf          text
*.jspx          text
*.properties    text
*.tld           text
*.tag           text
*.tagx          text
*.xml           text

# These files are binary and should be left untouched
# (binary is a macro for -text -diff)
*.class         binary
*.dll           binary
*.ear           binary
*.jar           binary
*.so            binary
*.war           binary
*.jks           binary

# Common build-tool wrapper scripts ('.cmd' versions are handled by 'Common.gitattributes')
mvnw            text eol=lf
gradlew         text eol=lf

# These are explicitly windows files and should use crlf
*.bat           text eol=crlf

### Markdown ###
# Apply override to all files in the directory
*.md linguist-detectable

### PowerShell ###
# Basic .gitattributes for a PowerShell repo.

# Source files
# ============
*.ps1      text eol=crlf
*.ps1x     text eol=crlf
*.psm1     text eol=crlf
*.psd1     text eol=crlf
*.ps1xml   text eol=crlf
*.pssc     text eol=crlf
*.psrc     text eol=crlf
*.cdxml    text eol=crlf

### Web ###
## GITATTRIBUTES FOR WEB PROJECTS
#
# These settings are for any web project.
#
# Details per file setting:
#   text    These files should be normalized (i.e. convert CRLF to LF).
#   binary  These files are binary and should be left untouched.
#
# Note that binary is a macro for -text -diff.
######################################################################

# Auto detect
##   Handle line endings automatically for files detected as
##   text and leave all files detected as binary untouched.
##   This will handle all files NOT defined below.
*                 text=auto

# Source code
*.bash            text eol=lf
*.bat             text eol=crlf
*.cmd             text eol=crlf
*.coffee          text
*.css             text diff=css
*.htm             text diff=html
*.html            text diff=html
*.inc             text
*.ini             text
*.js              text
*.mjs             text
*.cjs             text
*.json            text
*.jsx             text
*.less            text
*.ls              text
*.map             text -diff
*.od              text
*.onlydata        text
*.php             text diff=php
*.pl              text
*.ps1             text eol=crlf
*.py              text diff=python
*.rb              text diff=ruby
*.sass            text
*.scm             text
*.scss            text diff=css
*.sh              text eol=lf
.husky/*          text eol=lf
*.sql             text
*.styl            text
*.tag             text
*.ts              text
*.tsx             text
*.xml             text
*.xhtml           text diff=html

# Docker
Dockerfile        text

# Documentation
*.ipynb           text eol=lf
*.markdown        text diff=markdown
*.md              text diff=markdown
*.mdwn            text diff=markdown
*.mdown           text diff=markdown
*.mkd             text diff=markdown
*.mkdn            text diff=markdown
*.mdtxt           text
*.mdtext          text
*.txt             text
AUTHORS           text
CHANGELOG         text
CHANGES           text
CONTRIBUTING      text
COPYING           text
copyright         text
*COPYRIGHT*       text
INSTALL           text
license           text
LICENSE           text
NEWS              text
readme            text
*README*          text
TODO              text

# Templates
*.dot             text
*.ejs             text
*.erb             text
*.haml            text
*.handlebars      text
*.hbs             text
*.hbt             text
*.jade            text
*.latte           text
*.mustache        text
*.njk             text
*.phtml           text
*.svelte          text
*.tmpl            text
*.tpl             text
*.twig            text
*.vue             text

# Configs
*.cnf             text
*.conf            text
*.config          text
.editorconfig     text
*.env             text
.gitattributes    text
.gitconfig        text
.htaccess         text
*.lock            text -diff
package.json      text eol=lf
package-lock.json text eol=lf -diff
pnpm-lock.yaml    text eol=lf -diff
.prettierrc       text
yarn.lock         text -diff
*.toml            text
*.yaml            text
*.yml             text
browserslist      text
Makefile          text
makefile          text
# Fixes syntax highlighting on GitHub to allow comments
tsconfig.json     linguist-language=JSON-with-Comments

# Heroku
Procfile          text

# Graphics
*.ai              binary
*.bmp             binary
*.eps             binary
*.gif             binary
*.gifv            binary
*.ico             binary
*.jng             binary
*.jp2             binary
*.jpg             binary
*.jpeg            binary
*.jpx             binary
*.jxr             binary
*.pdf             binary
*.png             binary
*.psb             binary
*.psd             binary
# SVG treated as an asset (binary) by default.
*.svg             text
# If you want to treat it as binary,
# use the following line instead.
# *.svg           binary
*.svgz            binary
*.tif             binary
*.tiff            binary
*.wbmp            binary
*.webp            binary

# Audio
*.kar             binary
*.m4a             binary
*.mid             binary
*.midi            binary
*.mp3             binary
*.ogg             binary
*.ra              binary

# Video
*.3gpp            binary
*.3gp             binary
*.as              binary
*.asf             binary
*.asx             binary
*.avi             binary
*.fla             binary
*.flv             binary
*.m4v             binary
*.mng             binary
*.mov             binary
*.mp4             binary
*.mpeg            binary
*.mpg             binary
*.ogv             binary
*.swc             binary
*.swf             binary
*.webm            binary

# Archives
*.7z              binary
*.gz              binary
*.jar             binary
*.rar             binary
*.tar             binary
*.zip             binary

# Fonts
*.ttf             binary
*.eot             binary
*.otf             binary
*.woff            binary
*.woff2           binary

# Executables
*.exe             binary
*.pyc             binary
# Prevents massive diffs caused by vendored, minified files
**/.yarn/releases/**   binary
**/.yarn/plugins/**    binary

# RC files (like .babelrc or .eslintrc)
*.*rc             text

# Ignore files (like .npmignore or .gitignore)
*.*ignore         text

# Prevents massive diffs from built files
dist/**           binary

### sql ###
# Basic .gitattributes for sql files

*.sql linguist-detectable=true
*.sql linguist-language=sql

### VisualStudioCode ###
# Fix syntax highlighting on GitHub to allow comments
.vscode/*.json linguist-language=JSON-with-Comments

### DevContainer ###
# Fix syntax highlighting on GitHub to allow comments
.devcontainer.json linguist-language=JSON-with-Comments
devcontainer.json linguist-language=JSON-with-Comments
```

### .gitignore

```gitignore
HELP.md
target/
!.mvn/wrapper/maven-wrapper.jar
!**/src/main/**/target/
!**/src/test/**/target/

### STS ###
.apt_generated
.classpath
.factorypath
.project
.settings
.springBeans
.sts4-cache

### IntelliJ IDEA ###
.idea
*.iws
*.iml
*.ipr

### NetBeans ###
/nbproject/private/
/nbbuild/
/dist/
/nbdist/
/.nb-gradle/
build/
!**/src/main/**/build/
!**/src/test/**/build/

### VS Code ###
.vscode/

# https://github.com/github/gitignore

### Java ###
# Compiled class file
*.class

# Log file
*.log

# BlueJ files
*.ctxt

# Mobile Tools for Java (J2ME)
.mtj.tmp/

# Package Files #
*.jar
*.war
*.nar
*.ear
*.zip
*.tar.gz
*.rar

# virtual machine crash logs, see https://www.java.com/en/download/help/error_hotspot.xml
hs_err_pid*
replay_pid*

### Maven ###
pom.xml.tag
pom.xml.releaseBackup
pom.xml.versionsBackup
pom.xml.next
release.properties
dependency-reduced-pom.xml
buildNumber.properties
.mvn/timing.properties
# https://maven.apache.org/tools/wrapper/#Usage_with_or_without_Binary_JAR
.mvn/wrapper/maven-wrapper.jar

### Eclipse ###
.metadata
bin/
tmp/
*.tmp
*.bak
*.swp
*~.nib
local.properties
.settings/
.loadpath
.recommenders

# External tool builders
.externalToolBuilders/

# Locally stored "Eclipse launch configurations"
*.launch

# PyDev specific (Python IDE for Eclipse)
*.pydevproject

# CDT-specific (C/C++ Development Tooling)
.cproject

# CDT- autotools
.autotools

# PDT-specific (PHP Development Tools)
.buildpath

# sbteclipse plugin
.target

# Tern plugin
.tern-project

# TeXlipse plugin
.texlipse

# Code Recommenders
.recommenders/

# Annotation Processing
.apt_generated/
.apt_generated_tests/

# Scala IDE specific (Scala & Java development for Eclipse)
.cache-main
.scala_dependencies
.worksheet

# Uncomment this line if you wish to ignore the project description file.
# Typically, this file would be tracked if it contains build/dependency configurations:
#.project

### JetBrains ###
# Covers JetBrains IDEs: IntelliJ, GoLand, RubyMine, PhpStorm, AppCode, PyCharm, CLion, Android Studio, WebStorm and Rider
# Reference: https://intellij-support.jetbrains.com/hc/en-us/articles/206544839

# User-specific stuff
.idea/**/workspace.xml
.idea/**/tasks.xml
.idea/**/usage.statistics.xml
.idea/**/dictionaries
.idea/**/shelf

# AWS User-specific
.idea/**/aws.xml

# Generated files
.idea/**/contentModel.xml

# Sensitive or high-churn files
.idea/**/dataSources/
.idea/**/dataSources.ids
.idea/**/dataSources.local.xml
.idea/**/sqlDataSources.xml
.idea/**/dynamic.xml
.idea/**/uiDesigner.xml
.idea/**/dbnavigator.xml

# Gradle
.idea/**/gradle.xml
.idea/**/libraries

# Gradle and Maven with auto-import
# When using Gradle or Maven with auto-import, you should exclude module files,
# since they will be recreated, and may cause churn.  Uncomment if using
# auto-import.
# .idea/artifacts
# .idea/compiler.xml
# .idea/jarRepositories.xml
# .idea/modules.xml
# .idea/*.iml
# .idea/modules
# *.iml
# *.ipr

# CMake
cmake-build-*/

# Mongo Explorer plugin
.idea/**/mongoSettings.xml

# IntelliJ
out/

# mpeltonen/sbt-idea plugin
.idea_modules/

# JIRA plugin
atlassian-ide-plugin.xml

# Cursive Clojure plugin
.idea/replstate.xml

# SonarLint plugin
.idea/sonarlint/
.idea/sonarlint.xml # see https://community.sonarsource.com/t/is-the-file-idea-idea-idea-sonarlint-xml-intended-to-be-under-source-control/121119

# Crashlytics plugin (for Android Studio and IntelliJ)
com_crashlytics_export_strings.xml
crashlytics.properties
crashlytics-build.properties
fabric.properties

# Editor-based HTTP Client
.idea/httpRequests
http-client.private.env.json

# Android studio 3.1+ serialized cache file
.idea/caches/build_file_checksums.ser

# Apifox Helper cache
.idea/.cache/.Apifox_Helper
.idea/ApifoxUploaderProjectSetting.xml

# Github Copilot persisted session migrations, see: https://github.com/microsoft/copilot-intellij-feedback/issues/712#issuecomment-3322062215
.idea/**/copilot.data.migration.*.xml

### VisualStudioCode ###
.vscode/*
!.vscode/settings.json
!.vscode/tasks.json
!.vscode/launch.json
!.vscode/extensions.json
!.vscode/*.code-snippets
!*.code-workspace

# Built Visual Studio Code Extensions
*.vsix

### Windows ###
# Windows thumbnail cache files
Thumbs.db
Thumbs.db:encryptable
ehthumbs.db
ehthumbs_vista.db

# Dump file
*.stackdump

# Folder config file
[Dd]esktop.ini

# Recycle Bin used on file shares
$RECYCLE.BIN/

# Windows Installer files
*.cab
*.msi
*.msix
*.msm
*.msp

# Windows shortcuts
*.lnk

### macOS ###
# General
.DS_Store
.AppleDouble
.LSOverride

# Icon must end with two \r
Icon  

# Thumbnails
._*

# Files that might appear in the root of a volume
.DocumentRevisions-V100
.fseventsd
.Spotlight-V100
.TemporaryItems
.Trashes
.VolumeIcon.icns
.com.apple.timemachine.donotpresent

# Directories potentially created on remote AFP share
.AppleDB
.AppleDesktop
Network Trash Folder
Temporary Items
.apdisk

### Linux ###
*~

# temporary files which can be created if a process still has a handle open of a deleted file
.fuse_hidden*

# Metadata left by Dolphin file manager, which comes with KDE Plasma
.directory

# Linux trash folder which might appear on any partition or disk
.Trash-*

# .nfs files are created when an open file is removed but is still being accessed
.nfs*

# Log files created by default by the nohup command
nohup.out

### MicrosoftOffice ###
# Word temporary
~$*.doc*
~$*.dot*

# Word Auto Backup File
Backup of *.doc*

# Excel temporary
~$*.xls*

# Excel Backup File
*.xlk

# PowerPoint temporary
~$*.ppt*

# Visio autosave temporary files
*.~vsd*

### LibreOffice ###
# LibreOffice locks
.~lock.*#

### Vim ###
# Swap
[._]*.s[a-v][a-z]
# comment out the next line if you don't need vector files
!*.svg
[._]*.sw[a-p]
[._]s[a-rt-v][a-z]
[._]ss[a-gi-z]
[._]sw[a-p]

# Session
Session.vim
Sessionx.vim

# Temporary
.netrwhist
# Auto-generated tag files
tags
# Persistent undo
[._]*.un~

```

> **Note**:
> `git --version` is internally converted to `git version`

### LICENSE.txt

```text
                                 Apache License
                           Version 2.0, January 2004
                        http://www.apache.org/licenses/

   TERMS AND CONDITIONS FOR USE, REPRODUCTION, AND DISTRIBUTION

   1. Definitions.

      "License" shall mean the terms and conditions for use, reproduction,
      and distribution as defined by Sections 1 through 9 of this document.

      "Licensor" shall mean the copyright owner or entity authorized by
      the copyright owner that is granting the License.

      "Legal Entity" shall mean the union of the acting entity and all
      other entities that control, are controlled by, or are under common
      control with that entity. For the purposes of this definition,
      "control" means (i) the power, direct or indirect, to cause the
      direction or management of such entity, whether by contract or
      otherwise, or (ii) ownership of fifty percent (50%) or more of the
      outstanding shares, or (iii) beneficial ownership of such entity.

      "You" (or "Your") shall mean an individual or Legal Entity
      exercising permissions granted by this License.

      "Source" form shall mean the preferred form for making modifications,
      including but not limited to software source code, documentation
      source, and configuration files.

      "Object" form shall mean any form resulting from mechanical
      transformation or translation of a Source form, including but
      not limited to compiled object code, generated documentation,
      and conversions to other media types.

      "Work" shall mean the work of authorship, whether in Source or
      Object form, made available under the License, as indicated by a
      copyright notice that is included in or attached to the work
      (an example is provided in the Appendix below).

      "Derivative Works" shall mean any work, whether in Source or Object
      form, that is based on (or derived from) the Work and for which the
      editorial revisions, annotations, elaborations, or other modifications
      represent, as a whole, an original work of authorship. For the purposes
      of this License, Derivative Works shall not include works that remain
      separable from, or merely link (or bind by name) to the interfaces of,
      the Work and Derivative Works thereof.

      "Contribution" shall mean any work of authorship, including
      the original version of the Work and any modifications or additions
      to that Work or Derivative Works thereof, that is intentionally
      submitted to Licensor for inclusion in the Work by the copyright owner
      or by an individual or Legal Entity authorized to submit on behalf of
      the copyright owner. For the purposes of this definition, "submitted"
      means any form of electronic, verbal, or written communication sent
      to the Licensor or its representatives, including but not limited to
      communication on electronic mailing lists, source code control systems,
      and issue tracking systems that are managed by, or on behalf of, the
      Licensor for the purpose of discussing and improving the Work, but
      excluding communication that is conspicuously marked or otherwise
      designated in writing by the copyright owner as "Not a Contribution."

      "Contributor" shall mean Licensor and any individual or Legal Entity
      on behalf of whom a Contribution has been received by Licensor and
      subsequently incorporated within the Work.

   2. Grant of Copyright License. Subject to the terms and conditions of
      this License, each Contributor hereby grants to You a perpetual,
      worldwide, non-exclusive, no-charge, royalty-free, irrevocable
      copyright license to reproduce, prepare Derivative Works of,
      publicly display, publicly perform, sublicense, and distribute the
      Work and such Derivative Works in Source or Object form.

   3. Grant of Patent License. Subject to the terms and conditions of
      this License, each Contributor hereby grants to You a perpetual,
      worldwide, non-exclusive, no-charge, royalty-free, irrevocable
      (except as stated in this section) patent license to make, have made,
      use, offer to sell, sell, import, and otherwise transfer the Work,
      where such license applies only to those patent claims licensable
      by such Contributor that are necessarily infringed by their
      Contribution(s) alone or by combination of their Contribution(s)
      with the Work to which such Contribution(s) was submitted. If You
      institute patent litigation against any entity (including a
      cross-claim or counterclaim in a lawsuit) alleging that the Work
      or a Contribution incorporated within the Work constitutes direct
      or contributory patent infringement, then any patent licenses
      granted to You under this License for that Work shall terminate
      as of the date such litigation is filed.

   4. Redistribution. You may reproduce and distribute copies of the
      Work or Derivative Works thereof in any medium, with or without
      modifications, and in Source or Object form, provided that You
      meet the following conditions:

      (a) You must give any other recipients of the Work or
          Derivative Works a copy of this License; and

      (b) You must cause any modified files to carry prominent notices
          stating that You changed the files; and

      (c) You must retain, in the Source form of any Derivative Works
          that You distribute, all copyright, patent, trademark, and
          attribution notices from the Source form of the Work,
          excluding those notices that do not pertain to any part of
          the Derivative Works; and

      (d) If the Work includes a "NOTICE" text file as part of its
          distribution, then any Derivative Works that You distribute must
          include a readable copy of the attribution notices contained
          within such NOTICE file, excluding those notices that do not
          pertain to any part of the Derivative Works, in at least one
          of the following places: within a NOTICE text file distributed
          as part of the Derivative Works; within the Source form or
          documentation, if provided along with the Derivative Works; or,
          within a display generated by the Derivative Works, if and
          wherever such third-party notices normally appear. The contents
          of the NOTICE file are for informational purposes only and
          do not modify the License. You may add Your own attribution
          notices within Derivative Works that You distribute, alongside
          or as an addendum to the NOTICE text from the Work, provided
          that such additional attribution notices cannot be construed
          as modifying the License.

      You may add Your own copyright statement to Your modifications and
      may provide additional or different license terms and conditions
      for use, reproduction, or distribution of Your modifications, or
      for any such Derivative Works as a whole, provided Your use,
      reproduction, and distribution of the Work otherwise complies with
      the conditions stated in this License.

   5. Submission of Contributions. Unless You explicitly state otherwise,
      any Contribution intentionally submitted for inclusion in the Work
      by You to the Licensor shall be under the terms and conditions of
      this License, without any additional terms or conditions.
      Notwithstanding the above, nothing herein shall supersede or modify
      the terms of any separate license agreement you may have executed
      with Licensor regarding such Contributions.

   6. Trademarks. This License does not grant permission to use the trade
      names, trademarks, service marks, or product names of the Licensor,
      except as required for reasonable and customary use in describing the
      origin of the Work and reproducing the content of the NOTICE file.

   7. Disclaimer of Warranty. Unless required by applicable law or
      agreed to in writing, Licensor provides the Work (and each
      Contributor provides its Contributions) on an "AS IS" BASIS,
      WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or
      implied, including, without limitation, any warranties or conditions
      of TITLE, NON-INFRINGEMENT, MERCHANTABILITY, or FITNESS FOR A
      PARTICULAR PURPOSE. You are solely responsible for determining the
      appropriateness of using or redistributing the Work and assume any
      risks associated with Your exercise of permissions under this License.

   8. Limitation of Liability. In no event and under no legal theory,
      whether in tort (including negligence), contract, or otherwise,
      unless required by applicable law (such as deliberate and grossly
      negligent acts) or agreed to in writing, shall any Contributor be
      liable to You for damages, including any direct, indirect, special,
      incidental, or consequential damages of any character arising as a
      result of this License or out of the use or inability to use the
      Work (including but not limited to damages for loss of goodwill,
      work stoppage, computer failure or malfunction, or any and all
      other commercial damages or losses), even if such Contributor
      has been advised of the possibility of such damages.

   9. Accepting Warranty or Additional Liability. While redistributing
      the Work or Derivative Works thereof, You may choose to offer,
      and charge a fee for, acceptance of support, warranty, indemnity,
      or other liability obligations and/or rights consistent with this
      License. However, in accepting such obligations, You may act only
      on Your own behalf and on Your sole responsibility, not on behalf
      of any other Contributor, and only if You agree to indemnify,
      defend, and hold each Contributor harmless for any liability
      incurred by, or claims asserted against, such Contributor by reason
      of your accepting any such warranty or additional liability.

   END OF TERMS AND CONDITIONS

   APPENDIX: How to apply the Apache License to your work.

      To apply the Apache License to your work, attach the following
      boilerplate notice, with the fields enclosed by brackets "[]"
      replaced with your own identifying information. (Don't include
      the brackets!)  The text should be enclosed in the appropriate
      comment syntax for the file format. We also recommend that a
      file or class name and description of purpose be included on the
      same "printed page" as the copyright notice for easier
      identification within third-party archives.

   Copyright [yyyy] [name of copyright owner]

   Licensed under the Apache License, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License.

```

### robots.txt

```text
#    .__________________________.
#    | .___________________. |==|
#    | | ................. | |  |
#    | | ::[ Dear robot ]: | |  |
#    | | ::::[ be nice ]:: | |  |
#    | | ::::::::::::::::: | |  |
#    | | ::::::::::::::::: | |  |
#    | | ::::::::::::::::: | |  |
#    | | ::::::::::::::::: | | ,|
#    | !___________________! |(c|
#    !_______________________!__!
#   /                            \
#  /  [][][][][][][][][][][][][]  \
# /  [][][][][][][][][][][][][][]  \
#(  [][][][][____________][][][][]  )
# \ ------------------------------ /
#  \______________________________/

User-agent: *
Disallow: /
Allow: /public/

#              ________
#   __,_,     |        |
#  [_|_/      |   OK   |
#   //        |________|
# _//    __  /
#(_|)   |@@|
# \ \__ \--/ __
#  \o__|----|  |   __
#      \ }{ /\ )_ / _\
#      /\__/\ \__O (__
#     (--/\--)    \__/
#     _)(  )(_
#    `---''---`
```
