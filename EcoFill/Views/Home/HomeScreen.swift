import SwiftUI

struct HomeScreen: View {
    @State private var isPresentedQR = false
    
    var body: some View {
        NavigationStack {
            VStack {
                UserDataView()
                CityFuels().padding(15)
                
                // MARK: - List of Services
                List(Service.services) { service in
                    ServiceCell(service: service)
                }
                .listStyle(.plain)
                .listRowSpacing(10)
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Image(.logo)
                        .resizable()
                        .frame(width: 54, height: 54)
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        isPresentedQR.toggle()
                    } label: {
                        Image(systemName: "qrcode")
                            .font(.title3)
                            .foregroundStyle(.accent)
                    }
                    .buttonStyle(.animated)
                }
            }
            .navigationTitle("Home")
            .navigationBarTitleDisplayMode(.inline)
        }
        .sheet(isPresented: $isPresentedQR) {
            QRCodeView()
                .presentationDetents([.height(250)])
                .presentationDragIndicator(.visible)
                .presentationCornerRadius(20)
        }
    }
}
