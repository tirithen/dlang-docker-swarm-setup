# The build image
FROM dlang2/dmd-ubuntu AS builder

WORKDIR /code/service

COPY hellod/source /code/service/source
COPY hellod/dub.json /code/service

RUN dub build --build=release --parallel --cache=user

# The service image
FROM bitnami/minideb

RUN apt update && apt -y install openssl

WORKDIR /service

COPY --from=builder /code/service/hellod .

RUN useradd service
USER service

ENTRYPOINT ["./hellod"]

EXPOSE 8080
