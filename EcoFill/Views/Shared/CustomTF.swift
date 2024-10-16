import SwiftUI

enum TextFieldContent {
    case initials, email, password, feedbackMessage
}

struct CustomTF: View {
    let header: String
    let placeholder: String
    let data: Binding<String>
    var isSecure: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(header)
                .font(.poppins(.medium, size: 14))
                .foregroundStyle(.primaryBackgroundReversed)
            Group {
                if isSecure {
                    SecureField(placeholder, text: data)
                } else {
                    TextField(placeholder, text: data)
                }
            }
            .font(.poppins(.regular, size: 13))
            .foregroundStyle(.gray)
            
            Rectangle()
                .frame(height: 0.5)
                .foregroundStyle(.gray)
                .opacity(0.4)
        }
    }
}
