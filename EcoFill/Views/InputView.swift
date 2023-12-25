//
//  InputView.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 21.12.2023.
//

import SwiftUI

struct InputView: View {
  @Binding var text: String
  let title: String
  let placeholder: String
  var isSecureField: Bool = false
  
  var body: some View {
    VStack(alignment: .leading, spacing: 15) {
      Text(title)
        .foregroundStyle(.customSystemReversed)
        .font(.callout)
        .fontWeight(.semibold)
      
      if isSecureField {
        SecureField(placeholder, text: $text)
          .font(.footnote)
      } else {
        TextField(placeholder, text: $text)
          .font(.footnote)
      }
      Divider()
    }
  }
}

#Preview {
  InputView(text: .constant(""),
            title: "Email address",
            placeholder: "Enter your email")
}
