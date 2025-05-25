//
//  LanguageChanger.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 28.03.2025.
//

import SwiftUI

struct LanguagePickerView: View {
  @State private var isShownAlert = false
  
  var body: some View {
    HStack {
      Text("language_label")
        .font(.subheadline)
        .fontWeight(.medium)
      Spacer()
      Button("Change in Settings") {
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
  LanguagePickerView()
}
