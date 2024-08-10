import SwiftUI

struct SignInButton: View {
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            HStack {
                Image(.userSignIn)
                    .defaultImageSize
                Text("Sign In")
                    .font(.lexendFootnote)
                    .foregroundStyle(.white)
            }
        }
        .customButtonStyle(pouring: .accent)
        .shadow(radius: 5)
    }
}
