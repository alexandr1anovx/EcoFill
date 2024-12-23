import SwiftUI

enum Theme: String, CaseIterable {
  case system = "System"
  case light = "Light"
  case dark = "Dark"
  
  var colorScheme: ColorScheme? {
    switch self {
    case .system: return nil
    case .light: return .light
    case .dark: return .dark
    }
  }
}

struct AppThemeCell: View {
  @AppStorage("appTheme") private var appTheme: Theme = .system
  
  var body: some View {
    HStack(spacing: 15) {
      switch appTheme {
      case .system:
        Image(systemName: "moonphase.first.quarter")
          .font(.title2)
      case .light:
        Image(systemName: "sun.max.fill")
          .font(.title2)
          .symbolRenderingMode(.multicolor)
      case .dark:
        Image(systemName: "moon.fill")
          .font(.title2)
          .foregroundStyle(.indigo)
      }
      VStack(alignment: .leading, spacing: 8) {
        Text("App Scheme")
          .font(.poppins(.medium, size: 14))
          .foregroundStyle(.primaryReversed)
        Text("Change background.")
          .font(.poppins(.regular, size: 12))
          .foregroundStyle(.gray)
          .lineLimit(1)
      }
      
      Picker("", selection: $appTheme) {
        Text("System")
          .tag(Theme.system)
        Text("Light")
          .tag(Theme.light)
        Text("Dark")
          .tag(Theme.dark)
      }
      .pickerStyle(.menu)
      .tint(.primaryReversed)
      .onChange(of: appTheme) { _, newScheme in
        appTheme = newScheme
      }
    }
  }
}
