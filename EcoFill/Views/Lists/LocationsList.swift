//
//  LocationsList.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 01.12.2023.
//

import SwiftUI

struct LocationsList: View {
  
  @State private var locations = [Location]()
  @Binding var isPresentedLocationsListMode: Bool
  
  var body: some View {
    NavigationStack {
      // Show a list of location cells
      List(locations) { location in
        LocationCell(location: location)
      }
      .listRowSpacing(20)
      .listStyle(.insetGrouped)
      
      .toolbar {
        ToolbarItem(placement: .cancellationAction) {
          CancellationButton { isPresentedLocationsListMode = false }
        }
      }
    }
    
    // This method asynchronously loads all locations on the server side and lists them.
    .task {
      await fetchLocationsData()
    }
  }
  
  func fetchLocationsData() async {
    // Check url existence.
    guard let url = URL(string: "http://localhost:3000/locations") else {
      fatalError("URL doesn't work properly!")
    }
    // Fetch data from URL.
    do {
      let (data,_) = try await URLSession.shared.data(from: url)
      
      // Decode our data with JSONDecoder.
      let decodedData = try JSONDecoder().decode([Location].self, from: data)
      
      // Fill in our locations array with decoded data.
      locations = decodedData
    } catch {
      print("Error fetching data: \(error)")
    }
  }
}

#Preview {
  LocationsList(isPresentedLocationsListMode: .constant(true))
}
