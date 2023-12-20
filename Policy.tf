# Policy 8: Block download from Unmanaged devices (Need Microsoft Endpoint Manager) (Terraform)

resource "azuread_conditional_access_policy" "Block_download_from_Unmanaged_devices" {
  display_name = "CA008: Block download from Unmanaged devices (Terraform)"
  state        = "disabled"
  conditions {
    client_app_types = ["all"]

    applications {
      included_applications = ["office365", "00000003-0000-0ff1-ce00-000000000000", "00000002-0000-0ff1-ce00-000000000000"]
    }
    users {
      included_users = ["all"]
      excluded_users = ["66a13722-bc59-409f-8558-ed908b883f02"]
    }
    devices {
      filter {
        mode = "exclude"
        rule = "device.trustType -eq \"AzureAD\" -or device.trustType -eq \"ServerAD\""
      }
    }
  }
  grant_controls {
    operator          = "AND"
    built_in_controls = ["mfa"]
  }
  session_controls {
    application_enforced_restrictions_enabled = true
  }
}

# Policy 9: Re-authentication after 4 hours from Unmanaged devices (Need Microsoft Endpoint Manager) (Terraform)

resource "azuread_conditional_access_policy" "Re_authentication_after_4_hours_from_Unmanaged_devices" {
  display_name = "CA009: Re-authentication after 4 hours from Unmanaged devices (Terraform)"
  state        = "disabled"
  conditions {
    client_app_types = ["all"]

    applications {
      included_applications = ["office365", "00000003-0000-0ff1-ce00-000000000000", "00000002-0000-0ff1-ce00-000000000000"]
    }
    users {
      included_users = ["all"]
      excluded_users = ["66a13722-bc59-409f-8558-ed908b883f02"]
    }
    devices {
      filter {
        mode = "exclude"
        rule = "device.trustType -eq \"AzureAD\" -or device.trustType -eq \"ServerAD\""
      }
    }
  }
  grant_controls {
    operator          = "AND"
    built_in_controls = ["mfa"]
  }
  session_controls {
    sign_in_frequency        = 4
    sign_in_frequency_period = "hours"
  }
}

# Policy 10: Prevent keep browser session from Unmanaged devices (Need Microsoft Endpoint Manager) (Terraform)

resource "azuread_conditional_access_policy" "Prevent_keep_browser_session_from_Unmanaged_devices" {
  display_name = "CA010: Prevent keep browser session from Unmanaged devices (Terraform)"
  state        = "disabled"
  conditions {
    client_app_types = ["all"]

    applications {
      included_applications = ["all"]
    }
    users {
      included_users = ["all"]
      excluded_users = ["66a13722-bc59-409f-8558-ed908b883f02"]
    }
    devices {
      filter {
        mode = "exclude"
        rule = "device.trustType -eq \"AzureAD\" -or device.trustType -eq \"ServerAD\""
      }
    }
  }
  grant_controls {
    operator          = "AND"
    built_in_controls = ["mfa"]
  }
  session_controls {
    persistent_browser_mode = "never"
  }
}

# Policy 11: User risk-based password change (Terraform)

resource "azuread_conditional_access_policy" "MFA_risk_user" {
  display_name = "CA011: MFA for User risk-based password change (Terraform)"
  state        = "disabled"
  conditions {
    client_app_types = ["all"]

    applications {
      included_applications = ["all"]
    }
    platforms {
      included_platforms = ["all"]
      excluded_platforms = []
    }
    users {
      included_users = ["all"]
      excluded_users = ["66a13722-bc59-409f-8558-ed908b883f02"]
    }
  }
  grant_controls {
    operator          = "AND"
    built_in_controls = ["mfa"]
  }
}

resource "azuread_conditional_access_policy" "passwordchangeUserRiskBased" {
  display_name = "CA011: User risk-based password change (Terraform)"
  state        = "disabled"
  conditions {
    client_app_types = ["all"]
    user_risk_levels = ["high"]
    applications {
      included_applications = ["all"]
    }
    users {
      included_users = ["all"]
      excluded_users = ["66a13722-bc59-409f-8558-ed908b883f02"]
    }
  }
  grant_controls {
    operator          = "AND"
    built_in_controls = ["mfa", "passwordChange"]
  }
}
