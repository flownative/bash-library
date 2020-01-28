FROM scratch
MAINTAINER Robert Lemke <robert@flownative.com>

LABEL org.label-schema.name="Bash Library"
LABEL org.label-schema.description="A library of universal utility functions for Bash"
LABEL org.label-schema.vendor="Flownative GmbH"

COPY lib /lib/
