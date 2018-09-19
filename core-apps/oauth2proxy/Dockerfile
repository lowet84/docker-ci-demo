FROM golang as builder
RUN git clone https://github.com/lowet84/oauth2_proxy
RUN mv oauth2_proxy src
RUN go get oauth2_proxy
RUN go install oauth2_proxy

FROM alpine

COPY --from=builder /go/bin/oauth2_proxy /bin/oauth2_proxy
RUN apk add --no-cache ca-certificates libc6-compat

EXPOSE 8080 4180
ENTRYPOINT [ "/bin/oauth2_proxy" ]
CMD [ "--upstream=http://0.0.0.0:8080/", "--http-address=0.0.0.0:4180" ]
