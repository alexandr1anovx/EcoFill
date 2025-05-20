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
    case .qrCode: "QR Code"
    case .support: "Support"
    case .settings: "Settings"
    case .rateUs: "Rate Us"
    case .signOut: "Sign Out"
    case .language: "Language"
    case .updateEmail: "Update email"
    case .deleteAccount: "Delete account"
    }
  }
  
  var subtitle: LocalizedStringKey? {
    switch self {
    case .qrCode: "Scan code to receive bonuses."
    case .support: "Let us know about application errors."
    case .settings: "Update personal information."
    case .rateUs: "Help others to know about us."
    case .signOut: "Sign out of your account."
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
