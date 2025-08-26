//
//  DefaultTextField.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 25.08.2025.
//

import SwiftUI

struct DefaultTextField: View {
  let title: String
  let iconName: String
  @Binding var text: String
  var body: some View {
    HStack {
      Image(systemName: iconName)
        .foregroundColor(.secondary)
        .padding(.leading)
      TextField(title, text: $text)
    }
    .frame(height: 55)
    .background(.thinMaterial)
    .clipShape(.rect(cornerRadius: 18))
  }
}

#Preview {
  @Previewable @State var email = "andr1anov@gmail.com"
  
  DefaultTextField(
    title: "Email address",
    iconName: "at",
    text: $email
  )
}
