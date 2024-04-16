package controllers

import (
	"net/http"

	"github.com/gin-gonic/gin"
)


// GET /hello
func Hello(c *gin.Context) {
	c.JSON(http.StatusOK, gin.H{"data": "Hello World!"})
}