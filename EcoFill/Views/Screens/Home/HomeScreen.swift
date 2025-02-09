import SwiftUI

struct HomeScreen: View {
  
  @State private var isShownQRCode = false
  @Binding var isShownTabBar: Bool
  private let services = Service.services
  
  var body: some View {
    NavigationStack {
      ZStack {
        Color.primaryBackground.ignoresSafeArea(.all)
        
        VStack {
          UserDataView()
          CityFuelsGrid().padding(15)
          serviceList
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
            qrcodeButton
          }
        }
      }
      .onAppear { isShownTabBar = true }
    }
  }
  
  // MARK: - QR Code Button
  private var qrcodeButton: some View {
    Button {
      isShownQRCode.toggle()
    } label: {
      Image("qrcode")
        .navigationBarImageSize
        .foregroundStyle(.accent)
    }
    .buttonStyle(.animated)
    .sheet(isPresented: $isShownQRCode) {
      QRCodeView()
        .presentationDetents([.height(250)])
        .presentationDragIndicator(.visible)
        .presentationCornerRadius(20)
    }
  }
  
  // MARK: - Service List Component
  @ViewBuilder
  private var serviceList: some View {
    List(services) { service in
      NavigationLink {
        switch service.type {
        case .support:
          SupportScreen()
            .onAppear { isShownTabBar = false }
        }
      } label: {
        PlainListCell(
          title: service.type.rawValue.capitalized,
          description: service.description,
          image: service.image,
          imageColor: .accent
        )
      }
      .listRowBackground(Color.primaryBackground)
    }
    .listStyle(.plain)
  }
}
