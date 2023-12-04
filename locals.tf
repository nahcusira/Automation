locals {
  csv_data   = csvdecode(file(var.file))
  name       = distinct(local.csv_data[*]["Name"])
  jobTitle = distinct(local.csv_data[*]["JobTitle"])
  department = distinct(local.csv_data[*]["Department"])
  user_data = { for i in range(length(azuread_user.user)) :
    azuread_user.user[i].user_principal_name => random_password.password[i].result
  }

  csv_data_null = csvdecode(file(var.file_null))
  name_null     = distinct(local.csv_data_null[*]["Name"])
  jobTitleNull = distinct(local.csv_data_null[*]["JobTitle"])
  departmentNull = distinct(local.csv_data_null[*]["Department"])
  user_data_null = { for i in range(length(azuread_user.user_null)) :
    azuread_user.user_null[i].user_principal_name => random_password.password_null[i].result
  }

  csv_data_custom = csvdecode(file(var.file_custom))
  name_custom     = distinct(local.csv_data_custom[*]["Name"])
  jobTitleCustom = distinct(local.csv_data_custom[*]["JobTitle"])
  departmentCustom = distinct(local.csv_data_custom[*]["Department"])
  user_data_custom = { for i in range(length(azuread_user.user_custom)) :
    azuread_user.user_custom[i].user_principal_name => random_password.password_custom[i].result
  }
}