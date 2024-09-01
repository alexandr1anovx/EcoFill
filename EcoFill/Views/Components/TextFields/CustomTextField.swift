import SwiftUI

enum TextFieldData {
    case initials, email, password, confirmPassword, newPassword
    case message
}

struct CustomTextField: View {
    @Binding var inputData: String
    let title: String
    let placeholder: String
    var isSecureField = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text(title)
                .foregroundStyle(.cmReversed)
                .font(.lexendCallout)
            
            if isSecureField {
                SecureField(placeholder, text: $inputData)
                    .font(.lexendFootnote)
                    .foregroundStyle(.cmReversed)
            } else {
                TextField(placeholder, text: $inputData)
                    .font(.lexendFootnote)
                    .foregroundStyle(.gray)
            }
            Divider()
        }
    }
}
