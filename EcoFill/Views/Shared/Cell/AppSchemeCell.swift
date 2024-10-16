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

struct AppSchemeCell: View {
    @AppStorage("appScheme") private var appScheme: Scheme = .system
    
    var body: some View {
        HStack(spacing: 15) {
            switch appScheme {
            case .system:
                Image(systemName: "moonphase.first.quarter")
                    .font(.title2)
            case .light:
                Image(systemName: "sun.max.fill")
                    .font(.title2)
                    .symbolRenderingMode(.multicolor)
            case .dark:
                Image(systemName: "moon.fill")
                    .font(.title2)
                    .foregroundStyle(.indigo)
            }
            VStack(alignment: .leading, spacing: 8) {
                Text("App Scheme")
                    .font(.poppins(.medium, size: 14))
                    .foregroundStyle(.primaryBackgroundReversed)
                Text("Change background.")
                    .font(.poppins(.regular, size: 12))
                    .foregroundStyle(.gray)
                    .lineLimit(1)
            }
            
            Picker("", selection: $appScheme) {
                Text("System").tag(Scheme.system)
                Text("Light").tag(Scheme.light)
                Text("Dark").tag(Scheme.dark)
            }
            .pickerStyle(.menu)
            .tint(.primaryBackgroundReversed)
            .onChange(of: appScheme) { _, newScheme in
                appScheme = newScheme
            }
        }
    }
}
