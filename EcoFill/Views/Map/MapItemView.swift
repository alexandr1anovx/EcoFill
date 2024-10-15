import SwiftUI

struct MapItemView: View {
    
    @EnvironmentObject var stationVM: StationViewModel
    let station: Station
    
    var body: some View {
        VStack(alignment: .leading, spacing: 18) {
            Text(station.name)
                .font(.poppins(.medium, size: 18))
            CustomRow(station.address, image: "location.fill")
            CustomRow(station.schedule, image: "clock")
            
            HStack {
                CustomRow("Pay with:", image: "creditcard")
                Image(.mastercard).navigationBarImageSize
                Image(.applePay).navigationBarImageSize
            }
            
            FuelStack(station: station)
            
            if stationVM.isRouteShown {
                CustomBtn("Hide", image: "xmark", color: .red) {
                    stationVM.isRouteShown = false
                }
            } else {
                CustomBtn("Route", image: "arrow.triangle.branch", color: .accent) {
                    stationVM.isRouteShown = true
                }
            }
        }
        .padding(.top, 10)
        .padding(.horizontal, 15)
    }
}
