//
//  AppearanceChanger.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 11.02.2024.
//

import SwiftUI

enum Theme: String, CaseIterable {
  case systemDefault = "System"
  case light = "Light"
  case dark = "Dark"
  
  var colorScheme: ColorScheme? {
    switch self {
    case .systemDefault: return nil
    case .light: return .light
    case .dark: return .dark
    }
  }
}
  
struct AppearanceChanger: View {
  
  // MARK: - Properties
  @AppStorage("selectedTheme") private var selectedTheme: Theme = .systemDefault
  
  var body: some View {
    HStack(spacing: 20) {
      Image(selectedTheme == .dark ? .moon : .sun)
        .defaultSize()
      
      Text("Appearance")
        .font(.lexendBody)
        .foregroundStyle(.cmReversed)
      
      Picker("", selection: $selectedTheme) {
        Text("System").tag(Theme.systemDefault)
        Text("Light").tag(Theme.light)
        Text("Dark").tag(Theme.dark)
      }
      .pickerStyle(.menu)
      .tint(.cmReversed)
      .onChange(of: selectedTheme) { _, newValue in
        selectedTheme = newValue
      }
    }
  }
}

#Preview {
  AppearanceChanger()
}
