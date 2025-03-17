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

struct ColorSchemeChanger: View {
  @AppStorage("appColorScheme") private var appColorScheme: AppColorScheme = .system
  
  var body: some View {
    HStack {
      Text("Color scheme:")
        .font(.subheadline)
        .fontWeight(.medium)
        .foregroundStyle(.primaryLabel)
      Picker("", selection: $appColorScheme) {
        ForEach(AppColorScheme.allCases, id: \.self) { scheme in
          Text(scheme.title)
        }
      }
      .tint(.primaryLabel)
      .onChange(of: appColorScheme) { _, newScheme in
        appColorScheme = newScheme
      }
    }
  }
}

#Preview {
  ColorSchemeChanger()
}
