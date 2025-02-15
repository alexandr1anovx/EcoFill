import SwiftUI

struct CSButton: View {
  
  let title: String
  let color: Color
  let action: () -> Void
  
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
  CSButton(
    title: "Route",
    color: .accent,
    action: {}
  )
}
