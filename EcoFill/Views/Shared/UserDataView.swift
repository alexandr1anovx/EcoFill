import SwiftUI

struct UserDataView: View {
    @EnvironmentObject var userVM: UserViewModel
    
    var body: some View {
        if let user = userVM.currentUser {
            HStack {
                VStack(alignment: .leading, spacing: 12) {
                    Text(user.initials)
                        .font(.poppins(.medium, size: 17))
                        .foregroundStyle(.primaryReversed)
                    RowView(data: user.email,
                              image: "mail",
                              imageColor: .accent)
                }
                Spacer()
                RowView(data: user.city, 
                          image: "mark",
                          imageColor: .accent)
            }
            .padding(20)
        } else {
            ProgressView()
        }
    }
}
