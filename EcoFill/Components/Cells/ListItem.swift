//
//  ListItem.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 19.05.2025.
//

import SwiftUI

enum ListItem {
  // Home
  case qrCode
  case support
  // Profile
  case settings
  case rateUs
  case signOut
  // Settings
  case language
  case updateEmail
  case deleteAccount
  
  var title: LocalizedStringKey {
    switch self {
    case .qrCode: "qrcode_title"
    case .support: "support_title"
    case .settings: "settings_title"
    case .rateUs: "rate_us_title"
    case .signOut: "sign_out_title"
    case .language: "Language"
    case .updateEmail: "Update email"
    case .deleteAccount: "Delete account"
    }
  }
  
  var subtitle: LocalizedStringKey? {
    switch self {
    case .qrCode: "qrcode_subtitle"
    case .support: "support_subtitle"
    case .settings: "settings_subtitle"
    case .rateUs: "rate_us_subtitle"
    case .signOut: "sign_out_subtitle"
    case .language: nil
    case .updateEmail: "Update your email address."
    case .deleteAccount: "Pernamently delete your account."
    }
  }
  
  var iconName: String {
    switch self {
    case .qrCode: "qrcode"
    case .support: "message.fill"
    case .settings: "gear"
    case .rateUs: "hand.thumbsup"
    case .signOut: "door.left.hand.open"
    case .language: "globe"
    case .updateEmail: "envelope"
    case .deleteAccount: "xmark.circle.fill"
    }
  }
  
  var iconColor: Color {
    switch self {
    case .qrCode: Color.accent
    case .support: Color.accent
    case .settings: Color.primary
    case .rateUs: Color.orange
    case .signOut: Color.red
    case .language: Color.pink
    case .updateEmail: Color.primary
    case .deleteAccount: Color.red
    }
  }
}
