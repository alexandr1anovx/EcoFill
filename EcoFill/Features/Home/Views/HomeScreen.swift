import SwiftUI

struct HomeScreen: View {
  @Binding var isShownTabBar: Bool
  
  var body: some View {
    NavigationStack {
      ZStack {
        Color.appBackground.ignoresSafeArea()
        VStack(spacing:0) {
          UserDataHeader()
          CityFuelsGrid().padding(15)
          serviceList
        }
      }
      .navigationTitle("Home")
      .onAppear { isShownTabBar = true }
    }
  }
  
  // MARK: - Auxilary UI Components
  
  private var serviceList: some View {
    List(ServiceType.allCases) { service in
      NavigationLink(destination: destinationView(for: service)) {
        ListCell(
          title: service.title,
          subtitle: service.subtitle,
          icon: service.icon,
          iconColor: .primaryIcon
        )
      }
    }.customListSetup(shadow: 1.0)
  }
  
  @ViewBuilder
  private func destinationView(for service: ServiceType) -> some View {
    switch service {
    case .support:
      SupportScreen()
        .onAppear { isShownTabBar = false }
    case .qrcode:
      QRCodeScreen()
        .onAppear { isShownTabBar = false }
    }
  }
}

#Preview {
  HomeScreen(isShownTabBar: .constant(true))
    .environmentObject(AuthViewModel.previewMode)
    .environmentObject(MapViewModel.previewMode)
}
