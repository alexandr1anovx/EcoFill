//
//  LocationsList.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 01.12.2023.
//

import SwiftUI

struct LocationsList: View {
  @State private var locations = [Location]()
  
  var body: some View {
    NavigationStack {
      if locations.isEmpty {
        ContentUnavailableView("The list of locations is empty.",
                               systemImage: "mappin",
                               description: Text("Please, check your internet connection."))
      } else {
        List(locations) { location in
          LocationCell(location: location)
        }
        .listRowSpacing(20)
        .listStyle(.insetGrouped)
      }
    }
    .navigationTitle("Список локацій")
    .navigationBarTitleDisplayMode(.inline)
    
    .task {
      // This method asynchronously loads all locations from the server side and lists them.
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
  LocationsList()
}
