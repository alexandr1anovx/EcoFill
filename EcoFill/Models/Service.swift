import SwiftUI

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
  
  var title: LocalizedStringKey {
    switch self {
    case .qrcode: "qrcode_title"
    case .support: "support_title"
    }
  }
  
  var subtitle: LocalizedStringKey {
    switch self {
    case .qrcode: "qrcode_subtitle"
    case .support: "support_subtitle"
    }
  }
}

