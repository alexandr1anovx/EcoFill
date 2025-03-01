import SwiftUI

struct CSButton: View {
  
  let title: String
  let color: Color
  let action: () -> Void
  
  init(_ title: String, color: Color, action: @escaping () -> Void) {
    self.title = title
    self.color = color
    self.action = action
  }
  
  var body: some View {
    Button(action: action) {
      Text(title)
        .font(.callout).bold()
        .fontDesign(.monospaced)
        .foregroundStyle(.white)
        .frame(maxWidth: .infinity)
        .padding(.vertical, 8)
    }
    .buttonStyle(.borderedProminent)
    .tint(color)
    .padding(.horizontal, 20)
    .shadow(radius: 3)
  }
}

#Preview {
  CSButton("Route", color: .accent, action: {})
}
