import SwiftUI

struct ProfileScreen: View {
    
    // MARK: - Public Properties
    @EnvironmentObject var authenticationViewModel: AuthenticationViewModel
    
    // MARK: - Private Properties
    @State private var isPresentedSignOut = false
    
    // MARK: - body
    var body: some View {
        NavigationStack {
            UserDataView()
            List {
                AppearanceChanger()
                Button {
                    isPresentedSignOut.toggle()
                } label: {
                    HStack(spacing: 15) {
                        Image(.userDelete)
                            .resizable()
                            .frame(width: 26, height: 26)
                        Text("Sign Out")
                            .font(.lexendBody)
                            .foregroundStyle(.cmRed)
                    }
                }
                .confirmationDialog("", isPresented: $isPresentedSignOut) {
                    Button("Sign Out", role: .destructive) {
                        authenticationViewModel.signOut()
                    }
                }
            }
            .listStyle(.insetGrouped)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Image(.logo)
                        .logoImageSize
                }
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink {
                        UserPrivateDataView()
                    } label: {
                        Image(.edit)
                            .navigationBarImageSize
                    }
                }
            }
            .navigationTitle("Profile")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
