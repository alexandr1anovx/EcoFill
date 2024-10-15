import SwiftUI

struct CustomBtn: View {
    let title: String
    let image: String
    let color: Color
    let action: () -> Void
    
    init(_ title: String, image: String, color: Color, action: @escaping () -> Void) {
        self.title = title
        self.image = image
        self.color = color
        self.action = action
    }
    
    var body: some View {
        Button(action: action) {
            HStack {
                Image(systemName: image)
                    .font(.callout)
                Text(title)
                    .font(.poppins(.medium, size: 14))
                    .foregroundStyle(.white)
            }
        }
        .customButtonStyle(pouring: color)
        .shadow(radius: 5)
    }
}
