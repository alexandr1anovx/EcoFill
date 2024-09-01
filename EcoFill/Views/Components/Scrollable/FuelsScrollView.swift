import SwiftUI

//struct FuelsScrollView: View {
//    
//    @EnvironmentObject var userViewModel: UserViewModel
//    @EnvironmentObject var mapViewModel: MapViewModel
//    
//    private var stationInSelectedCity: Station? {
//        mapViewModel.stations.first { $0.city == userViewModel.selectedCity.rawValue }
//    }
//    
//    var body: some View {
//        if let station = stationInSelectedCity {
//            ScrollView(.horizontal) {
//                HStack(spacing: 10) {
//                    FuelCell2(fuel: Fuel(type: .euroA95, price: station.euroA95))
//                    FuelCell2(fuel: Fuel(type: .euroDP, price: station.euroDP))
//                    FuelCell2(fuel: Fuel(type: .gas, price: station.gas))
//                }
//            }
//            .scrollIndicators(.hidden)
//            .shadow(radius: 10)
//        } else {
//            Text("No stations available in the selected city")
//        }
//    }
//}
