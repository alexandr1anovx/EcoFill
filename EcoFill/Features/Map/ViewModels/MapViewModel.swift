import MapKit

@MainActor 
final class MapViewModel: ObservableObject {
  
  @Published var selectedStation: Station?
  @Published var selectedTransport: MKDirectionsTransportType = .automobile
  @Published var route: MKRoute?
  @Published var isShownRoute: Bool = false
  @Published var isShownStationPreview: Bool = false
  @Published var isShownStationList: Bool = false
  let transportTypes = MKDirectionsTransportType.allCases
  
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
    if isShownRoute {
      if let selectedStation = selectedStation {
        await getRoute(to: selectedStation)
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
  static var previewMode: MapViewModel {
    let viewModel = MapViewModel()
    viewModel.selectedStation = MockData.station
    return viewModel
  }
}
