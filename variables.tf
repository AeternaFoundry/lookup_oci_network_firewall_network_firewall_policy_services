variable "network_firewall_network_firewall_policy_services_lookup" {
  description = <<EOT
Map of network_firewall_network_firewall_policy_services_lookup, attributes below
Required:
    - network_firewall_policy_id
Optional:
    - display_name
    - filter (block):
        - name (required)
        - regex (optional)
        - values (required)
EOT

  type = map(object({
    network_firewall_policy_id = string
    display_name               = optional(string)
    filter = optional(list(object({
      name   = string
      regex  = optional(bool)
      values = list(string)
    })))
  }))
  validation {
    condition = alltrue([
      for k, v in var.network_firewall_network_firewall_policy_services_lookup : (
        alltrue([for item in v.service_summary_collection : (item.items == null || alltrue([for item in item.items : (item.type == null || (contains(["TCP_SERVICE", "UDP_SERVICE"], item.type)))]))])
      )
    ])
    error_message = "must be one of: \"TCP_SERVICE\", \"UDP_SERVICE\""
  }
}

