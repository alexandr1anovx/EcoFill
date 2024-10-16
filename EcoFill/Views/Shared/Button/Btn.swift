import SwiftUI

struct Btn: View {
    let title: String
    let image: String
    let color: Color
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                Image(image)
                    .defaultImageSize
                    .foregroundStyle(.primaryWhite)
                    .opacity(0.7)
                Text(title)
                    .font(.poppins(.medium, size: 15))
                    .foregroundStyle(.white)
            }
        }
        .buttonStyle(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=Button Style@*/DefaultButtonStyle()/*@END_MENU_TOKEN@*/)
        .buttonModifier(pouring: color)
        .shadow(radius: 5)
    }
}
