//
//  MapScreen.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 30.11.2023.
//

import SwiftUI
import MapKit
import CoreLocation

struct MapScreen: View {
  
  // MARK: - properties
  @EnvironmentObject var firestoreVM: FirestoreViewModel
  @State private var locationManager = LocationManager.shared
  @State private var cameraPosition: MapCameraPosition = .region(.userRegion)
  @State private var selectedStation: Station?
  @State private var mapStyle: MapStyle = .standard
  @State private var route: MKRoute?
  @State private var isShownStationDetails = false
  @State private var isShownRoute = false
  @State private var isShownMapStyle = false
  @State private var isShownList = false
  
  var body: some View {
    NavigationStack {
      Map(position: $cameraPosition) {
        
        // MARK: - annotations
        UserAnnotation()
        
        ForEach(firestoreVM.stations) { station in
          
          let name = station.name
          let coordinate = station.coordinate
          
          Annotation(name, coordinate: coordinate) {
            Circle()
              .foregroundStyle(.brown.gradient)
              .frame(width: 33, height: 33)
              .overlay {
                Image(.station)
                  .resizable()
                  .frame(width: 20, height: 20)
              }
              .onTapGesture {
                isShownStationDetails = true
                selectedStation = station
              }
          }
        }
        
        if let route {
          MapPolyline(route.polyline)
            .stroke(.purple, lineWidth: 4)
        }
      }
      
      // MARK: - map features
      .mapStyle(mapStyle)
      .mapControls {
        MapUserLocationButton()
      }
      
      .overlay(alignment: .topTrailing) {
        MapControls(isShownList: $isShownList, isShownMapStyle: $isShownMapStyle)
          .padding(.trailing, 5)
          .padding(.top, 60)
      }
      
      // MARK: - sheets
      .sheet(isPresented: $isShownList) {
        LocationsList(selectedStation: $selectedStation,
                      isShownStationDetails: $isShownStationDetails,
                      isShownRoute: $isShownRoute)
        .presentationDetents([.medium, .large])
        .presentationDragIndicator(.visible)
        .presentationBackgroundInteraction(.disabled)
        .presentationCornerRadius(20)
      }
      
      .sheet(isPresented: $isShownMapStyle) {
        MapStyleView(mapStyle: $mapStyle)
          .presentationDetents([.fraction(0.2)])
          .presentationDragIndicator(.visible)
          .presentationBackgroundInteraction(.disabled)
          .presentationCornerRadius(20)
      }
      
      .sheet(isPresented: $isShownStationDetails) {
        MapItemView(station: selectedStation ?? .testStation, isShownRoute: $isShownRoute)
          .presentationDetents([.fraction(0.42)])
          .presentationBackgroundInteraction(.disabled)
          .presentationCornerRadius(20)
      }
      
      .onChange(of: selectedStation) {
        if selectedStation != nil && !isShownRoute {
          isShownStationDetails = true
        } else {
          isShownStationDetails = false
        }
      }
          
      .task(id: isShownRoute) {
        if isShownRoute {
          await fetchRoute()
        } else {
          route = nil
        }
      }
      
    }
  }
  
  private func fetchRoute() async {
    
    route = nil
    
    guard let userLocation = locationManager.manager.location else {
      print("Cannot get user coordinates.")
      return
    }
    
    guard let selectedStation else {
      print("Cannot get station coordinates.")
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

#Preview {
  MapScreen()
    .environmentObject(AuthenticationViewModel())
    .environmentObject(FirestoreViewModel())
}
