import SwiftUI

enum ColorTheme: String, Identifiable, CaseIterable {
  case system, light, dark
  
  var id: Self { self }
  
  var title: LocalizedStringKey {
    switch self {
    case .system: "theme_system"
    case .light: "theme_light"
    case .dark: "theme_dark"
    }
  }
  
  var colorTheme: ColorScheme? {
    switch self {
    case .system: return nil
    case .light: return .light
    case .dark: return .dark
    }
  }
}

struct ColorThemePickerView: View {
  @AppStorage("colorTheme") private var selectedColorTheme: ColorTheme = .system
  
  var body: some View {
    HStack {
      Text("color_theme_label")
        .font(.subheadline)
        .fontWeight(.medium)
      Picker("", selection: $selectedColorTheme) {
        ForEach(ColorTheme.allCases) { theme in
          Text(theme.title)
        }
      }
    }
  }
}

#Preview {
  ColorThemePickerView()
}
