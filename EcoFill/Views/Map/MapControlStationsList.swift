import SwiftUI

struct MapControlStationsList: View {
    
    @EnvironmentObject var stationVM: StationViewModel
    
    var body: some View {
        Button {
            stationVM.isListShown.toggle()
        } label: {
            Image(.mark)
                .defaultImageSize
        }
        .customButtonStyle(pouring: .cmSystem)
        .shadow(radius: 5)
    }
}
