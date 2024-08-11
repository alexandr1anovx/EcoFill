import SwiftUI

struct HomeScreen: View {
    
    // MARK: - Public Properties
    @EnvironmentObject var authenticationViewModel: AuthenticationViewModel
    
    // MARK: - Private Properties
    @State private var isPresentedQR = false
    
    // MARK: - body
    var body: some View {
        NavigationStack {
            if let city = authenticationViewModel.currentUser?.city {
                VStack {
                    UserDataView()
                    FuelsList(selectedCity: city)
                        .padding(.vertical, 15)
                        .padding(.leading, 15)
                        .padding(.trailing, 8)
                    ServicesList()
                }
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Image(.logo)
                            .logoImageSize
                    }
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            isPresentedQR.toggle()
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
        }
        .sheet(isPresented: $isPresentedQR) {
            QRCodeView()
                .presentationDetents([.fraction(0.4)])
                .presentationBackgroundInteraction(.disabled)
                .presentationCornerRadius(20)
        }
    }
}
