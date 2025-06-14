//
//  SecuredInputField.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 14.06.2025.
//

import SwiftUI

struct InputFieldSecured: View {
  
  let inputType: InputContentType
  @Binding var inputData: String
  @State private var isShownPassword = false
  @FocusState private var inputStatus: InputContentStatus?
  
  init(
    for inputType: InputContentType,
    data: Binding<String>
  ) {
    self.inputType = inputType
    self._inputData = data
  }
  
  var body: some View {
    HStack {
      inputField
      Image(systemName: isShownPassword ? "eye" : "eye.slash")
        .opacity(!inputData.isEmpty ? 1:0)
        .disabled(inputData.isEmpty)
        .foregroundStyle(.gray)
        .onTapGesture {
          isShownPassword.toggle()
        }
    }
    .customInputFieldStyle()
  }
  
  var inputField: some View {
    HStack(spacing: 15) {
      Image(systemName: inputType.iconName)
        .frame(width: 18, height: 18)
        .foregroundStyle(.accent)
      if isShownPassword {
        TextField(inputType.hint, text: $inputData)
          .focused($inputStatus, equals: .notSecured)
          .keyboardType(.asciiCapable)
          .font(.subheadline)
      } else {
        SecureField(inputType.hint, text: $inputData)
          .focused($inputStatus, equals: .secured)
          .keyboardType(.asciiCapable)
          .font(.subheadline)
      }
    }
    .textInputAutocapitalization(.never)
    .autocorrectionDisabled(true)
    .onChange(of: isShownPassword) {
      inputStatus = isShownPassword ? .notSecured : .secured
    }
    .onChange(of: inputData) { _, newValue in
      if newValue.count > 20 {
        inputData = String(newValue.prefix(20))
      }
    }
  }
}

#Preview {
  InputFieldSecured(for: .password, data: .constant("123456"))
}
