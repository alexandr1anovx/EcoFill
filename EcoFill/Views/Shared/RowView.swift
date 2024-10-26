import SwiftUI

struct RowView: View {
    let data: String
    let image: String
    let imageColor: Color
    
    var body: some View {
        HStack(spacing: 8) {
            Image(image)
                .defaultImageSize
                .foregroundStyle(imageColor)
            Text(data)
                .font(.poppins(.regular, size: 13))
                .foregroundStyle(.gray)
        }
    }
}

