//
//  InputFieldContent.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 13.05.2025.
//

import SwiftUICore

enum InputContent {
  case fullName
  case email
  case password
  case confirmedPassword
  case support
  
  var iconName: String {
    switch self {
    case .fullName: "person"
    case .email: "envelope"
    case .password: "lock"
    case .confirmedPassword: "lock"
    case .support: "message"
    }
  }
  
  var hint: LocalizedStringKey {
    switch self {
    case .fullName: "Full name"
    case .email: "Email"
    case .password: "Password"
    case .confirmedPassword: "Confirm Password"
    case .support: "Message"
    }
  }
}

enum InputFieldValidation {
  case none
  case passwordConfirmation(matchingPassword: String)
}

// MARK: - Extension: InputContentType

extension InputContent {
  var shouldShowPasswordToggle: Bool {
    switch self {
    case .password, .confirmedPassword:
      return true
    default:
      return false
    }
  }
}
