package utils

import (
	"bytes"
	"encoding/json"
	"log"
	"net/http"
	"os"
)

type SlackPayload struct {
	Text string `json:"text"`
}

func SendSlackAlert(message string) {
	webhook := os.Getenv("SLACK_WEBHOOK")
	if webhook == "" {
		log.Println("⚠️ SLACK_WEBHOOK not set — skipping alert.")
		return
	}

	payload := SlackPayload{Text: message}
	body, _ := json.Marshal(payload)

	resp, err := http.Post(webhook, "application/json", bytes.NewBuffer(body))
	if err != nil {
		log.Printf("❌ Failed to send Slack alert: %v\n", err)
		return
	}
	defer resp.Body.Close()

	log.Println("✅ Slack alert sent!")
}
