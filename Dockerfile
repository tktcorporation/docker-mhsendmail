FROM bash AS build

RUN apk add curl

ARG MHSENDMAIL_VERSION
RUN curl --fail --silent --location --output /tmp/mhsendmail "https://github.com/mailhog/mhsendmail/releases/download/${MHSENDMAIL_VERSION}/mhsendmail_linux_amd64"

RUN chmod +x /tmp/mhsendmail

FROM scratch

COPY --from=build /tmp/mhsendmail /usr/bin/mhsendmail

ENTRYPOINT ["mhsendmail"]