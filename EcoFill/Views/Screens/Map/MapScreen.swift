import SwiftUI
import MapKit

struct MapScreen: View {
    @State private var cameraPosition: MapCameraPosition = .region(.userRegion)
    @EnvironmentObject var mapViewModel: MapViewModel
    
    var body: some View {
        Map(position: $cameraPosition) {
            UserAnnotation()
            ForEach(mapViewModel.stations) { station in
                let name = station.name
                let coordinate = station.coordinate
                Annotation(name, coordinate: coordinate) {
                    Circle()
                        .foregroundStyle(.cmBlue)
                        .frame(width: 32, height: 32)
                        .overlay {
                            Image(.station)
                                .resizable()
                                .frame(width: 20, height: 20)
                        }
                        .onTapGesture {
                            mapViewModel.selectedStation = station
                            mapViewModel.isDetailsShown = true
                        }
                }
            }
            
            if let route = mapViewModel.route {
                MapPolyline(route.polyline)
                    .stroke(.blue, lineWidth: 4)
            }
        }
        .mapControls {
            MapUserLocationButton()
        }
        
        .overlay(alignment: .topTrailing) {
            MapControlStationsList()
                .padding(.trailing, 5)
                .padding(.top, 60)
        }
        
        .sheet(isPresented: $mapViewModel.isListShown) {
            LocationsList()
                .presentationDetents([.medium, .large])
                .presentationDragIndicator(.visible)
                .presentationBackgroundInteraction(.disabled)
                .presentationCornerRadius(25)
        }
        
        .sheet(isPresented: $mapViewModel.isDetailsShown) {
            MapItemView(station: mapViewModel.selectedStation ?? .emptyStation)
            .interactiveDismissDisabled(true)
            .presentationBackgroundInteraction(.disabled)
            .presentationDetents([.height(300)])
            .presentationCornerRadius(20)
        }
        
        .task(id: mapViewModel.isRouteShown) {
            await mapViewModel.toggleRoutePresentation()
        }
    }
}
