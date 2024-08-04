//
//  AppearanceChanger.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 11.02.2024.
//

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
    
    // MARK: - Private Properties
    @AppStorage("preferredScheme") private var preferredScheme: Scheme = .system
    
    // MARK: - body
    var body: some View {
        HStack(spacing: 15) {
            switch preferredScheme {
            case .system:
                Image(.system).defaultSize()
            case .light:
                Image(.sun).defaultSize()
            case .dark:
                Image(.moon).defaultSize()
            }
            
            Text("Appearance")
                .font(.lexendBody)
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

#Preview {
    AppearanceChanger()
}
