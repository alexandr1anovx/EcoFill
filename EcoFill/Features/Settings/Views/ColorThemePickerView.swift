import SwiftUI

enum ColorTheme: String, CaseIterable {
  case system, light, dark
  var title: String { rawValue.capitalized }
  
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
      Text("Color scheme:")
        .font(.subheadline)
        .fontWeight(.medium)
        .foregroundStyle(.primaryLabel)
      Picker("", selection: $selectedColorTheme) {
        ForEach(ColorTheme.allCases, id: \.self) { theme in
          Text(theme.title)
        }
      }
      .tint(.primaryLabel)
    }
  }
}

#Preview {
  ColorThemePickerView()
}
