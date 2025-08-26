import SwiftUI
import MapKit

struct MapScreen: View {
  @Environment(StationViewModel.self) var stationViewModel
  @Bindable var mapViewModel: MapViewModel
  //@Binding var showTabBar: Bool
  @State private var cameraPosition: MapCameraPosition = .region(.userRegion)
  
  var body: some View {
    Map(position: $cameraPosition) {
      UserAnnotation()
      ForEach(stationViewModel.stations) { station in
        let coordinate = station.coordinate
        Annotation("EcoFill", coordinate: coordinate) {
          Button {
            mapViewModel.selectedStation = station
            mapViewModel.showStationPreview = true
          } label: {
            Image(systemName: "fuelpump.fill")
              .font(.subheadline)
              .foregroundStyle(.black)
              .padding(8)
              .background(.green.gradient)
              .clipShape(.circle)
              .shadow(radius: 1)
          }
        }
      }
      if let route = mapViewModel.route {
        MapPolyline(route.polyline)
          .stroke(.purple, lineWidth: 4)
      }
    }
    // List button
    .overlay(alignment: .topTrailing) {
      Button {
        mapViewModel.showStationList.toggle()
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
    .mapControls {
      MapUserLocationButton()
    }
    .sheet(isPresented: $mapViewModel.showStationPreview) {
      MapItemView(station: mapViewModel.selectedStation ?? MockData.station, withPadding: true)
        .presentationDetents([.fraction(0.46)])
        .presentationDragIndicator(.visible)
        .presentationCornerRadius(35)
    }
    .sheet(isPresented: $mapViewModel.showStationList) {
      StationListView(viewModel: stationViewModel)
        .presentationDetents([.large])
        .presentationDragIndicator(.visible)
        .presentationCornerRadius(25)
    }
    .task(id: mapViewModel.showRoute) {
      await mapViewModel.toggleRoutePresentation()
    }
    //.onAppear { isShownTabBar = true }
  }
}

#Preview {
  MapScreen(mapViewModel: MapViewModel())
    .environment(MapViewModel.mockObject)
    .environment(StationViewModel.previewMode)
}
