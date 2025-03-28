//
//  TextFieldForMessage.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 02.03.2025.
//

import SwiftUI

struct ExtendedTextField: View {
  
  @Binding var inputData: String
  let iconName: String
  let hint: LocalizedStringKey
  let maxCount: Int
  
  private var isReachedLetterLimit: Bool {
    inputData.count == maxCount
  }
  
  var body: some View {
    HStack(spacing: 15) {
      Image(systemName: iconName)
        .frame(width: 18, height: 18)
        .foregroundStyle(.primaryIcon)
      TextField(hint, text: $inputData, axis: .vertical)
        .font(.subheadline)
      HStack(spacing: 3) {
        Text("\(inputData.count)").foregroundStyle(.gray)
        Text("/").foregroundStyle(.gray)
        Text("\(maxCount)")
          .foregroundStyle(isReachedLetterLimit ? .red : .gray)
      }
      .font(.caption)
      .fontWeight(.semibold)
    }
    .onChange(of: inputData) { _, newValue in
      if newValue.count >= maxCount {
        inputData = String(newValue.prefix(maxCount))
      }
    }
  }
}

#Preview {
  ExtendedTextField(
    inputData: .constant("Test Feedback Message!"),
    iconName: "message",
    hint: "Enter your message...",
    maxCount: 100
  )
}
