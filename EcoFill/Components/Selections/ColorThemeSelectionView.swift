import SwiftUI

enum ColorTheme: String, CaseIterable, Identifiable {
  case system, light, dark
  
  var id: String { self.rawValue }
  
  var colorScheme: ColorScheme? {
    switch self {
    case .system:
      return nil
    case .light:
      return .light
    case .dark:
      return .dark
    }
  }
  var title: String {
    self.rawValue.capitalized
  }
}

struct ColorThemeSelectionView: View {
  @AppStorage("colorScheme") private var selectedColorTheme: ColorTheme = .system
  
  var body: some View {
    DisclosureGroup {
      HStack(spacing: 30) {
        ForEach(ColorTheme.allCases) { theme in
          Button {
            selectedColorTheme = theme
          } label: {
            Text(theme.title)
              .padding(12)
              .background(selectedColorTheme == theme ? .primary : Color(.systemGray5))
              .foregroundStyle(selectedColorTheme == theme ? Color(.systemBackground) : .primary)
              .clipShape(.rect(cornerRadius: 15))
          }
          .buttonStyle(.plain)
          .padding(.vertical, 10)
        }
      }
    } label: {
      Text("Color Scheme")
    }
  }
}

#Preview {
  ColorThemeSelectionView()
}
