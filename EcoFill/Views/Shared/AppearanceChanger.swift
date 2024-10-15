import SwiftUI

enum Scheme: String, CaseIterable {
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

struct AppearanceChanger: View {
    @AppStorage("appScheme") private var appScheme: Scheme = .system
    
    var body: some View {
        HStack(spacing: 15) {
            switch appScheme {
            case .system:
                Image(.circleLefthalf).defaultImageSize
            case .light:
                Image(.sun).defaultImageSize
            case .dark:
                Image(.moon).defaultImageSize
            }
            
            Picker("Appearance", selection: $appScheme) {
                Text("System").tag(Scheme.system)
                Text("Light").tag(Scheme.light)
                Text("Dark").tag(Scheme.dark)
            }
            .pickerStyle(.menu)
            .tint(.cmReversed)
            .onChange(of: appScheme) { _, newScheme in
                appScheme = newScheme
            }
        }
    }
}

