data "oci_network_firewall_network_firewall_policy_services" "network_firewall_network_firewall_policy_services_lookup" {
  for_each = var.network_firewall_network_firewall_policy_services_lookup

  network_firewall_policy_id = each.value.network_firewall_policy_id
  display_name               = each.value.display_name

  dynamic "filter" {
    for_each = each.value.filter != null ? each.value.filter : []
    content {
      name   = filter.value.name
      regex  = filter.value.regex
      values = filter.value.values
    }
  }
}

