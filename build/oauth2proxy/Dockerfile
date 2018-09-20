FROM golang as builder
RUN git clone https://github.com/lowet84/oauth2_proxy
RUN mv oauth2_proxy src
RUN go get oauth2_proxy
RUN go install oauth2_proxy

FROM alpine

COPY --from=builder /go/bin/oauth2_proxy /bin/oauth2_proxy
RUN apk add --no-cache ca-certificates libc6-compat

EXPOSE 8080 4180
ADD start.sh /start.sh
CMD sh start.sh
