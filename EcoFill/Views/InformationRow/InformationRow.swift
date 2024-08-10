import SwiftUI

struct InformationRow: View {
    
    // MARK: - Public Properties
    let img: ImageResource
    let text: String
    let content: String?
    
    // MARK: - body
    var body: some View {
        HStack(spacing: 10) {
            Image(img)
                .defaultImageSize
            Text(text)
                .font(.lexendFootnote)
                .foregroundStyle(.gray)
            Text(content ?? "")
                .font(.lexendFootnote)
                .foregroundStyle(.cmReversed)
        }
    }
}
