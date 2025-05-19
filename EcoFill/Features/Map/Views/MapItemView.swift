import SwiftUI
import MapKit

struct MapItemView: View {
  
  let station: Station
  private let transportTypes = MKDirectionsTransportType.allCases
  @EnvironmentObject var mapViewModel: MapViewModel
  
  // MARK:  - body
  
  var body: some View {
    ZStack {
      Color.appBackground.ignoresSafeArea()
      VStack(alignment: .leading, spacing:17) {
        Spacer()
        addressView
        scheduleView
        paymentView
        transportTypesView
        FuelStackView(for: station)
        routeButton
      }
      .padding(.horizontal,12)
    }
  }
  
  // MARK:  - Auxilary UI Components
  
  private var addressView: some View {
    HStack(spacing:8) {
      Image(.marker)
        .foregroundStyle(.green)
      Text("street_label")
        .foregroundStyle(.gray)
      Text(station.street)
        .lineLimit(2)
        .multilineTextAlignment(.leading)
    }
    .font(.footnote)
    .fontWeight(.medium)
  }
  
  private var scheduleView: some View {
    HStack(spacing:8) {
      Image(.clock)
        .foregroundStyle(.green)
      Text("schedule_label")
        .foregroundStyle(.gray)
      Text(station.schedule)
    }
    .font(.footnote)
    .fontWeight(.medium)
  }
  
  private var paymentView: some View {
    HStack(spacing:8) {
      Image(.money)
        .foregroundStyle(.green)
      Text("payment_label")
        .foregroundStyle(.gray)
      Text("payment_methods")
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
        type == mapViewModel.selectedTransport ? .green : .black
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
          pouring: .green
        )
      }
    }
  }
}

#Preview {
  MapItemView(station: MockData.station)
    .environmentObject(MapViewModel.previewMode)
}
