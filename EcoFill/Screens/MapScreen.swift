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
  @State private var locationManager = LocationManager.shared
  @ObservedObject var dataViewModel: FirestoreDataViewModel = FirestoreDataViewModel()
  
  @State private var cameraPosition: MapCameraPosition = .region(.userRegion)
  @State private var selectedMapItem: MKMapItem?
  @State private var locationResults: [MKMapItem] = []
  @State private var isPresentedMapItemPreview: Bool = false
  @State private var isPresentedLocationsListMode: Bool = false
  
  // MARK: - body
  var body: some View {
    NavigationStack {
      Map(position: $cameraPosition,selection: $selectedMapItem) {
        
        UserAnnotation()
        
        ForEach(locationResults, id: \.self) { mapItem in
          let placemark = mapItem.placemark
          let placemarkName = mapItem.name ?? ""
          let placemarkCoordinate = placemark.coordinate
          
          Marker(placemarkName, 
                 systemImage: "fuelpump",
                 coordinate: placemarkCoordinate)
          
            .tint(.accent)
        }
      }
      // Map settings
      .mapStyle(.standard)
      .mapControls { MapUserLocationButton() }
      
      // Button to show the list of locations.
      .overlay(alignment: .topTrailing) {
        RoundedRectangle(cornerRadius: 8)
          .fill(.defaultSystem)
          .frame(width: 44, height: 44, alignment: .center)
          .overlay {
            Image(systemName: "list.bullet")
              .foregroundStyle(.accent)
              .imageScale(.large)
            // when the user selects an image, change the state of the list presenation mode.
              .onTapGesture { isPresentedLocationsListMode = true }
          }
          .padding(.trailing,4)
          .padding(.top,60)
      }
      
      // Shows a list of locations.
      .sheet(isPresented: $isPresentedLocationsListMode) {
        LocationsList()
          .presentationDetents([.medium, .large])
          .presentationDragIndicator(.visible)
          .presentationBackgroundInteraction(.enabled(upThrough: .medium))
      }
      
      .onAppear { addTestLocations() }
      
      // Show the sheet with information about selected gas station.
      .sheet(isPresented: $isPresentedMapItemPreview) {
        MapItemPreview(mapItem: $selectedMapItem,
                       isPresentedMapItemPreview: $isPresentedMapItemPreview)
        .presentationDetents([.fraction(0.25)])
        .presentationDragIndicator(.visible)
        .presentationBackgroundInteraction(.enabled(upThrough: .medium))
      }
      
      // Switches the value when the user selects a new location.
      .onChange(of: selectedMapItem) { _, newValue in
        isPresentedMapItemPreview = (newValue != nil)
      }
      .onChange(of: locationManager.region) {
        withAnimation { cameraPosition = .region(locationManager.region) }
      }
    }
  }
  
  func addTestLocations() {
    let mapItem1 = MKMapItem(placemark: MKPlacemark(coordinate: .station1))
    mapItem1.name = "Station 1"
    let mapItem2 = MKMapItem(placemark: MKPlacemark(coordinate: .station2))
    mapItem2.name = "Station 2"
    
    locationResults.append(contentsOf: [mapItem1, mapItem2])
  }
}

#Preview { MapScreen() }

// MARK: - Extensions

extension CLLocationCoordinate2D {
  static let userLocation = CLLocationCoordinate2D(
    latitude: 46.96467671636197,
    longitude: 32.014379026091746)
  
  static let station1 = CLLocationCoordinate2D(
    latitude: 46.96286391341284,
    longitude: 32.00746990460587)
  
  static let station2 = CLLocationCoordinate2D(
    latitude: 46.96409733977896,
    longitude: 31.99735980155697)
}

extension MKCoordinateRegion {
  static let userRegion = MKCoordinateRegion(
    center: .userLocation,
    latitudinalMeters: 10000,
    longitudinalMeters: 10000)
}
