import SwiftUI

struct UserDataHeader: View {
  @EnvironmentObject var userVM: UserViewModel
  
  var body: some View {
    if let user = userVM.currentUser {
      HStack {
        VStack(alignment: .leading, spacing: 15) {
          
          // Username
          HStack(spacing: 10) {
            Image(.user)
              .foregroundStyle(.accent)
            Text(user.initials)
              .font(.callout).bold()
              .fontDesign(.monospaced)
              .foregroundStyle(.primaryReversed)
          }
          
          HStack(spacing: 10) {
            Image(.envelope)
              .foregroundStyle(.accent)
            Text(user.email)
              .font(.system(size: 14))
              .fontWeight(.medium)
              .fontDesign(.monospaced)
              .foregroundStyle(.gray)
          }
        }
        Spacer()
        
        HStack(spacing: 10) {
          Image(.marker)
            .foregroundStyle(.accent)
          Text(user.city)
            .font(.system(size: 14))
            .fontWeight(.medium)
            .fontDesign(.monospaced)
            .foregroundStyle(.gray)
        }
      }
      .padding(20)
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
