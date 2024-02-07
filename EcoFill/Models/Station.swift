//
//  Station.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 06.02.2024.
//

import Foundation
import MapKit

struct Station: Decodable, Identifiable, Equatable, Hashable {  
  var id = UUID()
  
  var name: String
  var street: String
  var city: String
  var country: String
  var schedule: String
  
  var latitude: Double
  var longitude: Double
  
  var address: String {
    return "\(street), \(city), \(country)"
  }
  
  var coordinate: CLLocationCoordinate2D {
    CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
  }
}

extension Station {
  static var testStation = Station(name: "EcoFill", 
                                   street: "3rd Slobidska",
                                   city: "Mykolaiv",
                                   country: "Ukraine",
                                   schedule: "08:00 - 22:00",
                                   latitude: 46.95611207632222,
                                   longitude: 31.970336428606245)
}
