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
  @EnvironmentObject var authenticationVM: AuthenticationViewModel
  
  @State private var locationManager = LocationManager.shared
  @State private var cameraPosition: MapCameraPosition = .region(.userRegion)
  
  @State private var isPresentedLocationsList = false
  @State private var isPresentedMapStylePreview = false
  
  @State private var selectedStation: Station?
  @State private var selectedMapStyle: MapStyle = .standard
  
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
                .foregroundStyle(Color.grRedOrange)
                .frame(width:33, height:33)
              Image(systemName: "fuelpump")
                .imageScale(.medium)
                .foregroundStyle(.white)
            }
            .onTapGesture {
              selectedStation = station
            }
          }
        }
      }
    }
    .mapStyle(selectedMapStyle)
    .mapControls {
      MapUserLocationButton()
    }
    
    // MARK: - Additional map controls
    .overlay(alignment: .topTrailing) {
      CustomMapControls(isPresentedLocationsList: $isPresentedLocationsList, isPresentedMapStylePreview: $isPresentedMapStylePreview)
        .padding(.trailing,4)
        .padding(.top,60)
    }
    
    // MARK: - Sheets
    .sheet(isPresented: $isPresentedLocationsList) {
      LocationsList()
        .presentationDetents([.medium, .large])
        .presentationDragIndicator(.visible)
        .presentationBackgroundInteraction(.disabled)
        .presentationCornerRadius(20)
    }
    
    .sheet(isPresented: $isPresentedMapStylePreview) {
      MapStylePreview(selectedMapStyle: $selectedMapStyle)
        .presentationDetents([.fraction(0.15)])
        .presentationDragIndicator(.visible)
        .presentationBackgroundInteraction(.disabled)
        .presentationCornerRadius(20)
    }
    
    .sheet(item: $selectedStation) { station in
      // Show an information about selected station.
      MapItemPreview(station: station)
        .presentationDetents([.fraction(0.4)])
        .presentationDragIndicator(.visible)
        .presentationBackgroundInteraction(.disabled)
        .presentationCornerRadius(20)
    }
  }
}

#Preview {
  MapScreen()
    .environmentObject(FirestoreViewModel())
    .environmentObject(AuthenticationViewModel())
}
