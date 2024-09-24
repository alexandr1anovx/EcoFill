import SwiftUI

struct UserScreen: View {
    @EnvironmentObject var userVM: UserViewModel
    @State private var isPresentedSignOut = false
    
    var body: some View {
        NavigationStack {
            UserDataView()
            List {
                AppearanceChangerView()
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
                        userVM.signOut()
                        
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
                        UserSettingsView()
                    } label: {
                        Text("Edit")
                            .foregroundStyle(.cmReversed)
                    }
                }
            }
            .navigationTitle("Profile")
            .navigationBarTitleDisplayMode(.inline)
        }
        .alert(item: $userVM.alertItem) { alert in
            Alert(
                title: alert.title,
                message: alert.message,
                dismissButton: alert.dismissButton)
        }
    }
}
