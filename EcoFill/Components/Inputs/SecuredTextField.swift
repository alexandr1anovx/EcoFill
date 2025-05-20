//
//  PasswordTextField.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 14.03.2025.
//

import SwiftUI

enum TextFieldStatus {
  case secured, notSecured
}

struct SecuredTextField: View {
  
  @Binding var inputData: String
  let iconName: String
  let hint: LocalizedStringKey
  @State private var isShownData = false
  @FocusState var fieldStatus: TextFieldStatus?
  
  var body: some View {
    HStack {
      textField
      Image(systemName: isShownData ? "eye" : "eye.slash")
        .opacity(inputData.count >= 1 ? 1 : 0)
        .disabled(inputData.count < 1)
        .foregroundStyle(.gray)
        .onTapGesture {
          isShownData.toggle()
        }
    }
  }
  
  var textField: some View {
    Group {
      if isShownData {
        HStack(spacing: 15) {
          Image(systemName: iconName)
            .frame(width: 18, height: 18)
            .foregroundStyle(.accent)
          TextField(hint, text: $inputData)
            .focused($fieldStatus, equals: .notSecured)
            .font(.subheadline)
            .keyboardType(.asciiCapable)
        }
      } else {
        HStack(spacing: 15) {
          Image(systemName: iconName)
            .frame(width: 18, height: 18)
            .foregroundStyle(.accent)
          SecureField(hint, text: $inputData)
            .focused($fieldStatus, equals: .secured)
            .font(.subheadline)
            .keyboardType(.asciiCapable)
        }
      }
    }
    .textInputAutocapitalization(.never)
    .autocorrectionDisabled(true)
    .onChange(of: isShownData) { _, newValue in
      fieldStatus = isShownData ? .notSecured : .secured
    }
    .onChange(of: inputData) { _, newValue in
      if inputData.count >= 20 {
        inputData = String(newValue.prefix(20))
      }
    }
  }
}

#Preview {
  SecuredTextField(
    inputData: .constant("Test Data"),
    iconName: "lock",
    hint: "Enter your password..."
  )
}
