import SwiftUI

enum AppColorScheme: String, CaseIterable {
  case system, light, dark
  
  var colorScheme: ColorScheme? {
    switch self {
    case .system: return nil
    case .light: return .light
    case .dark: return .dark
    }
  }
}

struct AppColorSchemeCell: View {
  @AppStorage("appColorScheme") private var appColorScheme = AppColorScheme.system
  
  var body: some View {
    HStack(spacing: 15) {
      selectedSchemeImage
      
      Text("Color scheme:")
        .font(.poppins(.medium, size: 14))
        .foregroundStyle(.primaryReversed)
      
      Picker("", selection: $appColorScheme) {
        ForEach(AppColorScheme.allCases, id: \.self) { scheme in
          Text(scheme.rawValue.capitalized)
        }
      }
      .tint(.primaryReversed)
      .onChange(of: appColorScheme) { _, newScheme in
        appColorScheme = newScheme
      }
    }
  }
  
  @ViewBuilder
  private var selectedSchemeImage: some View {
    Group {
      switch appColorScheme {
      case .system:
        Image(systemName: "moonphase.first.quarter")
      case .light:
        Image(systemName: "sun.max")
          .symbolVariant(.fill)
          .symbolRenderingMode(.multicolor)
      case .dark:
        Image(systemName: "moon")
          .symbolVariant(.fill)
          .foregroundStyle(.indigo)
      }
    }
    .imageScale(.medium)
  }
}

#Preview {
  AppColorSchemeCell()
}
