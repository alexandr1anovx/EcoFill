import SwiftUI

struct HomeScreen: View {
  @Binding var isShownTabBar: Bool
  
  var body: some View {
    NavigationStack {
      ZStack {
        Color.appBackground.ignoresSafeArea(.all)
        VStack(spacing: 0) {
          UserDataHeader()
          CityFuelsGrid().padding(15)
          serviceList
        }
      }
      .navigationTitle("Home")
      .onAppear { isShownTabBar = true }
    }
  }
  
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
    }
    .listStyle(.insetGrouped)
    .listRowSpacing(10)
    .scrollContentBackground(.hidden)
    .scrollIndicators(.hidden)
    .shadow(radius: 1)
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
    .environmentObject( AuthViewModel() )
    .environmentObject( MapViewModel() )
}

