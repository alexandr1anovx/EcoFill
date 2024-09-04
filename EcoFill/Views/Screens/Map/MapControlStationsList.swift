import SwiftUI

struct MapControlStationsList: View {
    @EnvironmentObject var mapViewModel: MapViewModel
    
    var body: some View {
        Button {
            mapViewModel.isListShown.toggle()
        } label: {
            Image(.mark)
                .defaultImageSize
        }
        .customButtonStyle(pouring: .cmSystem)
        .shadow(radius: 5)
    }
}
