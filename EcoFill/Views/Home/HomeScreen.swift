import SwiftUI

struct HomeScreen: View {
    @State private var isShownQRCode = false
    
    var body: some View {
        NavigationStack {
            VStack {
                UserDataView()
                FuelsInSelectedCity()
                    .padding(15)
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
                .presentationDetents([.height(250)])
                .presentationBackgroundInteraction(.disabled)
                .presentationCornerRadius(20)
        }
    }
}
