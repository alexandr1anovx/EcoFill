import SwiftUI
import MapKit

struct MapScreen: View {
    @State private var cameraPosition: MapCameraPosition = .region(.userRegion)
    @EnvironmentObject var stationVM: StationViewModel
    
    var body: some View {
        Map(position: $cameraPosition) {
            UserAnnotation()
            ForEach(stationVM.stations) { station in
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
                            stationVM.selectedStation = station
                            stationVM.isDetailsShown = true
                        }
                }
            }
            
            if let route = stationVM.route {
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
        
        .sheet(isPresented: $stationVM.isListShown) {
            LocationsList()
                .presentationDetents([.medium, .large])
                .presentationDragIndicator(.visible)
                .presentationBackgroundInteraction(.disabled)
                .presentationCornerRadius(25)
        }
        
        .sheet(isPresented: $stationVM.isDetailsShown) {
            MapItemView(station: stationVM.selectedStation ?? .emptyStation)
            .interactiveDismissDisabled(true)
            .presentationBackgroundInteraction(.disabled)
            .presentationDetents([.height(290)])
            .presentationCornerRadius(20)
        }
        
        .task(id: stationVM.isRouteShown) {
            await stationVM.toggleRoutePresentation()
        }
    }
}
