import SwiftUI

enum TextFieldData {
    case initials
    case email
    case password
    case feedbackMessage
}

struct CustomTextField: View {
    let title: String
    let placeholder: String
    var isSecureField: Bool
    let inputData: Binding<String>
    
    
    init(_ title: String, placeholder: String, isSecureField: Bool = false, inputData: Binding<String>) {
        self.title = title
        self.placeholder = placeholder
        self.isSecureField = isSecureField
        self.inputData = inputData
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title)
                .font(.poppins(.medium, size: 15))
                .foregroundStyle(.cmReversed)
            
            if isSecureField {
                SecureField(placeholder, text: inputData)
                    .font(.poppins(.medium, size: 13))
                    .foregroundStyle(.cmReversed)
            } else {
                TextField(placeholder, text: inputData)
                    .font(.poppins(.medium, size: 13))
                    .foregroundStyle(.gray)
            }
            Divider()
        }
    }
}
