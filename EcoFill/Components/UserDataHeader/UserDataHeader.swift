import SwiftUI

struct UserDataHeader: View {
  @EnvironmentObject var userVM: UserViewModel
  
  var body: some View {
    if let user = userVM.currentUser {
      HStack {
        VStack(alignment: .leading, spacing: 15) {
          Text(user.fullName)
            .font(.callout)
            .fontWeight(.semibold)
            .foregroundStyle(.primaryLabel)
          Text(user.email)
            .font(.system(size: 14))
            .fontWeight(.medium)
            .foregroundStyle(.gray)
        }
        Spacer()
        HStack(spacing: 8) {
          Image(.marker)
            .foregroundStyle(.primaryIcon)
          Text(user.city)
            .font(.footnote)
            .fontWeight(.medium)
            .foregroundStyle(.gray)
        }
      }.padding(20)
    } else {
      ProgressView()
    }
  }
}

#Preview {
  UserDataHeader()
    .environmentObject(UserViewModel())
    .environmentObject(StationViewModel())
}
