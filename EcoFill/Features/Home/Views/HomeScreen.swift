import SwiftUI

struct HomeScreen: View {
  @Binding var showTabBar: Bool
  @Environment(SessionManager.self) var sessionManager
  var body: some View {
    NavigationStack {
      VStack {
        if let user = sessionManager.currentUser {
          UserDataHeader(
            name: user.fullName,
            email: user.email,
            city: user.localizedCity
          )
          CityFuelsGrid()
            .padding(15)
          ServiceList(showTabBar: $showTabBar)
        } else {
          ProgressView()
            .tint(.primary)
        }
      }
      .navigationTitle(Tab.home.title)
      .onAppear { showTabBar = true }
    }
  }
}
private extension HomeScreen {
  struct UserDataHeader: View {
    let name: String
    let email: String
    let city: LocalizedStringKey
    var body: some View {
      HStack {
        VStack(alignment: .leading, spacing: 12) {
          Text(name)
            .font(.callout)
            .fontWeight(.semibold)
          Text(email)
            .font(.footnote)
            .foregroundStyle(.secondary)
        }
        Spacer()
        Label(city, systemImage: "location.north.fill")
      }
      .padding(20)
    }
  }
  struct ServiceList: View {
    @Environment(SessionManager.self) var sessionManager
    @Binding var showTabBar: Bool
    var body: some View {
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
        case .qrcode:
          QRCodeScreen(viewModel: QRCodeViewModel(sessionManager: sessionManager))
          .onAppear { showTabBar = false }
        case .support:
          SupportScreen()
            .onAppear { showTabBar = false }
        }
      }
    }
  }
}
#Preview {
  HomeScreen(showTabBar: .constant(true))
    .environment(StationViewModel.mockObject)
    .environment(MapViewModel.mockObject)
    .environment(SessionManager.mockObject)
}
