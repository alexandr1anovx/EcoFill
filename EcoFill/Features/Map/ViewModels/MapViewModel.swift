import MapKit

@MainActor
@Observable
final class MapViewModel {
  
  var selectedStation: Station?
  var selectedTransport: MKDirectionsTransportType = .automobile
  let transportTypes: [MKDirectionsTransportType] = MKDirectionsTransportType.allCases
  var route: MKRoute?
  var showRoute = false
  var showStationPreview = false
  var showStationList = false
  
  // MARK: - Private Properties
  
  private let locationManager = LocationManager.shared
  
  // MARK: - Public Methods
  
  func getRoute(to station: Station) async {
    route = nil
    guard let userLocation = locationManager.manager.location else { return }
    let userCoordinate = userLocation.coordinate
    let userPlacemark = MKPlacemark(coordinate: userCoordinate)
    let stationCoordinate = station.coordinate
    let stationPlacemark = MKPlacemark(coordinate: stationCoordinate)
    let source = MKMapItem(placemark: userPlacemark)
    let destination = MKMapItem(placemark: stationPlacemark)
    self.route = await calculateDirections(from: source, to: destination)
  }
  
  func toggleRoutePresentation() async {
    if showRoute {
      if let station = selectedStation {
        await getRoute(to: station)
      }
    } else {
      route = nil
    }
  }
  
  // MARK: - Private Methods
  
  private func calculateDirections(from: MKMapItem, to: MKMapItem) async -> MKRoute? {
    let request = MKDirections.Request()
    request.transportType = selectedTransport
    request.source = from
    request.destination = to
    
    do {
      let directions = MKDirections(request: request)
      let response = try await directions.calculate()
      guard let route = response.routes.first else {
        print("No routes found")
        return nil
      }
      return route
    } catch {
      print("Failed to calculate directions: \(error.localizedDescription)")
      return nil
    }
  }
}

// MARK: - Preview Mode

extension MapViewModel {
  static var mockObject: MapViewModel {
    let viewModel = MapViewModel()
    viewModel.selectedStation = MockData.station
    return viewModel
  }
}
