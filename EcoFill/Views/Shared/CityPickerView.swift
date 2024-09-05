import SwiftUI

struct CityPickerView: View {
    @EnvironmentObject var userVM: UserViewModel
    
    var body: some View {
        Picker("", selection: $userVM.selectedCity) {
            ForEach(City.allCases) { city in
                Text(city.rawValue)
            }
        }
        .pickerStyle(.segmented)
    }
}
