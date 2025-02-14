import SwiftUI

struct CSButton: View {
  let title: String
  let bgColor: Color
  let action: () -> Void
  
  var body: some View {
    Button(action: action) {
      Text(title)
        .font(.callout)
        .fontWeight(.medium)
        .foregroundStyle(.white)
    }
    .buttonModifier(pouring: bgColor)
  }
}

#Preview {
  CSButton(
    title: "Route",
    bgColor: .accent,
    action: {}
  )
}
