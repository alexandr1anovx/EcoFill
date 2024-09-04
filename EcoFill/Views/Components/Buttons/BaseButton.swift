import SwiftUI

struct BaseButton: View {
    let title: String
    let image: ImageResource
    let pouring: Color
    let action: () -> Void
    
    init(_ title: String, _ image: ImageResource, _ pouring: Color, action: @escaping () -> Void) {
        self.title = title
        self.image = image
        self.pouring = pouring
        self.action = action
    }
    
    var body: some View {
        Button(action: action) {
            HStack {
                Image(image)
                    .defaultImageSize
                Text(title)
                    .font(.system(size: 15))
                    .fontWeight(.medium)
                    .fontDesign(.rounded)
                    .foregroundStyle(.white)
            }
        }
        .customButtonStyle(pouring: pouring)
        .shadow(radius: 5)
    }
}
