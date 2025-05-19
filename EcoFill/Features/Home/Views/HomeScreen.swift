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
          servicesListView
        }
      }
      .navigationTitle("Home")
      .onAppear { isShownTabBar = true }
    }
  }
  
  // MARK: - Auxilary UI Components
  
  private var servicesListView: some View {
    List {
      NavigationLink(value: ServiceType.qrcode) {
        ListCell(for: .qrCode)
      }
      NavigationLink(value: ServiceType.support) {
        ListCell(for: .support)
      }
    }
    .navigationDestination(for: ServiceType.self) { service in
      switch service {
      case .qrcode: QRCodeScreen()
      case .support: SupportScreen()
      }
    }
    .customListStyle(shadow: 1.0)
  }
}

#Preview {
  HomeScreen(isShownTabBar: .constant(true))
    .environmentObject(AuthViewModel.previewMode)
    .environmentObject(MapViewModel.previewMode)
    .environmentObject(StationViewModel.previewMode)
}
