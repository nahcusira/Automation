locals {
  # Read content of CSV file
  csv_data   = csvdecode(file(var.file))
  # Extract all Name, JobTitle, Department without duplicates from CSV file
  name       = distinct(local.csv_data[*]["Name"])
  jobTitle = distinct(local.csv_data[*]["JobTitle"])
  department = distinct(local.csv_data[*]["Department"])
  # Creates a map associating user principal names with randomly generated passwords
  user_data = { for i in range(length(azuread_user.user)) :
    azuread_user.user[i].user_principal_name => random_password.password[i].result
  }

  # Read content of CSV file
  csv_data_null = csvdecode(file(var.file_null))
  # Extract all Name, JobTitle, Department without duplicates from CSV file
  name_null     = distinct(local.csv_data_null[*]["Name"])
  jobTitleNull = distinct(local.csv_data_null[*]["JobTitle"])
  departmentNull = distinct(local.csv_data_null[*]["Department"])
  # Creates a map associating user principal names with randomly generated passwords
  user_data_null = { for i in range(length(azuread_user.user_null)) :
    azuread_user.user_null[i].user_principal_name => random_password.password_null[i].result
  }

  # Read content of CSV file
  csv_data_custom = csvdecode(file(var.file_custom))
  # Extract all Name, JobTitle, Department without duplicates from CSV file
  name_custom     = distinct(local.csv_data_custom[*]["Name"])
  jobTitleCustom = distinct(local.csv_data_custom[*]["JobTitle"])
  departmentCustom = distinct(local.csv_data_custom[*]["Department"])
  # Creates a map associating user principal names with randomly generated passwords
  user_data_custom = { for i in range(length(azuread_user.user_custom)) :
    azuread_user.user_custom[i].user_principal_name => random_password.password_custom[i].result
  }
}