FROM golang:1.21-alpine AS builder
WORKDIR /app
COPY go.mod ./
RUN go mod download
COPY . .
RUN CGO_ENABLED=0 GOOS=linux go build -o main ./cmd/api/main.go

FROM alpine:latest
WORKDIR /root/
COPY --from=builder /app/main .
COPY .env.example .env
EXPOSE 8080
CMD ["./main"]
