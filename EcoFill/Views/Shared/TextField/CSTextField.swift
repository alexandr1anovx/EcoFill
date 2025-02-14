import SwiftUI

struct CSTextField: View {
  
  let icon: ImageResource
  let hint: String
  @Binding var inputData: String
  var isSecure = false
  
  var body: some View {
    HStack(spacing: 15) {
      Image(icon).foregroundStyle(.accent)
      Group {
        if isSecure {
          SecureField(hint, text: $inputData)
        } else {
          TextField(hint, text: $inputData)
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
    icon: .user,
    hint: "Enter your password",
    inputData: .constant("123")
  )
}
