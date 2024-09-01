import SwiftUI

struct StationCell: View {
    let station: Station
    let isShownRoute: Bool
    let action: () -> Void
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 8) {
                Text(station.street)
                    .font(.lexendCallout)
                    .foregroundStyle(.cmReversed)
                DataRow(image: .clock, title: station.schedule)
            }
            Spacer()
            
            if isShownRoute {
                BaseButton(image: .xmark, title: "Dismiss", pouring: .red) {
                    action()
                }
            } else {
                BaseButton(image: .route, title: "Route", pouring: .cmBlue) {
                    action()
                }
            }
        }
    }
}
