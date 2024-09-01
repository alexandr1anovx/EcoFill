import SwiftUI
import MapKit

struct MapScreen: View {
    @EnvironmentObject var mapViewModel: MapViewModel
    @State private var cameraPosition: MapCameraPosition = .region(.userRegion)
    
    var body: some View {
        NavigationStack {
            Map(position: $cameraPosition) {
                UserAnnotation()
                ForEach(mapViewModel.stations) { station in
                    let name = station.name
                    let coordinate = station.coordinate
                    Annotation(name, coordinate: coordinate) {
                        Circle()
                            .foregroundStyle(.cmBlue.gradient)
                            .frame(width: 33, height: 33)
                            .overlay {
                                Image(.station)
                                    .resizable()
                                    .frame(width: 20, height: 20)
                            }
                            .onTapGesture {
                                mapViewModel.selectStation(station)
                            }
                    }
                }
                
                if let route = mapViewModel.route {
                    MapPolyline(route.polyline)
                        .stroke(.purple, lineWidth: 4)
                }
            }
            .mapControls {
                MapUserLocationButton()
            }
            
            .overlay(alignment: .topTrailing) {
                MapControls(isShownStationsList: $mapViewModel.isShownStationsList)
                .padding(.trailing, 5)
                .padding(.top, 60)
            }
            
            .sheet(isPresented: $mapViewModel.isShownStationsList) {
                LocationsList()
                    .presentationDetents([.medium, .large])
                    .presentationDragIndicator(.visible)
                    .presentationBackgroundInteraction(.disabled)
                    .presentationCornerRadius(25)
            }
            
            .sheet(isPresented: $mapViewModel.isShownStationData) {
                MapItemView(
                    station: mapViewModel.selectedStation ?? .testStation,
                    isPresentedRoute: $mapViewModel.isRouteShown
                )
                .presentationDetents([.height(300)])
                .presentationBackgroundInteraction(.disabled)
                .presentationCornerRadius(20)
            }
            
            .task(id: mapViewModel.isRouteShown) {
                await mapViewModel.toggleRoutePresentation()
            }
        }
    }
}

extension MKCoordinateRegion: Equatable {
    public static func == (lhs: MKCoordinateRegion, rhs: MKCoordinateRegion) -> Bool {
        if lhs.center.latitude == rhs.center.latitude &&
            lhs.span.latitudeDelta == rhs.span.latitudeDelta &&
            lhs.span.longitudeDelta == rhs.span.longitudeDelta {
            return true
        } else {
            return false
        }
    }
    
    static let userRegion = MKCoordinateRegion(
        center: .userLocation,
        latitudinalMeters: 10000,
        longitudinalMeters: 10000)
}

extension CLLocationCoordinate2D {
    static let userLocation = CLLocationCoordinate2D(
        latitude: 46.959843,
        longitude: 32.012848
    )
}
