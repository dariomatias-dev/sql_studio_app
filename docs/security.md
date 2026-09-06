# Security Policy

<p align="center">
<strong>English</strong> · <a href="security.es.md">Español</a> · <a href="security.pt-BR.md">Português (BR)</a>
</p>

## Supported Versions

**SQL Studio** is maintained as source. The only supported version is the current `main` branch: security fixes are applied there and are not backported to older commits.

## Reporting a Vulnerability

Please do **not** open a public GitHub issue to report a security vulnerability.

Instead, send an email to [dariomatias.dev@gmail.com](mailto:dariomatias.dev@gmail.com) containing:

- A description of the vulnerability and its potential impact.
- Steps to reproduce it (a minimal example is especially helpful).
- The commit you built from and the Android version you tested on.

This is a solo-maintained, hobby-scale open-source project: there is no dedicated security team and no formal SLA, but every report is taken seriously and acknowledged as soon as possible. Once a fix is published, the reporter will be credited unless they prefer to remain anonymous.

## Scope

The app runs fully offline: it holds a fixed set of bundled sample databases and whatever databases the user creates, stores everything locally (SQLite via `sqflite`, `shared_preferences`), and makes no network requests. The most relevant class of issue is therefore local: the SQL the app itself runs (both the bundled schema/seed assets and the console's statement splitter, which has to handle a semicolon or a keyword inside a string literal or comment without misparsing the statement) and how the app stores data on the device. Server- and account-related issues do not apply, since there is neither a server nor an account.
