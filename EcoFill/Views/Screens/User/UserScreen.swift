import SwiftUI

struct UserScreen: View {
    @EnvironmentObject var userViewModel: UserViewModel
    @State private var isPresentedSignOut = false
    
    var body: some View {
        NavigationStack {
            UserDataView()
            List {
                AppearanceChanger()
                Button {
                    isPresentedSignOut.toggle()
                } label: {
                    HStack(spacing: 15) {
                        Image(.userXmark)
                            .resizable()
                            .frame(width: 25, height: 25)
                        Text("Sign Out")
                            .font(.system(size: 16))
                            .fontWeight(.medium)
                            .fontDesign(.rounded)
                            .foregroundStyle(.red)
                    }
                }
                .confirmationDialog("", isPresented: $isPresentedSignOut) {
                    Button("Sign Out", role: .destructive) {
                        userViewModel.signOut()
                    }
                }
            }
            .listStyle(.insetGrouped)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Image(.logo)
                        .resizable()
                        .frame(width: 54, height: 54)
                }
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink {
                        UserPrivateDataView()
                    } label: {
                        Text("Edit")
                            .foregroundStyle(.cmReversed)
                    }
                }
            }
            .navigationTitle("Profile")
            .navigationBarTitleDisplayMode(.inline)
        }
        .alert(item: $userViewModel.alertItem) { alert in
            Alert(
                title: alert.title,
                message: alert.message,
                dismissButton: alert.dismissButton)
        }
    }
}
