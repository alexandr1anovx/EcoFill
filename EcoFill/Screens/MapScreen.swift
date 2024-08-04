//
//  MapScreen.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 30.11.2023.
//

import SwiftUI
import MapKit

struct MapScreen: View {
    
    // MARK: - Public Properties
    @EnvironmentObject var firestoreVM: FirestoreViewModel
    
    // MARK: - Private Properties
    @State private var locationManager = LocationManager.shared
    @State private var cameraPosition: MapCameraPosition = .region(.userRegion)
    @State private var selectedStation: Station?
    @State private var mapStyle: MapStyle = .standard
    @State private var route: MKRoute?
    @State private var isPresentedStationDetails = false
    @State private var isPresentedRoute = false
    @State private var isPresentedMapStyle = false
    @State private var isPresentedList = false
    
    // MARK: - body
    var body: some View {
        NavigationStack {
            Map(position: $cameraPosition) {
                UserAnnotation()
                
                ForEach(firestoreVM.stations) { station in
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
                                selectedStation = station
                                isPresentedStationDetails = true
                            }
                    }
                }
                
                if let route {
                    MapPolyline(route.polyline)
                        .stroke(.purple, lineWidth: 4)
                }
            }
            .mapStyle(mapStyle)
            .mapControls {
                MapUserLocationButton()
            }
            
            .overlay(alignment: .topTrailing) {
                MapControls(
                    isPresentedList: $isPresentedList,
                    isPresentedMapStyle: $isPresentedMapStyle
                )
                .padding(.trailing, 5)
                .padding(.top, 60)
            }
            
            .sheet(isPresented: $isPresentedList) {
                LocationsList(
                    selectedStation: $selectedStation,
                    isPresentedStationDetails: $isPresentedStationDetails,
                    isPresentedRoute: $isPresentedRoute
                )
                .presentationDetents([.medium, .large])
                .presentationDragIndicator(.visible)
                .presentationBackgroundInteraction(.disabled)
                .presentationCornerRadius(20)
            }
            
            .sheet(isPresented: $isPresentedMapStyle) {
                MapStyleView(mapStyle: $mapStyle)
                    .presentationDetents([.fraction(0.2)])
                    .presentationDragIndicator(.visible)
                    .presentationBackgroundInteraction(.disabled)
                    .presentationCornerRadius(20)
            }
            
            .sheet(isPresented: $isPresentedStationDetails) {
                MapItemView(
                    station: selectedStation ?? .testStation,
                    isPresentedRoute: $isPresentedRoute
                )
                .presentationDetents([.fraction(0.42)])
                .presentationBackgroundInteraction(.disabled)
                .presentationCornerRadius(20)
            }
            
            .onChange(of: selectedStation) {
                isPresentedStationDetails = selectedStation != nil && !isPresentedRoute
            }
            
            .task(id: isPresentedRoute) {
                if isPresentedRoute {
                    await fetchRoute()
                } else {
                    route = nil
                }
            }
        }
    }
    
    // MARK: - Private Methods
    private func fetchRoute() async {
        route = nil
        
        guard let userLocation = locationManager.manager.location else {
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
}
