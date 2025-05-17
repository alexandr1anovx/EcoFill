import SwiftUI
import MapKit

struct MapScreen: View {
  
  @Binding var isShownTabBar: Bool
  @State private var cameraPosition: MapCameraPosition = .region(.userRegion)
  @EnvironmentObject var stationViewModel: StationViewModel
  @EnvironmentObject var mapViewModel: MapViewModel
  
  var body: some View {
    mapView
      .mapControls {
        MapPitchToggle()
        MapUserLocationButton()
      }
      .overlay(alignment: .topTrailing) {
        showListButton
      }
      .task(id: mapViewModel.isShownRoute) {
        await mapViewModel.toggleRoutePresentation()
      }
      .onAppear { isShownTabBar = true }
    
      .sheet(isPresented: $mapViewModel.isShownStationPreview) {
        MapItemView(station: mapViewModel.selectedStation ?? MockData.station)
          .presentationDetents([.height(320)])
          .presentationDragIndicator(.visible)
          .presentationCornerRadius(30)
      }
      .sheet(isPresented: $mapViewModel.isShownStationList) {
        StationListView()
          .presentationDetents([.height(450)])
          .presentationDragIndicator(.visible)
          .presentationCornerRadius(30)
      }
  }
  
  private var mapView: some View {
    Map(position: $cameraPosition) {
      UserAnnotation()
      ForEach(stationViewModel.stations) { station in
        
        let coordinate = station.coordinate
        Annotation("EcoFill", coordinate: coordinate) {
          stationMark(for: station)
        }
      }
      if let route = mapViewModel.route {
        MapPolyline(route.polyline)
          .stroke(.green, lineWidth: 4)
      }
    }
  }
  
  private func stationMark(for station: Station) -> some View {
    Image(systemName: "fuelpump.fill")
      .font(.footnote)
      .foregroundStyle(.black)
      .padding(8)
      .background(.primaryLime.opacity(0.9))
      .clipShape(.circle)
      .onTapGesture {
        mapViewModel.selectedStation = station
        mapViewModel.isShownStationPreview = true
      }
  }
  
  private var showListButton: some View {
    Button {
      mapViewModel.isShownStationList.toggle()
    } label: {
      Image(systemName: "list.bullet")
        .imageScale(.large)
        .foregroundStyle(.primaryLime)
        .padding(.vertical,12)
        .padding(.horizontal,9)
        .background(.primaryBlack)
        .clipShape(.rect(cornerRadius: 8))
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
