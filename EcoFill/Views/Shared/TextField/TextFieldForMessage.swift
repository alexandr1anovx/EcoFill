//
//  TextFieldForMessage.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 02.03.2025.
//

import SwiftUI

struct TextFieldForMessage: View {
  
  let hint: String
  @Binding var inputData: String
  
  init(_ hint: String, _ inputData: Binding<String>) {
    self.hint = hint
    self._inputData = inputData
  }
  
  var body: some View {
    HStack(spacing: 15) {
      Image(.message).foregroundStyle(.accent)
      TextField(hint, text: $inputData, axis: .vertical)
      .font(.subheadline)
      .fontDesign(.monospaced)
    }
    .listRowInsets(
      EdgeInsets(top: 28, leading: 15, bottom: 22, trailing: 15)
    )
  }
}

#Preview {
  TextFieldForMessage("Enter your message.", .constant("Welcome!"))
}
