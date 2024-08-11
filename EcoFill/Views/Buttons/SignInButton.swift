import SwiftUI

struct SignInButton: View {
    let action: () -> Void
    
    var body: some View {
        Button {
            let feedbackGenerator = UIImpactFeedbackGenerator(style: .heavy)
            feedbackGenerator.prepare()
            feedbackGenerator.impactOccurred()
            action()
        } label: {
            HStack {
                Image(.success)
                    .defaultImageSize
                Text("Sign In")
                    .font(.lexendCallout)
                    .foregroundStyle(.white)
            }
        }
        .customButtonStyle(pouring: .cmBlue)
        .shadow(radius: 5)
    }
}
