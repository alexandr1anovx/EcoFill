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
                        .foregroundStyle(.accent.gradient)
                        .frame(width: 30, height: 32)
                        .overlay {
                            Image(systemName: "fuelpump.fill")
                                .foregroundStyle(.cmBlack)
                                .font(.callout)
                        }
                        .onTapGesture {
                            stationVM.selectedStation = station
                            stationVM.isDetailsShown = true
                        }
                }
            }
            if let route = stationVM.route {
                MapPolyline(route.polyline)
                    .stroke(.purple, lineWidth: 4)
            }
        }
        .mapControls {
            MapUserLocationButton()
        }
        .overlay(alignment: .topTrailing) {
            Button {
                stationVM.isListShown.toggle()
            } label: {
                Image(systemName: "list.clipboard")
                    .font(.title3)
                    .foregroundStyle(.accent)
            }
            .customButtonStyle(pouring: .cmSystem)
            .padding(.trailing, 5)
            .padding(.top, 60)
        }
        .sheet(isPresented: $stationVM.isListShown) {
            StationsList()
                .presentationDetents([.height(400), .large])
                .presentationDragIndicator(.visible)
                .presentationCornerRadius(20)
        }
        .sheet(isPresented: $stationVM.isDetailsShown) {
            MapItemView(station: stationVM.selectedStation ?? .emptyStation)
                .presentationDragIndicator(.visible)
                .presentationDetents([.height(300)])
                .presentationCornerRadius(20)
        }
        .task(id: stationVM.isRouteShown) {
            await stationVM.toggleRoutePresentation()
        }
    }
}
