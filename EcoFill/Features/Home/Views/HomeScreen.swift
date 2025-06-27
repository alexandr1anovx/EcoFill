import SwiftUI

struct HomeScreen: View {
  @Binding var isShownTabBar: Bool
  @EnvironmentObject var sessionManager: SessionManager
  
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
      .navigationTitle(Tab.home.title)
      .onAppear { isShownTabBar = true }
    }
  }
  
  // MARK: - Subviews
  
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
      case .qrcode:
        QRCodeScreen(
          viewModel: QRCodeViewModel(sessionManager: sessionManager)
        )
        .onAppear { isShownTabBar = false }
      case .support:
        SupportScreen(
          viewModel: SupportViewModel(sessionManager: sessionManager)
        )
        .onAppear { isShownTabBar = false }
      }
    }
    .customListStyle(shadow: 1.0)
  }
}

extension HomeScreen {
  struct UserDataHeader: View {
    @EnvironmentObject var sessionManager: SessionManager
    
    var body: some View {
      if let user = sessionManager.currentUser {
        HStack {
          VStack(alignment: .leading, spacing: 12) {
            Text(user.fullName)
              .font(.callout)
              .fontWeight(.semibold)
            Text(user.email)
              .font(.footnote)
              .foregroundStyle(.gray)
          }
          Spacer()
          Label(user.localizedCity, image: .marker)
            .foregroundStyle(.accent)
        }
        .padding(20)
      } else {
        ProgressView("Loading...")
      }
    }
  }
}

#Preview {
  HomeScreen(isShownTabBar: .constant(true))
    .environmentObject(MapViewModel.previewMode)
    .environmentObject(StationViewModel.previewMode)
}
