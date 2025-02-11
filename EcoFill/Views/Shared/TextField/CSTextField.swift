import SwiftUI

struct CSTextField: View {
  
  let icon: String
  let prompt: String
  @Binding var inputData: String
  var isSecure = false
  
  var body: some View {
    HStack(spacing: 15) {
      Image(icon)
        .imageScale(.medium)
        .foregroundStyle(.accent)
      Group {
        if isSecure {
          SecureField(prompt, text: $inputData)
        } else {
          TextField(prompt, text: $inputData)
        }
      }
      .font(.subheadline)
      .fontDesign(.monospaced)
    }
    .listRowInsets(
      EdgeInsets(
        top: 28,
        leading: 15,
        bottom: 22,
        trailing: 15
      )
    )
  }
}

#Preview {
  CSTextField(
    icon: "man",
    prompt: "Enter your password",
    inputData: .constant("123")
  )
}
