import SwiftUI

struct CustomButtonModifier: ButtonStyle {
    let pouring: Color
    
    func makeBody(configuration: Configuration) -> some View {
        let baseButton = configuration.label
            .padding(10)
            .font(.poppins(.medium, size: 15))
            .foregroundColor(.white)
            .background(pouring)
            .cornerRadius(10)
            
        return baseButton
            .opacity(configuration.isPressed ? 0.5 : 1.0)
            .scaleEffect(configuration.isPressed ? 0.8 : 1.0)
            .animation(.easeInOut(duration: 0.2), value: configuration.isPressed)
    }
}
