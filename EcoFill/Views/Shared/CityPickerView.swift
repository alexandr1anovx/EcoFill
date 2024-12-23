import SwiftUI

enum City: String, Identifiable, CaseIterable {
  case kyiv = "Kyiv"
  case mykolaiv = "Mykolaiv"
  case odesa = "Odesa"
  var id: Self { self }
}

struct CityPickerView: View {
  @EnvironmentObject var userVM: UserViewModel
  
  var body: some View {
    Picker("", selection: $userVM.selectedCity) {
      ForEach(City.allCases) { city in
        Text(city.rawValue)
      }
    }.pickerStyle(.segmented)
  }
}
