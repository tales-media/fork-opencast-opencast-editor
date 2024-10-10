ARG NODE_VERSION=20
FROM node:${NODE_VERSION}-alpine AS build

WORKDIR /src
COPY package.json .
COPY package-lock.json .
RUN npm ci
COPY / .

ARG PUBLIC_URL=/editor-ui
ARG VITE_APP_SETTINGS_PATH=/ui/config/editor/editor-settings.toml
ARG VERSION=unknown
ARG BUILD_DATE=unknown
ARG GIT_COMMIT=unknown
RUN npm run build


FROM rg.nl-ams.scw.cloud/shio-solutions/infra/static-site:1

ARG PUBLIC_URL=/editor-ui
ARG VERSION=unknown
ARG BUILD_DATE=unknown
ARG GIT_COMMIT=unknown

COPY --from=build /src/build "/www/${PUBLIC_URL}"

LABEL maintainer                             "shio solutions GmbH <dev@shio.solutions>"
LABEL org.opencontainers.image.title         "Opencast Video Editor"
LABEL org.opencontainers.image.description   "Web-based video editor for Opencast"
LABEL org.opencontainers.image.version       "${VERSION}"
LABEL org.opencontainers.image.vendor        "shio solutions GmbH"
LABEL org.opencontainers.image.authors       "shio solutions GmbH <dev@shio.solutions>"
LABEL org.opencontainers.image.licenses      "Apache-2.0"
LABEL org.opencontainers.image.url           "https://github.com/tales-media/fork-opencast-opencast-editor"
LABEL org.opencontainers.image.documentation "https://github.com/tales-media/fork-opencast-opencast-editor"
LABEL org.opencontainers.image.source        "https://github.com/tales-media/fork-opencast-opencast-editor"
LABEL org.opencontainers.image.created       "${BUILD_DATE}"
LABEL org.opencontainers.image.revision      "${GIT_COMMIT}"
