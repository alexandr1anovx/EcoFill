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
  
  // MARK: - Properties
  @EnvironmentObject var firestoreVM: FirestoreViewModel
  
  @State private var locationManager = LocationManager.shared
  @State private var cameraPosition: MapCameraPosition = .region(.userRegion)
  
  @State private var isPresentedMapStyle = false
  @State private var isPresentedList = false
  
  @State private var selectedStation: Station?
  @State private var mapStyle: MapStyle = .standard
  @State private var route: MKRoute?
  
  var body: some View {
    NavigationStack {
      Map(position: $cameraPosition) {
        
        // MARK: - Annotations
        UserAnnotation()
        
        ForEach(firestoreVM.stations) { station in
          let name = station.name
          let coordinate = station.coordinate
          
          Annotation(name, coordinate: coordinate) {
            Circle()
              .foregroundStyle(.brown)
              .frame(width: 33, height: 33)
              .overlay {
                Image(.station)
                  .resizable()
                  .frame(width: 20, height: 20)
              }
              .onTapGesture { selectedStation = station }
          }
        }
      }
      
      // MARK: - Map Features
      .mapStyle(mapStyle)
      .mapControls {
        MapUserLocationButton()
      }
      .overlay(alignment: .topTrailing) {
        MapControls(
          isPresentedList: $isPresentedList,
          isPresentedMapStyle: $isPresentedMapStyle)
        .padding(.trailing, 5)
        .padding(.top, 60)
      }
      
      // MARK: - Sheets
      .sheet(isPresented: $isPresentedList) {
        LocationsList()
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
      
      // Show an information about selected station.
      .sheet(item: $selectedStation) { station in
        MapItemView(station: station) {
          Task {
            await requestCalculateDirections() // Show the route
          }
        }
        .presentationDetents([.fraction(0.42)])
        .presentationBackgroundInteraction(.disabled)
        .presentationCornerRadius(20)
      }
    }
  }
  
  private func requestCalculateDirections() async {
    
    route = nil
    
    if let selectedStation {
      guard let currentUserLocation = locationManager.manager.location else { return }
      
      let startingMapItem = MKMapItem(placemark: MKPlacemark(coordinate: currentUserLocation.coordinate))
      
      let destinationPlacemark = MKPlacemark(coordinate: selectedStation.coordinate)
      let destinationMapItem = MKMapItem(placemark: destinationPlacemark)
      
      self.route = await calculateDirections(from: startingMapItem, to: destinationMapItem)
    }
  }
}


#Preview {
  MapScreen()
    .environmentObject(AuthenticationViewModel())
    .environmentObject(FirestoreViewModel())
}
