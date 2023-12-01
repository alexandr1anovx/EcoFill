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
  
  @State private var isShowingLocationItemPreview: Bool = false
  @State private var isShowingLocationsInListMode: Bool = false
  
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
        isShowingLocationsInListMode.toggle()
      }
      .font(.callout).bold()
      .buttonStyle(.borderedProminent)
      .tint(.customBlack)
      .padding()
      .sheet(isPresented: $isShowingLocationsInListMode) {
        LocationsList(isShowingLocationsInListMode: $isShowingLocationsInListMode)
      }
    }
    
    // When the application appears, show these locations on the map.
    .onAppear {
      let mapItem1 = MKMapItem(placemark: MKPlacemark(coordinate: .station1))
      mapItem1.name = "Станція АЗС №1"
      
      let mapItem2 = MKMapItem(placemark: MKPlacemark(coordinate: .station2))
      mapItem2.name = "Станція АЗС №2"
      
      locationResults.append(contentsOf: [mapItem1, mapItem2])
    }
    
    // Show a sheet when user selects location.
    .sheet(isPresented: $isShowingLocationItemPreview) {
      LocationItemPreview(selectedMapItem: $selectedMapItem,
                      isShowingLocationItemPreview: $isShowingLocationItemPreview)
      .presentationDetents([.height(230)])
      .presentationBackgroundInteraction(.enabled(upThrough: .height(230)))
      .presentationCornerRadius(15)
      .interactiveDismissDisabled(true)
    }
    
    // Toggle 'isShowingLocationItemPreview' value when the user select a new location.
    .onChange(of: selectedMapItem) { oldValue, newValue in
      isShowingLocationItemPreview = newValue != nil
    }
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
