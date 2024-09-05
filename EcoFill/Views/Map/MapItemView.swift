import SwiftUI

struct MapItemView: View {
    
    @EnvironmentObject var stationVM: StationViewModel
    let station: Station
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            HStack {
                Text(station.name)
                    .font(.system(size: 18))
                    .fontWeight(.medium)
                    .fontDesign(.rounded)
                Spacer()
                XmarkButton {
                    stationVM.isDetailsShown = false
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
            
            if stationVM.isRouteShown {
                BaseButton("Hide Route", .route, .blue) {
                    stationVM.isRouteShown = false
                }
            } else {
                BaseButton("Get directions", .route, .cmBlue) {
                    stationVM.isRouteShown = true
                }
            }
        }
        .padding(.top,10)
        .padding(.horizontal,15)
    }
}
