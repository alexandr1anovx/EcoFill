//
//  LanguageChanger.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 28.03.2025.
//

import SwiftUI

struct ChangeAppLanguageView: View {
  
  @State private var isShownAlert = false
  private let deviceLanguage = Locale.current.language.languageCode?.identifier ?? "Unknown"
  
  var body: some View {
    HStack {
      Text("Language:")
        .font(.subheadline)
        .fontWeight(.medium)
      Text(deviceLanguage)
        .fontWeight(.bold)
        .foregroundStyle(.indigo)
      Spacer()
      Button("Change In Settings") {
        isShownAlert.toggle()
      }
      
    }
    .alert("Change App Language", isPresented: $isShownAlert) {
      Button("Cancel", role: .cancel) { isShownAlert = false }
      Button("Continue") { openAppSettings() }
    } message: {
      Text("You will be redirected to the Settings screen to change the app's language. Do you want to continue?")
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
  ChangeAppLanguageView()
}
