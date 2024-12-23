import SwiftUI

struct MapItemView: View {
  let station: Station
  @EnvironmentObject var stationVM: StationViewModel
  
  var body: some View {
    ZStack {
      Color.primaryBackground.ignoresSafeArea()
      
      VStack(alignment: .leading, spacing: 20) {
        Spacer()
        CustomRow(data: station.address, image: "mark", imageColor: .accent)
        CustomRow(data: station.schedule, image: "clock", imageColor: .accent)
        HStack {
          CustomRow(data: "Pay with:",  image: "wallet", imageColor: .accent)
          Text("Cash, Mastercard, Pay")
            .font(.poppins(.medium, size: 13))
            .foregroundStyle(.primaryReversed)
            .opacity(0.8)
        }
        
        FuelStackView(for: station)
        
        if stationVM.isRouteShown {
          CustomBtn(title: "Hide", image: "xmark", color: .primaryRed) {
            stationVM.isRouteShown = false
          }
        } else {
          CustomBtn(title: "Route", image: "route", color: .accent) {
            stationVM.isRouteShown = true
          }
        }
      }
      .padding(.horizontal, 15)
    }
  }
}
