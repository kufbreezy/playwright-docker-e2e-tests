package main

import (
	"net/http"
	"os"
	"testing"
)

func TestSecuredEndpoint(t *testing.T) {
	baseURL := os.Getenv("API_BASE_URL")
	token := os.Getenv("GITHUB_TOKEN")

	req, err := http.NewRequest("GET", baseURL+"/user", nil)
	if err != nil {
		t.Fatal(err)
	}

	req.Header.Set("Authorization", "Bearer "+token)

	client := &http.Client{}
	resp, err := client.Do(req)
	if err != nil {
		t.Fatal(err)
	}
	defer resp.Body.Close()

	if resp.StatusCode != 200 {
		t.Errorf("Expected 200 OK, got %d", resp.StatusCode)
	}
}
