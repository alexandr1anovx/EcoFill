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
  
  var body: some View {
    NavigationStack {
      Map(position: $cameraPosition) {
        
        UserAnnotation()
        
        // MARK: - Map annotations
        ForEach(firestoreVM.stations) { station in
          let name = station.name
          let coordinate = station.coordinate
          
          Annotation(name, coordinate: coordinate) {
            ZStack {
              Circle()
                .foregroundStyle(.accent.gradient)
                .frame(width: 33, height: 33)
              Image(.fuelpump)
                .resizable()
                .frame(width: 25, height: 25)
            }
            .onTapGesture {
              selectedStation = station
            }
          }
        }
      }
    }
    .mapStyle(mapStyle)
    .mapControls {
      MapUserLocationButton()
    }
    
    // MARK: - Additional map controls
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
      MapStylePreview(mapStyle: $mapStyle)
        .presentationDetents([.fraction(0.2)])
        .presentationDragIndicator(.visible)
        .presentationBackgroundInteraction(.disabled)
        .presentationCornerRadius(20)
    }
    
    .sheet(item: $selectedStation) { station in
      // Show an information about selected station.
      MapItemPreview(station: station)
        .presentationDetents([.fraction(0.42)])
        .presentationBackgroundInteraction(.disabled)
        .presentationCornerRadius(20)
    }
  }
}
