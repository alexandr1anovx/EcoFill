//
//  MockData.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 14.05.2025.
//


struct MockData {
  static let user = User(
    id: "1",
    fullName: "Name Surname",
    email: "example@gmail.com",
    city: "London",
    points: 10
  )
  
  static let station = Station(
    id: "2",
    city: "Mykolaiv",
    euroA95: 40.0,
    euroDP: 30.0,
    gas: 20.0,
    latitude: 46.968629,
    longitude: 31.957523,
    street: "Unknown street",
    schedule: "08:00-20:00",
    paymentMethods: "Apple Pay, Cash"
  )
}
