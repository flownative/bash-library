FROM scratch
MAINTAINER Robert Lemke <robert@flownative.com>

ARG BUILD_DATE

LABEL org.label-schema.name="Bash Library"
LABEL org.label-schema.description="A library of universal utility functions for Bash"
LABEL org.label-schema.vendor="Flownative GmbH"
LABEL com.flownative.build-date=$BUILD_DATE

COPY lib /lib/
