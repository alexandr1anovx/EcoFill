import SwiftUI
import MapKit

struct MapScreen: View {
  
  @Binding var isShownTabBar: Bool
  @State private var cameraPosition: MapCameraPosition = .region(.userRegion)
  @EnvironmentObject var stationVM: StationViewModel
  
  var body: some View {
    mapView
      .mapControls {
        MapUserLocationButton()
      }
      .overlay(alignment: .topTrailing) {
        showListButton
      }
      .task(id: stationVM.isShownRoute) {
        await stationVM.toggleRoutePresentation()
      }
      .onAppear { isShownTabBar = true }
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
          .stroke(.green, lineWidth: 3)
      }
    }
  }
  
  private func stationMark(for station: Station) -> some View {
    Image(systemName: "fuelpump.fill")
      .foregroundStyle(.accent)
      .padding(6)
      .background(.black)
      .clipShape(.circle)
      .shadow(radius: 3)
      .onTapGesture {
        stationVM.selectedStation = station
        stationVM.isShownDetail = true
      }
      .sheet(isPresented: $stationVM.isShownDetail) {
        MapItemView(station: stationVM.selectedStation ?? .mockStation)
          .presentationDetents([.height(270)])
          .presentationDragIndicator(.visible)
          .presentationCornerRadius(30)
      }
  }
  
  private var showListButton: some View {
    Button {
      stationVM.isShownList.toggle()
    } label: {
      Image(.menu)
        .foregroundStyle(.accent)
        .padding(11)
        .background(.primaryBackground)
        .clipShape(.buttonBorder)
    }
    .padding(.trailing, 6)
    .padding(.top, 60)
    .sheet(isPresented: $stationVM.isShownList) {
      StationListView()
        .presentationDetents([.height(450)])
        .presentationDragIndicator(.visible)
        .presentationCornerRadius(20)
    }
  }
}

#Preview {
  MapScreen(isShownTabBar: .constant(false))
    .environmentObject( StationViewModel() )
    .environmentObject( UserViewModel() )
}
