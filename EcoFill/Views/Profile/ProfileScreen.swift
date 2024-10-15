import SwiftUI

struct ProfileScreen: View {
    
    @EnvironmentObject var userVM: UserViewModel
    @State private var isPresentedSignOutAlert = false
    
    var body: some View {
        NavigationStack {
            UserDataView()
            List {
                AppearanceChanger()
                Button {
                    isPresentedSignOutAlert.toggle()
                } label: {
                    HStack(spacing: 15) {
                        Image(systemName: "xmark.circle.fill")
                            .font(.title3)
                            .foregroundStyle(.red)
                        Text("Sign Out")
                            .font(.poppins(.medium, size: 16))
                            .foregroundStyle(.red)
                    }
                }
                .confirmationDialog("", isPresented: $isPresentedSignOutAlert) {
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
                        SettingScreen()
                    } label: {
                        Text("Edit")
                            .foregroundStyle(.cmReversed)
                    }
                }
            }
            .navigationTitle("Profile")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
