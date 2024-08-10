import SwiftUI

struct SignUpButton: View {
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            HStack {
                Image(.userSignUp)
                    .defaultImageSize
                Text("Sign Up")
                    .font(.lexendFootnote)
                    .foregroundStyle(.white)
            }
        }
        .customButtonStyle(pouring: .orange)
        .shadow(radius: 5)
    }
}
