import SwiftUI

struct BaseButton: View {
    let image: ImageResource
    let title: String
    let pouring: Color
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            HStack {
                Image(image)
                    .defaultImageSize
                Text(title)
                    .font(.lexendFootnote)
                    .foregroundStyle(.white)
            }
        }
        .customButtonStyle(pouring: pouring)
        .shadow(radius: 5)
    }
}

