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
    @AppStorage("preferredScheme") private var preferredScheme: Scheme = .system
    
    var body: some View {
        HStack(spacing: 15) {
            switch preferredScheme {
            case .system:
                Image(.circleLefthalf).defaultImageSize
            case .light:
                Image(.sun).defaultImageSize
            case .dark:
                Image(.moon).defaultImageSize
            }
            
            Text("Appearance")
                .font(.system(size: 16))
                .fontWeight(.medium)
                .fontDesign(.rounded)
                .foregroundStyle(.cmReversed)
            
            Picker("", selection: $preferredScheme) {
                Text("System").tag(Scheme.system)
                Text("Light").tag(Scheme.light)
                Text("Dark").tag(Scheme.dark)
            }
            .pickerStyle(.menu)
            .tint(.cmReversed)
            .onChange(of: preferredScheme) { _, newScheme in
                preferredScheme = newScheme
            }
        }
    }
}

