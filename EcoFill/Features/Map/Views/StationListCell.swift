import SwiftUI
import MapKit

struct StationListCell: View {
  @Environment(MapViewModel.self) var mapViewModel
  
  let station: Station
  private let transportTypes = MKDirectionsTransportType.allCases
  private var isPresentedRoute: Bool {
    mapViewModel.selectedStation == station && mapViewModel.showRoute
  }
  
  var body: some View {
    VStack(alignment: .leading, spacing: 15) {
      VStack(alignment: .leading, spacing: 10) {
        MapItemCell(title: "Address", data: station.street)
        MapItemCell(title: "Schedule", data: station.schedule)
        MapItemCell(title: "Payment", data: station.paymentMethods.joined(separator: ", "))
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
      FuelStackCompact(station: station)
      
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
      .buttonStyle(.plain) // prevents the entire cell from responding to a click.
    }
    .padding()
    .background(.thinMaterial)
    .clipShape(.rect(cornerRadius: 18))
  }
}

#Preview {
  StationListCell(station: Station.mock)
    .environment(MapViewModel.mockObject)
}
