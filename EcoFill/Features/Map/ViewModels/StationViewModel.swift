//
//  StationViewModel.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 27.03.2025.
//

import FirebaseFirestore
import SwiftUICore

@MainActor
final class StationViewModel: ObservableObject {
  
  // MARK: - Properties
  
  @Published var stations: [Station] = []
  @Published var sortType: StationSortType = .priceA95
  private let stationService: StationService
  
  var sortedStations: [Station] {
    switch sortType {
    case .priceA95: return stations.sorted { $0.euroA95 < $1.euroA95 }
    case .priceDP: return stations.sorted { $0.euroDP < $1.euroDP }
    case .priceGas: return stations.sorted { $0.gas < $1.gas }
    case .payment: return stations.sorted { $0.paymentMethods < $1.paymentMethods }
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
        case .failure(let error):
          print("⚠️ Failed to get stations: \(error.localizedDescription)")
        }
      }
    }
  }
}

extension StationViewModel {
  enum StationSortType: String, CaseIterable {
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
