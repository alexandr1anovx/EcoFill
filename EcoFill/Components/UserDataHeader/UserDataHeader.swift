import SwiftUI

struct UserDataHeader: View {
  @EnvironmentObject var authViewModel: AuthViewModel
  
  var body: some View {
    if let user = authViewModel.currentUser {
      HStack {
        VStack(alignment: .leading, spacing: 12) {
          Text(user.fullName)
            .font(.callout)
            .fontWeight(.semibold)
          Text(user.email)
            .font(.footnote)
            .foregroundStyle(.gray)
        }
        Spacer()
        Label(user.localizedCity, image: .marker)
          .foregroundStyle(.accent)
      }
      .padding(20)
    } else {
      HStack {
        Text("Loading...")
        ProgressView()
      }
    }
  }
}

#Preview {
  UserDataHeader()
    .environmentObject(AuthViewModel.previewMode)
}
