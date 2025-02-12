package main

import (
	"fmt"
	"net/http"
)

func init() {
	// build時に最初に呼ばれる
	fmt.Println("main.init")
}

func main() {
	http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
		_, _ = fmt.Fprintf(w, "Hello, World!")
	})
	http.HandleFunc("/hoge", func(w http.ResponseWriter, r *http.Request) {
		_, _ = fmt.Fprintf(w, "Fuga!")
	})

	fmt.Println("ListenAndServe :8080")

	// ポート 8080 でサーバーを起動
	if err := http.ListenAndServe(":8080", nil); err != nil {
		panic(err)
	}
}
