package main

import (
	"context"
	"log"
	"os"
	"strings"

	"github.com/SigNoz/sample-golang-app/controllers"
	"google.golang.org/grpc/credentials"

	"github.com/gin-gonic/gin"
)

var (
	serviceName  = os.Getenv("SERVICE_NAME")
	insecure     = os.Getenv("INSECURE_MODE")
)

func main() {

	r := gin.Default()

	// Routes
	r.GET("/hello", controllers.Hello)

	// Run the server
	r.Run(":8090")
}
