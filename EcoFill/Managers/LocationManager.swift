import Foundation
import MapKit

final class LocationManager: NSObject, CLLocationManagerDelegate {
    
    // MARK: - Public Properties
    static let shared = LocationManager()
    let manager = CLLocationManager()
    
    // MARK: - Private Properties
    private var error: LocationError? = nil
    private var region = MKCoordinateRegion()
    
    override init() {
        super.init()
        manager.delegate = self
    }
}

enum LocationError: Error {
    case authorizationDenied
    case authorizationRestricted
    case locationUnknown
    case accessDenied
    case network
    case operationFailed
    
    private var errorDescription: String {
        switch self {
        case .authorizationDenied:
            return NSLocalizedString("Location access denied", comment: "")
        case .authorizationRestricted:
            return NSLocalizedString("Location access restricted", comment: "")
        case .locationUnknown:
            return NSLocalizedString("Location unknown", comment: "")
        case .accessDenied:
            return NSLocalizedString("Access denied", comment: "")
        case .network:
            return NSLocalizedString("Network failed", comment: "")
        case .operationFailed:
            return NSLocalizedString("Operation failed", comment: "")
        }
    }
}

// MARK: - CLLocationManagerDelegate
extension LocationManager {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locations.last.map {
            region = MKCoordinateRegion(
                center: CLLocationCoordinate2D(
                    latitude: $0.coordinate.latitude,
                    longitude: $0.coordinate.longitude
                ),
                span: MKCoordinateSpan(
                    latitudeDelta: 0.05,
                    longitudeDelta: 0.05
                )
            )
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .notDetermined:
            manager.requestWhenInUseAuthorization()
        case .restricted:
            print("Restricted")
        case .denied:
            print("Denied")
        case .authorizedAlways, .authorizedWhenInUse:
            manager.requestLocation()
        default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        if let clError = error as? CLError {
            switch clError.code {
            case .locationUnknown:
                self.error = .locationUnknown
            case .denied:
                self.error = .accessDenied
            case .network:
                self.error = .network
            @unknown default:
                self.error = .operationFailed
            }
        }
    }
}
