import SwiftUI
import MapKit

struct MapScreen: View {
  
  @Binding var isShownTabBar: Bool
  @State private var cameraPosition: MapCameraPosition = .region(.userRegion)
  @EnvironmentObject var stationVM: StationViewModel
  
  var body: some View {
    mapView
      .mapControls {
        MapPitchToggle()
        MapUserLocationButton()
      }
      .overlay(alignment: .topTrailing) {
        showListButton
      }
      .task(id: stationVM.isShownRoute) {
        await stationVM.toggleRoutePresentation()
      }
      .onAppear { isShownTabBar = true }
    
      .sheet(isPresented: $stationVM.isShownStationDataSheet) {
        MapItemView(station: stationVM.selectedStation ?? .mockStation)
          .presentationDetents([.height(320)])
          .presentationDragIndicator(.visible)
          .presentationCornerRadius(30)
      }
      .sheet(isPresented: $stationVM.isShownStationList) {
        StationListView()
          .presentationDetents([.height(450)])
          .presentationDragIndicator(.visible)
          .presentationCornerRadius(30)
      }
  }
  
  private var mapView: some View {
    Map(position: $cameraPosition) {
      UserAnnotation()
      ForEach(stationVM.stations) { station in
        
        let coordinate = station.coordinate
        Annotation("EcoFill", coordinate: coordinate) {
          stationMark(for: station)
        }
      }
      if let route = stationVM.route {
        MapPolyline(route.polyline)
          .stroke(.green, lineWidth: 4)
      }
    }
  }
  
  private func stationMark(for station: Station) -> some View {
    Image(systemName: "fuelpump.fill")
      .foregroundStyle(.primaryLime)
      .opacity(0.8)
      .padding(6)
      .background(.primaryBlack)
      .clipShape(.circle)
      .shadow(radius: 3)
      .onTapGesture {
        stationVM.selectedStation = station
        stationVM.isShownStationDataSheet = true
      }
  }
  
  private var showListButton: some View {
    Button {
      stationVM.isShownStationList.toggle()
    } label: {
      Image(systemName: "list.bullet")
        .imageScale(.large)
        .foregroundStyle(.primaryText)
        .padding(.vertical, 12)
        .padding(.horizontal, 8.5)
        .background(.buttonBackground)
        .clipShape(.rect(cornerRadius: 7))
    }
    .padding(.trailing, 5)
    .padding(.top, 60)
  }
}

#Preview {
  MapScreen(isShownTabBar: .constant(false))
    .environmentObject(StationViewModel())
    .environmentObject(UserViewModel())
}
