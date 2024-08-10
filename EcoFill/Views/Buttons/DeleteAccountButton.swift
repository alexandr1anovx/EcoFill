import SwiftUI

struct DeleteAccountButton: View {
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            HStack {
                Image(.userDelete)
                    .defaultImageSize
                Text("Delete account")
                    .font(.lexendFootnote)
                    .foregroundStyle(.white)
            }
        }
        .customButtonStyle(pouring: .cmBlack)
        .shadow(radius: 5)
    }
}
