import SwiftUI

struct MapControls: View {
    @Binding var isShownStationsList: Bool
    
    var body: some View {
        MapControlItem(img: .mark) { isShownStationsList = true }
    }
}

struct MapControlItem: View {
    let img: ImageResource
    let action: () -> Void?
    
    var body: some View {
        Button {
            action()
        } label: {
            Image(img).defaultImageSize
        }
        .customButtonStyle(pouring: .cmSystem)
        .shadow(radius: 5)
    }
}
