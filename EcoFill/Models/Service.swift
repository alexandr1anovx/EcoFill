import Foundation
import DeveloperToolsSupport

enum ServiceType: String, CaseIterable, Identifiable {
  case qrcode
  case support
  
  var id: Self { self }
  
  var icon: String {
    switch self {
    case .qrcode: "qrcode"
    case .support: "message"
    }
  }
  
  var title: String {
    switch self {
    case .qrcode: "QR Code"
    case .support: "Support"
    }
  }
  
  var subtitle: String {
    switch self {
    case .qrcode: "Scan this code to get bonuses."
    case .support: "Send a feedback about us."
    }
  }
}

