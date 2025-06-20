import SwiftUI

enum ColorTheme: String, Identifiable, CaseIterable {
  case system
  case light
  case dark
  
  var id: Self { self }
  
  var colorTheme: ColorScheme? {
    switch self {
    case .system: return nil
    case .light: return .light
    case .dark: return .dark
    }
  }
  var title: LocalizedStringKey {
    switch self {
    case .system: return "System"
    case .light: return "Light"
    case .dark: return "Dark"
    }
  }
}

struct ColorThemeSelectionView: View {
  @AppStorage("colorTheme") private var selectedColorTheme: ColorTheme = .system
  
  var body: some View {
    HStack {
      Text("Theme:")
        .font(.subheadline)
        .fontWeight(.medium)
      Picker("", selection: $selectedColorTheme) {
        ForEach(ColorTheme.allCases, id: \.self) { theme in
          Text(theme.title)
        }
      }.pickerStyle(.segmented)
    }
  }
}

#Preview {
  ColorThemeSelectionView()
}
