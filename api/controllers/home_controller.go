package controllers

import (
	"net/http"

	"github.com/stacktracedev/go-blog/api/responses"
)

//Home handler for the root route
func (server *Server) Home(w http.ResponseWriter, r *http.Request) {
	responses.JSON(w, http.StatusOK, "Welcome to Blog!")
}
