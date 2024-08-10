import SwiftUI

struct StationCell: View {
    
    // MARK: - Public Properties
    let station: Station
    let isShownRoute: Bool
    let action: () -> Void
    
    // MARK: - body
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 8) {
                Text(station.street)
                    .font(.lexendCallout)
                    .foregroundStyle(.cmReversed)
                Row(img: .clock, text: station.schedule)
            }
            Spacer()
            
            if isShownRoute {
                DismissRouteButton { action() }
            } else {
                ShowRouteButton { action() }
            }
        }
    }
}
