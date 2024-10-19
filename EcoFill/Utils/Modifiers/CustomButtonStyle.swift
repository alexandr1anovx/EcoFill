import SwiftUI

struct CustomButtonStyle: ButtonStyle {
    let pouring: Color
    
    init(with pouring: Color) {
        self.pouring = pouring
    }
    
    func makeBody(configuration: Configuration) -> some View {
        let baseButton = configuration.label
            .padding(11)
            .font(.poppins(.medium, size: 14))
            .foregroundColor(.white)
            .background(pouring)
            .cornerRadius(8)
            
        return baseButton
            .opacity(configuration.isPressed ? 0.5 : 1.0)
            .scaleEffect(configuration.isPressed ? 0.8 : 1.0)
            .animation(.bouncy, value: configuration.isPressed)
    }
}
