import SwiftUI
import MapKit

struct MapItemView: View {
    
    // MARK: - Public Properties
    let station: Station
    @Binding var isPresentedRoute: Bool
    
    // MARK: - body
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 15) {
                Text(station.name)
                    .font(.lexendBody)
                Row(img: .mark, text: station.address)
                Row(img: .clock, text: station.schedule)
                HStack {
                    Row(img: .payment, text: "Payment:")
                    Image(.mastercard)
                        .navigationBarImageSize
                    Image(.applePay)
                        .navigationBarImageSize
                }
                
                ScrollableFuelsStack(station: station)
                
                if isPresentedRoute {
                    DismissRouteButton { isPresentedRoute = false }
                } else {
                    ShowRouteButton { isPresentedRoute = true }
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
