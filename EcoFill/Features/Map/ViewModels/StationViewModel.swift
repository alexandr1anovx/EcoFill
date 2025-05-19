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
  private let stationService: StationService
  
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
