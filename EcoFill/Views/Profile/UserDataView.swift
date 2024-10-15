import SwiftUI

struct UserDataView: View {
    @EnvironmentObject var userVM: UserViewModel
    
    var body: some View {
        if let user = userVM.currentUser {
            HStack {
                VStack(alignment: .leading, spacing: 10) {
                    Text(user.initials)
                        .font(.poppins(.medium, size: 17))
                        .foregroundStyle(.cmReversed)
                    CustomRow(user.email, image: "envelope")
                        .lineLimit(2)
                }
                Spacer()
                CustomRow(user.city, image: "location")
            }
            .padding(20)
        } else {
            ProgressView()
        }
    }
}
