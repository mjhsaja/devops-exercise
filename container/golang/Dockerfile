FROM golang:1.20.1-alpine

WORKDIR /app

#contoh
RUN apk add curl

COPY . .

RUN go get

RUN go build -o ./bin/app ./main.go

EXPOSE 8080

ENTRYPOINT [ "/app/bin/app" ]