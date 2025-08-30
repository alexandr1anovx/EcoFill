//
//  StationViewModel.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 27.03.2025.
//

import Firebase

@MainActor
@Observable
final class StationViewModel {
  
  private(set) var stations: [Station] = []
  private(set) var sortOptions = StationSortOption.allCases
  var sortType: StationSortOption = .priceA95
  var selectedCity: City = .mykolaiv
  
  // MARK: - Computed Properties
  
  var sortedStations: [Station] {
    let filteredByCity: [Station]
    filteredByCity = stations.filter { $0.city == selectedCity.rawValue }
    
    switch sortType {
    case .priceA95:
      return filteredByCity.sorted {
        let price1 = $0.fuelInfo?.euroA95 ?? Double.greatestFiniteMagnitude
        let price2 = $1.fuelInfo?.euroA95 ?? Double.greatestFiniteMagnitude
        return price1 < price2
      }
    case .priceDP:
      return filteredByCity.sorted {
        let price1 = $0.fuelInfo?.euroDP ?? Double.greatestFiniteMagnitude
        let price2 = $1.fuelInfo?.euroDP ?? Double.greatestFiniteMagnitude
        return price1 < price2
      }
    case .priceGas:
      return filteredByCity.sorted {
        let price1 = $0.fuelInfo?.gas ?? Double.greatestFiniteMagnitude
        let price2 = $1.fuelInfo?.gas ?? Double.greatestFiniteMagnitude
        return price1 < price2
      }
    }
  }
  
  var stationsInSelectedCity: [Station] {
    sortedStations.filter {
      $0.city == selectedCity.rawValue
    }
  }
  
  // MARK: - Dependencies
  
  private let stationService: StationServiceProtocol
  
  // MARK: - Init
  
  init(stationService: StationServiceProtocol = StationService()) {
    self.stationService = stationService
  }
  
  // MARK: - Public Methods
  
  func fetchStations() async {
    do {
      stations = try await stationService.fetchStationsData()
      print(stations)
    } catch {
      print("Failed to fetch stations: \(error)")
    }
  }
}

extension StationViewModel {
  enum StationSortOption: String, CaseIterable, Identifiable {
    case priceA95 = "Ціна A-95"
    case priceDP = "Ціна ДП"
    case priceGas = "Ціна Газ"
    
    var id: String { self.rawValue }
  }
}

extension StationViewModel {
  static let mockObject: StationViewModel = {
    let viewModel = StationViewModel()
    viewModel.stations = [Station.mock]
    return viewModel
  }()
}
