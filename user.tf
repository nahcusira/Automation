resource "random_password" "password" {
  count       = length(local.name)
  length      = 16
  min_lower   = 1
  min_numeric = 1
  min_special = 1
  min_upper   = 1
  special     = true
}

resource "azuread_user" "user" {
  count               = length(local.name)
  user_principal_name = "${local.name[count.index]}${var.domain}"
  display_name        = local.name[count.index]
  password            = random_password.password[count.index].result
  department          = local.department[count.index]
  job_title           = local.jobTitle[count.index]
  usage_location      = "VN"
}

resource "random_password" "password_null" {
  count       = length(local.name_null)
  length      = 16
  min_lower   = 1
  min_numeric = 1
  min_special = 1
  min_upper   = 1
  special     = true
}

resource "azuread_user" "user_null" {
  count               = length(local.name_null)
  user_principal_name = "${local.name_null[count.index]}${var.domain}"
  display_name        = local.name_null[count.index]
  password            = random_password.password_null[count.index].result
  department          = local.departmentNull[count.index]
  job_title           = local.jobTitleNull[count.index]
  usage_location      = "VN"
}

resource "random_password" "password_custom" {
  count       = length(local.name_custom)
  length      = 16
  min_lower   = 1
  min_numeric = 1
  min_special = 1
  min_upper   = 1
  special     = true
}

resource "azuread_user" "user_custom" {
  count               = length(local.name_custom)
  user_principal_name = "${local.name_custom[count.index]}${var.domain}"
  display_name        = local.name_custom[count.index]
  password            = random_password.password_custom[count.index].result
  department          = local.departmentCustom[count.index]
  job_title           = local.jobTitleCustom[count.index]
  usage_location      = "VN"
}
