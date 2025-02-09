import SwiftUI

struct CSTextField: View {
  
  let header: String
  let placeholder: String
  let data: Binding<String>
  var isSecure: Bool = false
  
  var body: some View {
    VStack(alignment: .leading, spacing: 8) {
      Text(header)
        .font(.poppins(.medium, size: 14))
        .foregroundStyle(.primaryReversed)
      Group {
        if isSecure {
          SecureField(placeholder, text: data)
        } else {
          TextField(placeholder, text: data)
        }
      }
      .font(.poppins(.regular, size: 13))
      .foregroundStyle(.gray)
      
      Divider()
    }
  }
}
