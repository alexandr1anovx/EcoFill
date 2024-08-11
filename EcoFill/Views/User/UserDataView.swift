import SwiftUI

struct UserDataView: View {
    
    // MARK: - Public Properties
    @EnvironmentObject var authenticationViewModel: AuthenticationViewModel
    
    // MARK: - body
    var body: some View {
        if let user = authenticationViewModel.currentUser {
            HStack {
                VStack(alignment: .leading, spacing: 8) {
                    Text(user.initials)
                        .font(.lexendBody)
                        .foregroundStyle(.cmReversed)
                    Row(img: .mail, text: user.email)
                        .lineLimit(2)
                }
                Spacer()
                Row(img: .mark, text: user.city)
            }
            .padding(20)
        } else {
            Text("Server error.")
                .font(.lexendHeadline)
        }
    }
}
