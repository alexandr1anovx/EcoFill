import SwiftUI

struct CSRow: View {
  let data: String
  let image: String
  let imageColor: Color
  
  var body: some View {
    HStack(spacing: 5) {
      Image(systemName: image)
        .imageScale(.medium)
        .foregroundStyle(imageColor)
      Text(data)
        .font(.system(size: 15))
        .foregroundStyle(.gray)
    }
  }
}

#Preview {
  CSRow(
    data: "Full Name",
    image: "mappin",
    imageColor: .accent
  )
}
