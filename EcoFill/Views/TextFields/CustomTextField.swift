//
//  InputView.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 21.12.2023.
//

import SwiftUI

struct CustomTextField: View {
  
  // MARK: - Properties
  @Binding var inputData: String
  var title: String
  var placeholder: String
  var isSecureField = false
  
  var body: some View {
    VStack(alignment: .leading, spacing: 15) {
      Text(title)
        .foregroundStyle(.cmReversed)
        .font(.lexendCallout)
      
      if isSecureField {
        SecureField(placeholder, text: $inputData)
          .font(.lexendFootnote)
          .foregroundStyle(.cmReversed)
      } else {
        TextField(placeholder, text: $inputData)
          .font(.lexendFootnote)
          .foregroundStyle(.gray)
      }
      
      Divider()
    }
  }
}
