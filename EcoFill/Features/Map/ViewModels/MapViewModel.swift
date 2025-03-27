import MapKit

@MainActor final class MapViewModel: ObservableObject {
  
  // MARK: Properties
  private let locationManager = LocationManager.shared
  @Published var selectedStation: Station?
  @Published var selectedTransportType: MKDirectionsTransportType = .automobile
  @Published var route: MKRoute?
  @Published var isShownRoute = false
  @Published var isShownStationDataSheet = false
  @Published var isShownStationList = false
  
  // MARK: Public Methods
  
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
    if isShownRoute {
      if let selectedStation = selectedStation {
        await getRoute(to: selectedStation)
      }
    } else {
      route = nil
    }
  }
  
  // MARK: Private Methods
  
  private func calculateDirections(from: MKMapItem, to: MKMapItem) async -> MKRoute? {
    let request = MKDirections.Request()
    request.transportType = selectedTransportType
    request.source = from
    request.destination = to
    
    do {
      let directions = MKDirections(request: request)
      let response = try await directions.calculate()
      let route = response.routes.first
      return route
    } catch {
      print(error.localizedDescription)
      return nil
    }
  }
}
