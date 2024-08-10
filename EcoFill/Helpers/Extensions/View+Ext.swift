import SwiftUI

extension View {
    func customButtonStyle(pouring: Color) -> some View {
        self.buttonStyle(CustomButtonModifier(pouring: pouring))
    }
}
