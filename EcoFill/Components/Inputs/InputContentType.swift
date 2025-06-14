//
//  InputFieldContent.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 13.05.2025.
//

import SwiftUICore

enum InputContentType {
  case fullName
  case emailAddress
  case password
  case passwordConfirmation
  case supportMessage
  
  var hint: LocalizedStringKey {
    switch self {
    case .fullName: "input_fullName"
    case .emailAddress: "input_email"
    case .password: "input_password"
    case .passwordConfirmation: "input_password_confirmation"
    case .supportMessage: "input_supportMessage"
    }
  }
  
  var iconName: String {
    switch self {
    case .fullName: "person.crop.circle"
    case .emailAddress: "envelope"
    case .password: "lock"
    case .passwordConfirmation: "lock"
    case .supportMessage: "message"
    }
  }
}

enum InputContentStatus {
  case secured, notSecured
}
