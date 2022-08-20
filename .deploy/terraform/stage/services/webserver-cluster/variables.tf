variable "stripe_secret_key" {
  description = "The stripe secret key"
  type = string
}

variable "web_app_url" {
  description = "Web app url to redirect user after payment"
  type = string
}

variable "web_hook_secret" {
  description = "The stripe webhook secret"
  type = string
}