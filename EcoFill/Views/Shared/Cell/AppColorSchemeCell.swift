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
  
  var title: String { self.rawValue.capitalized }
}

struct AppColorSchemeCell: View {
  @AppStorage("appColorScheme") private var appColorScheme = AppColorScheme.system
  
  var body: some View {
    HStack(spacing: 15) {
      schemeIcon
      schemeTitle
      schemePicker
    }
  }
  
  private var schemeIcon: some View {
    Group {
      switch appColorScheme {
      case .system:
        Image(.nightDay)
          .foregroundStyle(.indigo)
      case .light:
        Image(.sun)
          .foregroundStyle(.yellow)
      case .dark:
        Image(.moon)
          .foregroundStyle(.indigo)
      }
    }
  }
  
  private var schemeTitle: some View {
    Text("Color scheme:")
      .font(.system(size: 15))
      .fontWeight(.medium)
      .fontDesign(.monospaced)
      .foregroundStyle(.primaryReversed)
  }
  
  private var schemePicker: some View {
    Picker("", selection: $appColorScheme) {
      ForEach(AppColorScheme.allCases, id: \.self) { scheme in
        Text(scheme.title)
      }
    }
    .tint(.primaryReversed)
    .onChange(of: appColorScheme) { _, newScheme in
      appColorScheme = newScheme
    }
  }
}

#Preview {
  AppColorSchemeCell()
}
