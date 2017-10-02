FROM alpine:3.6

ENV OAUTH2_PROXY_RELEASE "https://github.com/bitly/oauth2_proxy/releases/download/v2.2/oauth2_proxy-2.2.0.linux-amd64.go1.8.1.tar.gz"

RUN apk --update add curl

ADD ${OAUTH2_PROXY_RELEASE} /tmp
RUN tar zxf /tmp/*.tar.gz -C /bin --strip-components=1 \
  && chmod +x /bin/oauth2_proxy \
  && rm -rf /tmp/*.tar.gz

EXPOSE 8080 4180

ENTRYPOINT ["/bin/oauth2_proxy"]
CMD [ "--upstream=http://0.0.0.0:8080/", "--http-address=0.0.0.0:4180" ]
