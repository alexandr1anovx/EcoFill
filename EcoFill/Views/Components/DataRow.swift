import SwiftUI

struct DataRow: View {
    let image: ImageResource
    let title: String?
    
    var body: some View {
        HStack(spacing: 8) {
            Image(image)
                .defaultImageSize
            Text(title ?? "")
                .font(.lexendFootnote)
                .foregroundStyle(.gray)
        }
    }
}
