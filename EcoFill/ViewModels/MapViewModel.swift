import MapKit
import FirebaseFirestore

@MainActor
final class MapViewModel: ObservableObject {
    
    // MARK: - Public Properties
    @Published var stations: [Station] = []
    @Published var route: MKRoute?
    @Published var isRouteShown = false
    @Published var isShownStationData = false
    @Published var isShownStationsList = false
    @Published var selectedStation: Station?
    
    // MARK: - Private Properties
    private let locationService = LocationService.shared
    
    // MARK: - Public Methods
    func getStations() {
        let stationsCollection = Firestore.firestore().collection("stations")
        
        stationsCollection.addSnapshotListener { snapshot, error in
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
                let name = data["name"] as? String ?? ""
                let postalCode = data["postalCode"] as? String ?? ""
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
                    name: name,
                    postalCode: postalCode,
                    schedule: schedule,
                    street: street
                )
            }
        }
    }
    
    func selectStation(_ station: Station) {
        selectedStation = station
        isShownStationData = true
    }
    
    func toggleRoutePresentation() async {
        if isRouteShown {
            await fetchRoute()
        } else {
            route = nil
        }
    }
    
    func fetchRoute() async {
        route = nil
        guard let userLocation = locationService.manager.location else {
            print("Cannot get user coordinates")
            return
        }
        guard let selectedStation else {
            print("Cannot get station coordinates")
            return
        }
        
        let userCoordinate = userLocation.coordinate
        let userPlacemark = MKPlacemark(coordinate: userCoordinate)
        
        let stationCoordinate = selectedStation.coordinate
        let stationPlacemark = MKPlacemark(coordinate: stationCoordinate)
        
        let startPoint = MKMapItem(placemark: userPlacemark)
        let endPoint = MKMapItem(placemark: stationPlacemark)
        
        route = await calculateDirections(from: startPoint, to: endPoint)
    }
    
    // MARK: - Private Methods
    private func calculateDirections(from: MKMapItem, to: MKMapItem) async -> MKRoute? {
        let request = MKDirections.Request()
        request.transportType = .walking
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
