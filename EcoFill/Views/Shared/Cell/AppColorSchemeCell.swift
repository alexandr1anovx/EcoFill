import SwiftUI

enum AppColorScheme: String, CaseIterable {
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

struct AppColorSchemeCell: View {
  @AppStorage("appColorScheme") private var appColorScheme: AppColorScheme = .system
  
  var body: some View {
    HStack(spacing: 15) {
      switch appColorScheme {
      case .system:
        Image(systemName: "moonphase.first.quarter")
          .imageScale(.medium)
      case .light:
        Image(systemName: "sun.max")
          .imageScale(.medium)
          .symbolVariant(.fill)
          .symbolRenderingMode(.multicolor)
      case .dark:
        Image(systemName: "moon")
          .imageScale(.medium)
          .symbolVariant(.fill)
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
      
      Picker("", selection: $appColorScheme) {
        Text("System")
          .tag(AppColorScheme.system)
        Text("Light")
          .tag(AppColorScheme.light)
        Text("Dark")
          .tag(AppColorScheme.dark)
      }
      .pickerStyle(.menu)
      .tint(.primaryReversed)
      .onChange(of: appColorScheme) { _, newScheme in
        appColorScheme = newScheme
      }
    }
  }
}

#Preview {
  AppColorSchemeCell()
}
