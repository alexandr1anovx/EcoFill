import SwiftUI

struct CustomRow: View {
    let title: String
    let image: String
    
    init(_ title: String = "", image: String) {
        self.title = title
        self.image = image
    }
    
    var body: some View {
        HStack(spacing: 8) {
            Image(systemName: image)
                .font(.callout)
                .foregroundStyle(.accent)
            Text(title)
                .font(.poppins(.regular, size: 13))
                .foregroundStyle(.gray)
        }
    }
}
