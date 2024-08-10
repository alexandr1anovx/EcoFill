import SwiftUI

struct DismissRouteButton: View {
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            HStack {
                Image(.xmark)
                    .defaultImageSize
                    .foregroundStyle(.white)
                Text("Dismiss")
                    .font(.lexendFootnote)
                    .foregroundStyle(.white)
            }
        }
        .customButtonStyle(pouring: .red)
        .shadow(radius: 5)
    }
}
