import SwiftUI

struct Row: View {
    let title: String?
    let image: ImageResource
    
    init(_ title: String?, image: ImageResource) {
        self.title = title
        self.image = image
    }
    
    var body: some View {
        HStack(spacing: 8) {
            Image(image)
                .defaultImageSize
            Text(title ?? "")
                .font(.system(size: 14))
                .fontWeight(.regular)
                .fontDesign(.rounded)
                .foregroundStyle(.gray)
        }
    }
}
