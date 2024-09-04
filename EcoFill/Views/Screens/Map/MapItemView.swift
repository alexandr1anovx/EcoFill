import SwiftUI

struct MapItemView: View {
    @EnvironmentObject var mapViewModel: MapViewModel
    let station: Station
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            HStack {
                Text(station.name)
                    .font(.system(size: 18))
                    .fontWeight(.medium)
                    .fontDesign(.rounded)
                Spacer()
                DismissXButton {
                    mapViewModel.isDetailsShown = false
                    mapViewModel.isRouteShown = false
                }
            }
            
            Row(station.address, image: .mark)
            Row(station.schedule, image: .clock)
            
            HStack {
                Row("Payment:", image: .payment)
                Image(.mastercard)
                    .navigationBarImageSize
                Image(.applePay)
                    .navigationBarImageSize
            }
            
            FuelsInSelectedStation(station)
            
            if mapViewModel.isRouteShown {
                BaseButton("Hide Route", .route, .blue) {
                    mapViewModel.isRouteShown = false
                }
            } else {
                BaseButton("Get directions", .route, .cmBlue) {
                    mapViewModel.isRouteShown = true
                }
            }
        }
        .padding(.horizontal, 15)
    }
}
