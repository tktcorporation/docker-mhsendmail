FROM bash AS build

ARG MHSENDMAIL_VERSION

RUN apk add curl

RUN [[ -z "${MHSENDMAIL_VERSION}" ]] && MHSENDMAIL_VERSION=$(curl https://api.github.com/repos/mailhog/mhsendmail/releases/latest -s | jq .tag_name -r)

RUN curl --fail --silent --location --output /tmp/mhsendmail https://github.com/mailhog/mhsendmail/releases/download/${MHSENDMAIL_VERSION}/mhsendmail_linux_amd64

RUN chmod +x /tmp/mhsendmail

FROM scratch

COPY --from=build /tmp/mhsendmail /usr/bin/mhsendmail

ENTRYPOINT ["mhsendmail"]