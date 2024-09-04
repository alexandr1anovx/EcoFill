import SwiftUI

struct UserDataView: View {
    @EnvironmentObject var userViewModel: UserViewModel
    
    var body: some View {
        if let user = userViewModel.currentUser {
            HStack {
                VStack(alignment: .leading, spacing: 10) {
                    Text(user.initials)
                        .font(.system(size: 18))
                        .fontWeight(.medium)
                        .fontDesign(.rounded)
                        .foregroundStyle(.cmReversed)
                    Row(user.email, image: .mail)
                        .lineLimit(2)
                }
                Spacer()
                Row(user.city, image: .mark)
            }
            .padding(20)
        } else {
            ProgressView()
        }
    }
}
