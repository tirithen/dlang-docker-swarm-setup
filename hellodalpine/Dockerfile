# The build image
FROM alpine:edge as builder

RUN echo http://dl-cdn.alpinelinux.org/alpine/edge/testing >> /etc/apk/repositories
RUN apk update
RUN apk add openssl-dev build-base dub dmd

WORKDIR /code/service

COPY hellodalpine/source /code/service/source
COPY hellodalpine/dub.json /code/service
COPY hellodalpine/dub.selections.json /code/service

RUN dub build --build=release --parallel --cache=user

# The service image
FROM alpine

RUN apk update && apk add libexecinfo libgcc curl

WORKDIR /service

COPY --from=builder /code/service/hellodalpine .

RUN adduser -D service
USER service

ENTRYPOINT ["./hellodalpine"]

EXPOSE 8080
