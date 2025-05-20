//
//  StationViewModel.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 27.03.2025.
//

import FirebaseFirestore

@MainActor
final class StationViewModel: ObservableObject {
  
  // MARK: - Properties
  
  @Published var stations: [Station] = []
  @Published var sortType: StationSortType = .none
  private let stationService: StationService
  
  var sortedStations: [Station] {
    switch sortType {
    case .none: return stations
    case .priceA95: return stations.sorted { $0.euroA95 < $1.euroA95 }
    case .priceDP: return stations.sorted { $0.euroDP < $1.euroDP }
    case .priceGas: return stations.sorted { $0.gas < $1.gas }
    case .paymentMethods: return stations.sorted { $0.paymentMethods < $1.paymentMethods }
    }
  }
  
  // MARK: - Init
  
  init(stationService: StationService = StationService()) {
    self.stationService = stationService
    getStationsData()
  }
  
  // MARK: - Public Methods
  
  func getStationsData() {
    stationService.getStationsData { [weak self] result in
      DispatchQueue.main.async {
        switch result {
        case .success(let stations):
          self?.stations = stations
          print(stations)
        case .failure(let error):
          print("Failed to get stations: \(error.localizedDescription)")
        }
      }
    }
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

extension StationViewModel {
  enum StationSortType: String, CaseIterable {
    case none = "None"
    case priceA95 = "A95"
    case priceDP = "DP"
    case priceGas = "Gas"
    case paymentMethods = "Payment Methods"
  }
}
