import SwiftUI
import MapKit

struct StationListCell: View {
  let station: Station
  private let transportTypes = MKDirectionsTransportType.allCases
  private var isPresentedRoute: Bool {
    mapViewModel.selectedStation == station
    && mapViewModel.showRoute
  }
  @Environment(MapViewModel.self) var mapViewModel
  
  
  var body: some View {
    VStack(alignment: .leading, spacing: 15) {
      VStack(alignment: .leading, spacing: 10) {
        MapItemCell(iconName: "location.app.fill", title: "Address", data: station.street)
        MapItemCell(iconName: "timer", title: "Schedule", data: station.schedule)
        MapItemCell(iconName: "dollarsign.circle.fill", title: "Payment", data: station.paymentMethods)
      }
      
      HStack {
        Text("Travel Mode:")
          .font(.footnote)
          .fontWeight(.semibold)
        ScrollView(.horizontal) {
          HStack(spacing: 8) {
            ForEach(mapViewModel.transportTypes, id: \.self) { type in
              ModeButton(transportType: type)
            }
          }
        }
        .shadow(radius: 2)
        .scrollIndicators(.hidden)
      }
      
      //transportationOptionsView
      FuelStackView(for: station)
      
      
      Group {
        if isPresentedRoute {
          Button {
            mapViewModel.selectedStation = nil
            mapViewModel.showStationPreview = false
            mapViewModel.showRoute = false
          } label: {
            Label("Hide Route", systemImage: "x.circle")
              .prominentButtonStyle(tint: .red)
          }
        } else {
          Button {
            mapViewModel.selectedStation = station
            mapViewModel.showStationPreview = false
            mapViewModel.showRoute = true
          } label: {
            Label("Show Route", systemImage: "arrow.trianglehead.branch")
              .prominentButtonStyle(tint: .green)
          }
        }
      }
      .buttonStyle(.plain) // to prevent the entire cell from responding to a click.
    }
  }
}

#Preview {
  StationListCell(station: MockData.station)
    .environment(MapViewModel.mockObject)
}
