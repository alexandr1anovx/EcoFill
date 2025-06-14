//
//  InputField.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 14.06.2025.
//

import SwiftUI

struct InputField: View {
  
  let inputType: InputContentType
  @Binding var inputData: String
  
  init(
    for inputType: InputContentType,
    data: Binding<String>
  ) {
    self.inputType = inputType
    self._inputData = data
  }
  
  var body: some View {
    HStack(spacing: 15) {
      Image(systemName: inputType.iconName)
        .frame(width: 18, height: 18)
        .foregroundStyle(.accent)
        .opacity(0.8)
      TextField(inputType.hint, text: $inputData)
        .font(.subheadline)
    }
    .customInputFieldStyle()
  }
}

#Preview {
  InputField(for: .password, data: .constant("Password"))
}
