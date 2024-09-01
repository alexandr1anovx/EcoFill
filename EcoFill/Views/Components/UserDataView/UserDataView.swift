import SwiftUI

struct UserDataView: View {
    @EnvironmentObject var userViewModel: UserViewModel
    
    var body: some View {
        if let user = userViewModel.currentUser {
            HStack {
                VStack(alignment: .leading, spacing: 8) {
                    Text(user.initials)
                        .font(.lexendBody)
                        .foregroundStyle(.cmReversed)
                    DataRow(image: .mail, title: user.email)
                        .lineLimit(2)
                }
                Spacer()
                DataRow(image: .mark, title: user.city)
            }
            .padding(20)
        } else {
            ProgressView("Loading...")
//            ContentUnavailableView(
//                "Cannot load data",
//                image: "xmark.icloud.fill"
//            )
        }
    }
}
