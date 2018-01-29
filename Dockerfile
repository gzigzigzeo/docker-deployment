FROM golang:1.8-alpine AS source
ADD . /go/src/hello-app
RUN go install hello-app

FROM alpine:latest
COPY --from=source /go/bin/hello-app .
ENV PORT 8080
CMD ["./hello-app"]
