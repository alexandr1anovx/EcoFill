//
//  LanguageChanger.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 28.03.2025.
//

import SwiftUI

struct AppLanguageView: View {
  
  @State private var isShownAlert = false
  private let deviceLanguage = Locale.current.language.languageCode?.identifier ?? "Unknown"
  
  var body: some View {
    HStack {
      Text("language_label")
        .font(.subheadline)
        .fontWeight(.medium)
      Text(deviceLanguage)
        .fontWeight(.bold)
        .foregroundStyle(.indigo)
      Spacer()
      Button("change_in_settings") {
        isShownAlert.toggle()
      }
      
    }
    .alert("change_app_language_title", isPresented: $isShownAlert) {
      Button("Cancel", role: .cancel) { isShownAlert = false }
      Button("Continue") { openAppSettings() }
    } message: {
      Text("change_app_language_subtitle")
    }
  }
  
  private func openAppSettings() {
    guard let url = URL(string: UIApplication.openSettingsURLString) else { return }
    if UIApplication.shared.canOpenURL(url) {
      UIApplication.shared.open(url)
    }
  }
}

#Preview {
  AppLanguageView()
}
