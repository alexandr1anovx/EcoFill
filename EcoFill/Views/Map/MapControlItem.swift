import SwiftUI

struct MapControlItem: View {
    
    // MARK: - Public Properties
    let img: ImageResource
    let action: () -> Void?
    
    // MARK: - body
    var body: some View {
        Button {
            action()
        } label: {
            Image(img)
                .defaultImageSize
        }
        .customButtonStyle(pouring: .cmSystem)
        .shadow(radius: 5)
    }
}
