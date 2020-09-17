# SET GOLANG BASE IMAGE
FROM golang:alpine as builder

# ENV GO111MODULE=on

# ADD MAAINTAINER INFO
LABEL maintainer="Rajesh Barik <rajeshbarik66@gmail,com>"

# INSTALL GIT | REQUIRED FOR FETCHING DEPENDENCIES
RUN apk update && apk add --no-cache git

# SET CURRENT WORKING DIRECTORY INSIDE CONTAINER
WORKDIR /app

# COPY go.mod and go.sum files
COPY go.mod go.sum ./

# DOWNLOAD ALL THE DEPENDENCIES
RUN go mod download

# COPY ALL THE SOURCE FILES
COPY . .

# BUILD THE APP
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o main .

# START A NEW STAGE
FROM alpine:latest
RUN apk --no-cache add ca-certificates

WORKDIR /root/

# COPY THE PRE-BUILT BINARY FROM PREVIOUS STAGE
COPY --from=builder /app/main .
# COPY --from=builder /app/.env .

# EXPOSE PORT
EXPOSE 8080

# RUN THE EXECUTABLE
CMD [ "./main" ]