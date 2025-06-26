//
//  InputField.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 14.06.2025.
//

import SwiftUI

struct InputField: View {
  
  private let inputType: InputContentType
  private let validation: InputFieldValidation
  @Binding var inputData: String
  @State private var isPasswordVisible = false
  
  init(
    _ inputType: InputContentType,
    inputData: Binding<String>,
    validation: InputFieldValidation = .none
  ) {
    self.inputType = inputType
    self._inputData = inputData
    self.validation = validation
  }
  
  var body: some View {
    HStack {
      Image(systemName: inputType.iconName)
        .frame(width: 18, height: 18)
        .foregroundStyle(.accent)
      Group {
        if case .password = inputType, !isPasswordVisible {
          SecureField(inputType.hint, text: $inputData)
        } else {
          TextField(inputType.hint, text: $inputData)
        }
      }
      .font(.subheadline)
      .onChange(of: inputData) { _, newValue in
        if inputType.shouldShowPasswordToggle {
          if newValue.count > 20 {
            inputData = String(newValue.prefix(20))
          }
        }
      }
      
      if case .password = inputType {
        Image(systemName: isPasswordVisible ? "eye" : "eye.slash")
          .opacity(!inputData.isEmpty ? 1 : 0)
          .disabled(inputData.isEmpty)
          .foregroundStyle(.gray)
          .onTapGesture {
            isPasswordVisible.toggle()
          }
      }
      
      if case .passwordConfirmation(let matchingPassword) = validation {
        Image(
          systemName: inputData == matchingPassword && !inputData.isEmpty ? "checkmark.circle.fill" : "xmark.circle.fill"
        )
        .foregroundStyle(
          inputData == matchingPassword && !inputData.isEmpty ? .green : .red
        )
        .opacity(!inputData.isEmpty ? 1 : 0)
      }
    }
    .customInputFieldStyle()
  }
}

#Preview {
  InputField(.password, inputData: .constant("Password"))
}
