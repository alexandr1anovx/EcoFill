import SwiftUI

struct UserDataView: View {
  @EnvironmentObject var userVM: UserViewModel
  
  var body: some View {
    if let user = userVM.currentUser {
      HStack {
        VStack(alignment: .leading, spacing: 16) {
          
          HStack(spacing: 12) {
            Image(.user)
              .foregroundStyle(.accent)
            Text(user.initials)
              .font(.system(size: 15))
              .fontWeight(.bold)
              .fontDesign(.monospaced)
              .foregroundStyle(.primaryReversed)
          }
//          label(for: user.initials, icon: .user)
//          Text(user.initials)
//            .font(.callout)
//            .fontWeight(.medium)
//            .fontDesign(.monospaced)
//            .foregroundStyle(.primaryReversed)
          label(for: user.email, icon: .envelope)
//          Text("\(user.email)")
//            .font(.callout)
//            .foregroundStyle(.gray)
        }
        Spacer()
        label(for: user.city, icon: .marker)
//        CSRow(
//          data: user.city,
//          image: "mappin",
//          imageColor: .accent
//        )
      }
      .padding(20)
    } else {
      ProgressView()
    }
  }
  
  private func label(for data: String, icon: ImageResource) -> some View {
    HStack(spacing: 12) {
      Image(icon)
        .foregroundStyle(.accent)
      Text(data)
        .font(.system(size: 14))
        .fontWeight(.medium)
        .fontDesign(.monospaced)
        .foregroundStyle(.gray)
    }
  }
}

#Preview {
  UserDataView()
    .environmentObject(UserViewModel())
}
