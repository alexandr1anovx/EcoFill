import SwiftUI
import MapKit

struct MapScreen: View {
  
  @Binding var isShownTabBar: Bool
  @State private var cameraPosition: MapCameraPosition = .region(.userRegion)
  @EnvironmentObject var stationVM: StationViewModel
  
  var body: some View {
    Map(position: $cameraPosition) {
      UserAnnotation()
        .foregroundStyle(.primaryOrange)
      ForEach(stationVM.stations) { station in
        let name = station.name
        let coordinate = station.coordinate
        Annotation(name, coordinate: coordinate) {
          StationMarkView()
            .onTapGesture {
              stationVM.selectedStation = station
              stationVM.isDetailsShown = true
            }
        }
      }
      if let route = stationVM.route {
        MapPolyline(route.polyline)
          .stroke(.purple, lineWidth: 4)
      }
    }
    .mapControls {
      MapUserLocationButton()
    }
    .overlay(alignment: .topTrailing) {
      Button {
        stationVM.isListShown.toggle()
      } label: {
        Image(systemName: "list.clipboard")
          .font(.title3)
          .foregroundStyle(.accent)
      }
      .buttonModifier(pouring: .primaryBackground)
      .padding(.trailing, 5)
      .padding(.top, 60)
    }
    .sheet(isPresented: $stationVM.isListShown) {
      StationListView()
        .presentationDetents([.height(400), .large])
        .presentationDragIndicator(.visible)
        .presentationCornerRadius(20)
    }
    .sheet(isPresented: $stationVM.isDetailsShown) {
      MapItemView(station: stationVM.selectedStation ?? .mockStation)
        .presentationDetents([.height(270)])
        .presentationDragIndicator(.visible)
        .presentationCornerRadius(25)
    }
    .task(id: stationVM.isRouteShown) {
      await stationVM.toggleRoutePresentation()
    }
    .onAppear { isShownTabBar = true }
  }
}
