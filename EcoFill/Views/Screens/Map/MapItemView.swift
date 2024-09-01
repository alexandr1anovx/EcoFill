import SwiftUI
import MapKit

struct MapItemView: View {
    let station: Station
    @Binding var isPresentedRoute: Bool
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 15) {
                Text(station.name).font(.lexendBody)
                DataRow(image: .mark, title: station.address)
                DataRow(image: .clock, title: station.schedule)
                HStack {
                    DataRow(image: .payment, title: "Payment:")
                    Image(.mastercard)
                        .navigationBarImageSize
                    Image(.applePay)
                        .navigationBarImageSize
                }
                
                ScrollableFuelsStack(station: station)
                
                if isPresentedRoute {
                    BaseButton(image: .xmark, title: "Dismiss", pouring: .red) {
                        isPresentedRoute = false
                    }
                } else {
                    BaseButton(image: .route, title: "Route", pouring: .cmBlue) {
                        isPresentedRoute = true
                    }
                }
            }
            .padding(.horizontal, 15)
            .padding(.bottom, 35)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    DismissXButton()
                        .foregroundStyle(.red)
                }
            }
        }
    }
}
