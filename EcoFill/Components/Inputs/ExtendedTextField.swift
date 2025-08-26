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
    HStack {
      Image(systemName: iconName)
        .foregroundColor(.secondary)
      TextField(hint, text: $inputData, axis: .vertical)
      HStack(spacing: 3) {
        Text("\(inputData.count)").foregroundStyle(.gray)
        Text("/").foregroundStyle(.gray)
        Text("\(maxCount)")
          .foregroundStyle(isReachedLetterLimit ? .red : .gray)
      }
      .font(.caption)
    }
    .padding(.horizontal)
    .frame(height: 55)
    .background(.thinMaterial)
    .clipShape(.rect(cornerRadius: 18))
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
