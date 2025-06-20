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
  case helpUsImprove
  case aboutTheDeveloper
  case logout
  
  var title: LocalizedStringKey {
    switch self {
    case .qrCode: "QR Code"
    case .support: "Support"
    case .updatePersonalData: "Update Personal Data"
    case .helpUsImprove: "Help us improve"
    case .aboutTheDeveloper: "About The Developer"
    case .logout: "Log Out"
    }
  }
  
  var subtitle: LocalizedStringKey? {
    switch self {
    case .qrCode: "You can scan your QRcode to get bonuses"
    case .support: "Contact support if you have problems"
    case .updatePersonalData: nil
    case .helpUsImprove: "Leave us a review — your feedback means a lot!"
    case .aboutTheDeveloper: nil
    case .logout: nil
    }
  }
  
  var iconName: String {
    switch self {
    case .qrCode: "qrcode"
    case .support: "message.fill"
    case .updatePersonalData: "person"
    case .helpUsImprove: "hand.thumbsup"
    case .aboutTheDeveloper: "apple.logo"
    case .logout: "door.left.hand.open"
    }
  }
  
  var iconColor: Color {
    switch self {
    case .qrCode: Color.accent
    case .support: Color.accent
    case .updatePersonalData: Color.primary
    case .helpUsImprove: Color.orange
    case .aboutTheDeveloper: Color.primary
    case .logout: Color.red
    }
  }
}
