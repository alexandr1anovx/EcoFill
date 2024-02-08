//
//  NetworkManager.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 03.02.2024.
//

import Foundation

// MARK: - Fetch Product Data from server.

//    .task {
//      await fetchProductData()
//    }

//  func fetchProductData() async {
//    guard let url = URL(string: "http://localhost:3000/products") else {
//      print("Error: Invalid URL")
//      return
//    }
//    do {
//      let (data, _) = try await URLSession.shared.data(from: url)
//      let decodedData = try JSONDecoder().decode([Product].self, from: data)
//      products = decodedData
//    } catch {
//      print("Error fetching or decoding data: \(error)")
//    }
//  }

// MARK: - Fetch Locations Data from server.

//    .task {
//      // This method asynchronously loads all locations from the server side and lists them.
//      await fetchLocationsData()
//    }
  
//  func fetchLocationsData() async {
//    // Check url existence.
//    guard let url = URL(string: "http://localhost:3000/locations") else {
//      fatalError("URL doesn't work properly!")
//    }
//    // Fetch data from URL.
//    do {
//      let (data,_) = try await URLSession.shared.data(from: url)
//
//      // Decode our data with JSONDecoder.
//      let decodedData = try JSONDecoder().decode([Location].self, from: data)
//
//      // Fill in our locations array with decoded data.
//      locations = decodedData
//    } catch {
//      print("Error fetching data: \(error)")
//    }
//  }
