FROM node:lts-alpine
ARG BUILD_DATE
ARG CI_JOB_ID
ARG CI_PIPELINE_ID
ARG VERSION
ARG VCS_REF
LABEL org.label-schema.schema-version="1.0" \
      org.label-schema.name="firebase-tools" \
      org.label-schema.version=${VERSION} \
      org.label-schema.build-date=${BUILD_DATE} \
      org.label-schema.description="Firebase CLI on the NodeJS image" \
      org.label-schema.url="https://github.com/firebase/firebase-tools/" \
      org.label-schema.vcs-url="https://github.com/AndreySenov/firebase-tools-docker/" \
      org.label-schema.vcs-ref=${VCS_REF} \
      ci_job_id=${CI_JOB_ID} \
      ci_pipeline_id=${CI_PIPELINE_ID}
ENV FIREBASE_TOOLS_VERSION=${VERSION}
ENV HOME=/home/node
RUN yarn global add firebase-tools@${VERSION} && \
    yarn cache clean && \
    firebase -V && \
    mkdir $HOME/.cache && \
    chown -R node:node $HOME
USER node
VOLUME $HOME/.cache
WORKDIR $HOME
CMD ["sh"]
