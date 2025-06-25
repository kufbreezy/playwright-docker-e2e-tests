package main

import (
	"encoding/json"
	"net/http"
	"os"
	"testing"
)

type GitHubUser struct {
	Login string `json:"login"`
	ID    int    `json:"id"`
	URL   string `json:"url"`
}

func TestGitHubPublicUser(t *testing.T) {
	baseURL := os.Getenv("API_BASE_URL")
	username := os.Getenv("GITHUB_USER")

	if baseURL == "" || username == "" {
		t.Fatal("Missing API_BASE_URL or GITHUB_USER in environment")
	}

	url := baseURL + "/users/" + username

	resp, err := http.Get(url)
	if err != nil {
		t.Fatalf("Failed to send request: %v", err)
	}
	defer resp.Body.Close()

	if resp.StatusCode != 200 {
		t.Fatalf("Expected 200 OK, got %d", resp.StatusCode)
	}

	var user GitHubUser
	if err := json.NewDecoder(resp.Body).Decode(&user); err != nil {
		t.Fatalf("Failed to parse response JSON: %v", err)
	}

	if user.Login != username {
		t.Errorf("Expected login %s, got %s", username, user.Login)
	}
}
