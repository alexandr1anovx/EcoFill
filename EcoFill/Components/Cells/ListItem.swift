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
  // Settings
  case updatePersonalData
  case rateUs
  case aboutTheDeveloper
  case logout
  case deleteAccount
  
  var title: LocalizedStringKey {
    switch self {
    case .qrCode: "qrcode_title"
    case .support: "support_title"
    case .updatePersonalData: "update_personal_data"
    case .rateUs: "rate_us_title"
    case .aboutTheDeveloper: "about_the_developer"
    case .logout: "logout_title"
    case .deleteAccount: "delete_account_title"
    }
  }
  
  var subtitle: LocalizedStringKey? {
    switch self {
    case .qrCode: "qrcode_subtitle"
    case .support: "support_subtitle"
    case .updatePersonalData: nil
    case .rateUs: "rate_us_subtitle"
    case .aboutTheDeveloper: nil
    case .logout: nil
    case .deleteAccount: nil
    }
  }
  
  var iconName: String {
    switch self {
    case .qrCode: "qrcode"
    case .support: "message.fill"
    case .updatePersonalData: "person"
    case .rateUs: "hand.thumbsup"
    case .aboutTheDeveloper: "apple.logo"
    case .logout: "door.left.hand.open"
    case .deleteAccount: "xmark.circle.fill"
    }
  }
  
  var iconColor: Color {
    switch self {
    case .qrCode: Color.accent
    case .support: Color.accent
    case .updatePersonalData: Color.primary
    case .rateUs: Color.orange
    case .aboutTheDeveloper: Color.primary
    case .logout: Color.red
    case .deleteAccount: Color.red
    }
  }
}
