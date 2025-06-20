import SwiftUI
import MapKit

struct MapScreen: View {
  
  @Binding var isShownTabBar: Bool
  @State private var cameraPosition: MapCameraPosition = .region(.userRegion)
  @EnvironmentObject var stationViewModel: StationViewModel
  @EnvironmentObject var mapViewModel: MapViewModel
  
  var body: some View {
    Map(position: $cameraPosition) {
      UserAnnotation()
      ForEach(stationViewModel.stations) { station in
        let coordinate = station.coordinate
        Annotation("EcoFill", coordinate: coordinate) {
          mark(for: station)
        }
      }
      if let route = mapViewModel.route {
        MapPolyline(route.polyline)
          .stroke(.purple, lineWidth: 4)
      }
    }
    .overlay(alignment: .topTrailing) {
      listButton
    }
    .mapControls {
      MapPitchToggle()
      MapUserLocationButton()
    }
    .sheet(isPresented: $mapViewModel.isShownStationPreview) {
      MapItemView(station: mapViewModel.selectedStation ?? MockData.station)
        .presentationDetents([.height(320)])
        .presentationDragIndicator(.visible)
        .presentationCornerRadius(25)
    }
    .sheet(isPresented: $mapViewModel.isShownStationList) {
      StationListView()
        .presentationDetents([.medium, .large])
        .presentationDragIndicator(.visible)
        .presentationCornerRadius(25)
    }
    .task(id: mapViewModel.isShownRoute) {
      await mapViewModel.toggleRoutePresentation()
    }
    .onAppear {
      isShownTabBar = true
    }
  }
  
  // MARK: - Subviews
  
  private func mark(for station: Station) -> some View {
    Button {
      mapViewModel.selectedStation = station
      mapViewModel.isShownStationPreview = true
    } label: {
      Image(systemName: "fuelpump.fill")
        .font(.footnote)
        .foregroundStyle(.black)
        .padding(8)
        .background(.accent)
        .clipShape(.circle)
    }
  }
  
  private var listButton: some View {
    Button {
      mapViewModel.isShownStationList.toggle()
    } label: {
      Image(systemName: "list.bullet")
        .imageScale(.large)
        .foregroundStyle(.white)
        .padding(.vertical,12)
        .padding(.horizontal,9)
        .background(.black)
        .clipShape(.buttonBorder)
    }
    .padding(.trailing,5)
    .padding(.top,60)
  }
}

#Preview {
  MapScreen(isShownTabBar: .constant(false))
    .environmentObject(MapViewModel.previewMode)
    .environmentObject(StationViewModel.previewMode)
    .environmentObject(AuthViewModel.previewMode)
}
