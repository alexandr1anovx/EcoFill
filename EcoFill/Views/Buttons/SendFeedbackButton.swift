import SwiftUI

struct SendFeedbackButton: View {
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            HStack {
                Image(.success)
                    .defaultImageSize
                Text("Send feedback")
                    .font(.lexendFootnote)
                    .foregroundStyle(.white)
            }
        }
        .customButtonStyle(pouring: .cmBlue)
        .shadow(radius: 5)
    }
}
