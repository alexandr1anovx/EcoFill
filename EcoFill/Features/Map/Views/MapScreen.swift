import SwiftUI
import MapKit

struct MapScreen: View {
  @Environment(StationViewModel.self) var stationViewModel
  @Bindable var viewModel: MapViewModel
  @State private var cameraPosition: MapCameraPosition = .region(.userRegion)
  
  var body: some View {
    Map(position: $cameraPosition) {
      UserAnnotation()
      ForEach(stationViewModel.stations) { station in
        let coordinate = station.coordinate
        Annotation("EcoFill", coordinate: coordinate) {
          Button {
            viewModel.selectedStation = station
            viewModel.showStationPreview = true
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
      if let route = viewModel.route {
        MapPolyline(route.polyline)
          .stroke(.purple, lineWidth: 4)
      }
    }
    .overlay(alignment: .topTrailing) {
      Button {
        viewModel.showStationList.toggle()
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
    .sheet(isPresented: $viewModel.showStationPreview) {
      MapItemView(station: viewModel.selectedStation ?? Station.mock)
    }
    .sheet(isPresented: $viewModel.showStationList) {
      StationListView(viewModel: stationViewModel)
        .presentationDetents([.large])
        .presentationDragIndicator(.visible)
        .presentationCornerRadius(25)
    }
    .task(id: viewModel.showRoute) {
      await viewModel.toggleRoutePresentation()
    }
  }
}

#Preview {
  MapScreen(viewModel: MapViewModel.mockObject)
    .environment(StationViewModel.mockObject)
}
