//
//  ListItem.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 19.05.2025.
//

import SwiftUI

enum ListItem {
  case qrCode
  case support
  
  var title: LocalizedStringKey {
    switch self {
    case .qrCode: "QR Code"
    case .support: "Support"
    }
  }
  
  var subtitle: LocalizedStringKey {
    switch self {
    case .qrCode: "You can scan your QRcode to get bonuses"
    case .support: "Contact support if you have problems"
    }
  }
  
  var iconName: String {
    switch self {
    case .qrCode: "qrcode"
    case .support: "message.fill"
    }
  }
  
  var iconColor: Color {
    switch self {
    case .qrCode: Color.accent
    case .support: Color.accent
    }
  }
}
