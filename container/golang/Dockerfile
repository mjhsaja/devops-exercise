FROM golang:1.20.1-alpine as base
# RUN apk add --no-cache git

FROM base AS builder
WORKDIR /app
COPY . .
RUN go get
RUN go build -o ./bin/app ./main.go

FROM base as runner
COPY --from=builder /app/bin/app /app/bin/app
EXPOSE 8080
ENTRYPOINT [ "/app/bin/app" ]