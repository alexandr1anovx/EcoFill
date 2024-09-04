import SwiftUI

enum TextFieldData {
    case initials
    case email
    case password
    case confirmPassword
    case newPassword
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
                .font(.system(size: 16, weight: .medium, design: .rounded))
            
            if isSecureField {
                SecureField(placeholder, text: $inputData)
                    .font(.system(size: 14))
                    .fontWeight(.medium)
                    .fontDesign(.rounded)
                    .foregroundStyle(.cmReversed)
            } else {
                TextField(placeholder, text: $inputData)
                    .font(.system(size: 14))
                    .fontWeight(.medium)
                    .fontDesign(.rounded)
                    .foregroundStyle(.gray)
            }
            Divider()
        }
    }
}

