# Better Dime #
[![Build Status](https://travis-ci.org/stiftungswo/Dime.svg?branch=better-dime)](https://travis-ci.org/stiftungswo/Dime)
[![codecov](https://codecov.io/gh/stiftungswo/Dime/branch/better-dime/graph/badge.svg)](https://travis-ci.org/stiftungswo/Dime)

## Installation
### Vorbereitung
#### Homebrew für Mac
Fast jede Linux-Distribution wird mit einem Paketmanager ausgeliefert. Diese ermöglichen dir, bequem neue Programme zu installieren, ohne dazu eine aufwendige Installation durchführen zu müssen. Unter Mac hat die Community homebrew entwickelt, um einen solchen Paketmanager auf Mac bereitzustellen.

Die Installation kann im Terminal mit einem Einzeiler angestossen werden, welcher sich auf der [offiziellen Website](https://brew.sh/index_de) befindet.

#### Docker
Installation gemäss der Installationsanleitung auf der [Website](https://docs.docker.com/install/) durchführen. Wichtig: Für manche Betriebssysteme muss docker-compose noch separat installiert werden.

### Backend
1. Ins Verzeichnis des Dime wechseln (z.B. cd ``~/src/swo/betterDime``)
2. Docker-Image der API bauen: ``docker build -t dime_api api``
3. composer-Abhängigkeiten mit dem neuen Image installieren lassen: ``docker run --rm -v $PWD/api:/app -w /app dime_api composer install``
4. Docker-Stack starten: ``docker-compose up -d``
5. .env Datei kopieren: ``cp api/.env.example api/.env``
6. Neuen Applikationskey erstellen und in die .env-Datei abfüllen als APP_KEY: ``openssl rand -base64 24``
7. Neuen Key für die JWT-Tokens erstellen und in die .env-Datei als JWT_SECRET abfüllen: ``openssl rand -base64 24``
8. Datenbank mit phpmyadmin (localhost:38080) namens "dime" erstellen.
9. Die API ist nun unter `localhost:38000` erreichbar.
