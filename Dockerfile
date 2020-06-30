FROM golang:1.14-alpine3.11 as buildenv
RUN apk add git --no-cache
WORKDIR /go/src/apnsmock
COPY ./ /go/src/apnsmock
RUN go get \
&& go build

# build runtime image
FROM golang:1.14-alpine3.11
RUN mkdir /app
WORKDIR /app
COPY --from=buildenv /go/src/apnsmock/apnsmock /app/
COPY ./certs/server.crt ./certs/server.key /app/certs/

ENV ENABLE_METRICS="true"

EXPOSE 8443

ENTRYPOINT ["/app/apnsmock","-addr","0.0.0.0:8443"]
