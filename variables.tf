variable "hosted_zone_id" {
  description = "Route 53 hosted zone ID for your domain"
  type        = string
}

variable "record_name" {
  description = "FQDN to publish as an ALIAS (e.g., app.example.com or example.com)"
  type        = string
}