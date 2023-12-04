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
  
  @State private var cameraPosition: MapCameraPosition = .region(.userRegion)
  @State private var selectedMapItem: MKMapItem?
  /// The array will be filled with locations from the server.
  @State private var locationResults = [MKMapItem]()
  
  @State private var isPresentedMapItemPreview: Bool = false
  @State private var isPresentedLocationsListMode: Bool = false
  
  var body: some View {
    Map(position: $cameraPosition,selection: $selectedMapItem) {
      UserAnnotation()
      
      ForEach(locationResults, id: \.self) { mapItem in
        let placemark = mapItem.placemark
        let placemarkName = mapItem.name ?? "No placemark name"
        let placemarkCoordinate = placemark.coordinate
        
        Marker(placemarkName,coordinate: placemarkCoordinate)
      }
    }
    .overlay(alignment: .bottomTrailing) {
      Button("Список", systemImage: "list.clipboard") {
        isPresentedLocationsListMode.toggle()
      }
      .font(.callout).bold()
      .buttonStyle(.borderedProminent)
      .tint(.customBlack)
      .padding()
      .sheet(isPresented: $isPresentedLocationsListMode) {
        LocationsList(isPresentedLocationsListMode: $isPresentedLocationsListMode)
      }
    }
    
    // When the application appears, show locations on the map.
    .onAppear {
      addTestLocations()
    }
    
    // Show a sheet when user selects location.
    .sheet(isPresented: $isPresentedMapItemPreview) {
      MapItemPreview(selectedMapItem: $selectedMapItem,
                     isPresentedMapItemPreview: $isPresentedMapItemPreview)
    }
    
    // Switches the value when the user selects a new location.
    .onChange(of: selectedMapItem) { _, newValue in
      isPresentedMapItemPreview = (newValue != nil)
    }
  }
  
  func addTestLocations() {
    let mapItem1 = MKMapItem(placemark: MKPlacemark(coordinate: .station1))
    mapItem1.name = "Станція АЗС №1"
    
    let mapItem2 = MKMapItem(placemark: MKPlacemark(coordinate: .station2))
    mapItem2.name = "Станція АЗС №2"
    
    locationResults.append(contentsOf: [mapItem1, mapItem2])
  }
}

#Preview {
  MapScreen()
}

// MARK: - CLLocation2D extension
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
