import SwiftUI

struct ResetButton: View {
    let img: ImageResource
    let data: String
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            HStack {
                Image(img)
                    .defaultImageSize
                Text("Reset \(data)")
                    .font(.lexendFootnote)
                    .foregroundStyle(.white)
            }
        }
        .customButtonStyle(pouring: .cmBlue)
        .shadow(radius: 5)
    }
}
