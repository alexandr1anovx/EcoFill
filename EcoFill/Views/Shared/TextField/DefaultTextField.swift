import SwiftUI

struct DefaultTextField: View {
  
  @Binding var inputData: String
  let iconName: String
  let hint: String
  
  var body: some View {
    HStack(spacing: 15) {
      Image(systemName: iconName)
        .frame(width: 18, height: 18)
        .foregroundStyle(.primaryIcon)
      TextField(hint, text: $inputData)
        .font(.subheadline)
        .fontWeight(.medium)
    }
  }
}

#Preview {
  DefaultTextField(
    inputData: .constant("Test Input"),
    iconName: "lock",
    hint: "Test Hint"
  )
}
