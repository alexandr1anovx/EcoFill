import SwiftUI

struct SendFeedbackButton: View {
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            HStack {
                Image(.checkmark)
                    .defaultImageSize
                Text("Send feedback")
                    .font(.lexendFootnote)
                    .foregroundStyle(.white)
            }
        }
        .customButtonStyle(pouring: .cmBlack)
        .shadow(radius: 5)
    }
}
