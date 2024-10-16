import SwiftUI

struct HomeScreen: View {
    @State private var isShownQR: Bool = false
    let services = Service.services
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.primaryBackground.ignoresSafeArea()
                
                VStack {
                    UserDataView()
                    CityFuelsView()
                        .padding(15)
                    List(services) { service in
                        NavigationLink {
                            switch service.type {
                            case .support: SupportScreen()
                            }
                        } label: {
                            Cell(title: service.type.rawValue,
                                 description: service.description,
                                 image: service.image,
                                 imageColor: .accent)
                        }
                        .listRowBackground(Color.primaryBackground)
                    }
                    .listStyle(.plain)
                }
                .navigationTitle("Home")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Image(.logo)
                            .resizable()
                            .frame(width: 54, height: 54)
                    }
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            isShownQR.toggle()
                        } label: {
                            Image("qrcode")
                                .navigationBarImageSize
                                .foregroundStyle(.accent)
                        }
                        .buttonStyle(.animated)
                    }
                }
                .sheet(isPresented: $isShownQR) {
                    QRCodeView()
                        .presentationDetents([.height(250)])
                        .presentationDragIndicator(.visible)
                        .presentationCornerRadius(20)
                }
            }
        }
    }
}
