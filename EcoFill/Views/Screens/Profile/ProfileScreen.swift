import SwiftUI

struct ProfileScreen: View {
    
    @Binding var isShownTabBar: Bool
    @State private var isShownAlert: Bool = false
    @EnvironmentObject var userVM: UserViewModel
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.primaryBackground.ignoresSafeArea()
                
                VStack {
                    UserDataView()
                    List {
                        AppSchemeCell()
                            .listRowBackground(Color.primaryBackground)
                        Cell(title: "Sign Out",
                             description: "Sign out from current account.",
                             image: "logout",
                             imageColor: .primaryRed)
                        .onTapGesture {
                            isShownAlert.toggle()
                        }
                        .listRowBackground(Color.primaryBackground)
                    }
                    .listStyle(.plain)
                }
                .navigationTitle("Profile")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Image(.logo)
                            .resizable()
                            .frame(width: 54, height: 54)
                    }
                    ToolbarItem(placement: .topBarTrailing) {
                        NavigationLink {
                            SettingScreen()
                                .onAppear { isShownTabBar = false }
                        } label: {
                            Image("gear")
                                .navigationBarImageSize
                                .foregroundStyle(.accent)
                        }
                    }
                }
                .alert("Sign Out", isPresented: $isShownAlert) {
                    
                    Button("Sign Out", role: .destructive) {
                        withAnimation(.bouncy(duration: 1)) {
                            userVM.signOut()
                        }
                    }
                } message: {
                    Text("This action will redirect you to the Sign In screen.")
                }
                .onAppear { isShownTabBar = true }
            }
        }
    }
}
