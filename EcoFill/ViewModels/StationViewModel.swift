import Foundation
import MapKit
import FirebaseFirestore

@MainActor
final class StationViewModel: ObservableObject {
  
  @Published var stations: [Station] = []
  @Published var selectedStation: Station?
  @Published var selectedTransportType: MKDirectionsTransportType = .automobile
  @Published var route: MKRoute?
  @Published var isShownRoute = false
  @Published var isShownStationDataSheet = false
  @Published var isShownStationList = false
  
  private let locationManager = LocationManager.shared
  
  // MARK: - Public Methods
  func getStations() {
    let stationCollection = Firestore.firestore().collection("stations")
    
    stationCollection.addSnapshotListener { snapshot, error in
      if let error {
        print(error.localizedDescription)
        return
      }
      
      guard let documents = snapshot?.documents else { return }
      
      self.stations = documents.map { snapshot -> Station in
        let data = snapshot.data()
        let id = snapshot.documentID
        let city = data["city"] as? String ?? ""
        let euroA95 = data["euroA95"] as? Double ?? 0.0
        let euroDP = data["euroDP"] as? Double ?? 0.0
        let gas = data["gas"] as? Double ?? 0.0
        let latitude = data["latitude"] as? Double ?? 0.0
        let longitude = data["longitude"] as? Double ?? 0.0
        let schedule = data["schedule"] as? String ?? ""
        let street = data["street"] as? String ?? ""
        
        return Station(
          id: id,
          city: city,
          euroA95: euroA95,
          euroDP: euroDP,
          gas: gas,
          latitude: latitude,
          longitude: longitude,
          schedule: schedule,
          street: street
        )
      }
    }
  }
  
  func getRoute(to station: Station?) async {
    route = nil
    guard let station else { return }
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
