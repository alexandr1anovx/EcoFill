import SwiftUI

struct HomeScreen: View {
    @EnvironmentObject var userViewModel: UserViewModel
    @State private var isShownQRCode = false
    
    var body: some View {
        NavigationStack {
            if let user = userViewModel.currentUser {
                
            }
            VStack {
                UserDataView()
                FuelsList()
                    .padding(.vertical, 15)
                    .padding(.leading, 15)
                    .padding(.trailing, 8)
                ServicesList()
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Image(.logo)
                        .resizable()
                        .frame(width: 54, height: 54)
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        isShownQRCode.toggle()
                    } label: {
                        Image(.qr)
                            .navigationBarImageSize
                    }
                    .buttonStyle(AnimatedButtonStyle.animated)
                }
            }
            .navigationTitle("Home")
            .navigationBarTitleDisplayMode(.inline)
        }
        .sheet(isPresented: $isShownQRCode) {
            QRCodeView()
                .presentationDetents([.height(300)])
                .presentationBackgroundInteraction(.disabled)
                .presentationCornerRadius(20)
        }
    }
}
