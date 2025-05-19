//
//  StationServiceProtocol.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 19.05.2025.
//

import Foundation

protocol StationServiceProtocol {
  func getStationsData(completion: @escaping (Result<[Station], Error>) -> Void)
}
