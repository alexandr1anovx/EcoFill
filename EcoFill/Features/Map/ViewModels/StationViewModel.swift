//
//  StationViewModel.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 27.03.2025.
//

import Foundation

@MainActor
@Observable
final class StationViewModel {
  
  var stations: [Station] = []
  var sortType: StationSortOption = .priceA95
  var selectedCity: City = .mykolaiv
  let sortOptions = StationSortOption.allCases
  
  // MARK: - Computed Properties
  
  var sortedStations: [Station] {
    switch sortType {
    case .priceA95:
      stations.sorted { $0.euroA95 < $1.euroA95 }
    case .priceDP:
      stations.sorted { $0.euroDP < $1.euroDP }
    case .priceGas:
      stations.sorted { $0.gas < $1.gas }
    case .payment:
      stations.sorted { $0.paymentMethods < $1.paymentMethods }
    }
  }
  
  var stationsInSelectedCity: [Station] {
    sortedStations.filter {
      $0.city == selectedCity.rawValue
    }
  }
  
  var stationsInSelectedCityMock: [Station] = [MockData.station, MockData.station]
  
  private let stationService: StationService
  
  // MARK: - Init
  
  init(stationService: StationService = StationService()) {
    self.stationService = stationService
  }
  
  // MARK: - Public Methods
  
  func fetchStations() async {
    do {
      stations = try await stationService.fetchStationsData()
    } catch {
      print("⚠️ StationViewModel: Failed to fetch stations: \(error.localizedDescription)")
    }
  }
}

// MARK: - Extension: Station Sort Option

extension StationViewModel {
  enum StationSortOption: String, CaseIterable {
    case priceA95 = "A95 Euro"
    case priceDP = "DP Euro"
    case priceGas = "Gas"
    case payment = "Payment Methods"
  }
}

// MARK: - Preview Mode

extension StationViewModel {
  static var previewMode: StationViewModel {
    let viewModel = StationViewModel()
    viewModel.stations = [MockData.station]
    return viewModel
  }
}
