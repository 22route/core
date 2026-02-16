// tt-api-docs serves embedded Swagger UI for 22route Core API (openapi.yaml).
package main

import (
	"flag"
	"log"
	"net/http"

	"github.com/22route/core/pkg/docs"
)

func main() {
	addr := flag.String("addr", ":8080", "listen address")
	flag.Parse()

	h, err := docs.Handler()
	if err != nil {
		log.Fatal(err)
	}

	log.Printf("tt-api-docs listening on %s", *addr)
	log.Fatal(http.ListenAndServe(*addr, h))
}
