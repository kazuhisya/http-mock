package main

import (
	"fmt"
	"log"
	"net/http"
	"os"
)

type String string

func (s String) ServeHTTP(w http.ResponseWriter, r *http.Request) {
	fmt.Fprint(w, s)
	log.Println("Exit 2")
	os.Exit(2)
}

func main() {
	http.Handle("/", String("Hello World."))
	log.Println("Server is running at 8080 port.")
	log.Fatal(http.ListenAndServe(":8080", nil))
}
