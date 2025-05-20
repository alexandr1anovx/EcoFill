import SwiftUI
import MapKit

struct MapItemView: View {
  
  let station: Station
  private let transportTypes = MKDirectionsTransportType.allCases
  @EnvironmentObject var mapViewModel: MapViewModel
  
  // MARK: - body
  
  var body: some View {
    ZStack {
      Color.appBackground.ignoresSafeArea()
      VStack(alignment: .leading, spacing:17) {
        Spacer()
        cell(image: .marker, title: "street_label", data: station.street)
        cell(image: .clock, title: "schedule_label", data: station.schedule)
        cell(image: .money, title: "payment_label", data: station.paymentMethods)
        transportTypesView
        FuelStackView(for: station)
        routeButton
      }
      .padding(.horizontal,12)
    }
  }
  
  // MARK: - Auxilary UI Components
  
  private func cell(
    image: ImageResource,
    title: LocalizedStringKey,
    data: String
  ) -> some View {
    HStack(spacing:8) {
      Image(image).foregroundStyle(.accent)
      Text(title).foregroundStyle(.gray)
      Text(data)
    }
    .font(.footnote)
    .fontWeight(.medium)
  }
  
  private func transportLabel(for type: MKDirectionsTransportType) -> some View {
    Label(type.title, systemImage: type.iconName)
      .font(.footnote)
      .fontWeight(.medium)
      .foregroundStyle(.white)
      .padding(10)
      .background(
        type == mapViewModel.selectedTransport ? .accent : .black
      )
      .clipShape(.capsule)
      .animation(.spring, value: mapViewModel.selectedTransport)
      .onTapGesture { mapViewModel.selectedTransport = type }
  }
  
  private var transportTypesView: some View {
    HStack {
      Text("transportation_type")
        .font(.footnote)
        .fontWeight(.medium)
      ScrollView(.horizontal) {
        HStack(spacing:8) {
          ForEach(transportTypes, id: \.self) { type in
            transportLabel(for: type)
          }
        }
      }
      .shadow(radius:3)
      .scrollIndicators(.hidden)
    }
  }
  
  @ViewBuilder
  private var routeButton: some View {
    if mapViewModel.isShownRoute {
      Button {
        mapViewModel.isShownRoute = false
      } label: {
        ButtonLabelWithIcon(
          title: "hide_route",
          iconName: "x.circle",
          textColor: .white,
          pouring: .red
        )
      }
    } else {
      Button {
        mapViewModel.isShownRoute = true
      } label: {
        ButtonLabelWithIcon(
          title: "show_route",
          iconName: "arrow.trianglehead.branch",
          textColor: .black,
          pouring: .accent
        )
      }
    }
  }
}

#Preview {
  MapItemView(station: MockData.station)
    .environmentObject(MapViewModel.previewMode)
}
