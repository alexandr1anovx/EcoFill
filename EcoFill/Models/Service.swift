import SwiftUI

enum ServiceType: String, Identifiable, CaseIterable {
  case qrcode = "QR Code"
  case support = "Support"
  
  var id: String { self.rawValue }
  
  var icon: String {
    switch self {
    case .qrcode: "qrcode"
    case .support: "message"
    }
  }
}

