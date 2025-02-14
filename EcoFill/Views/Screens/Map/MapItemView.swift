import SwiftUI

struct MapItemView: View {
  
  let station: Station
  @EnvironmentObject var stationVM: StationViewModel
  
  var body: some View {
    ZStack {
      Color.primaryBackground.ignoresSafeArea(.all)
      VStack(alignment: .leading, spacing: 20) {
        Spacer()
        addressLabel
        scheduleLabel
        paymentLabel
        FuelStackView(for: station)
        routeButton
      }
      .padding(.horizontal, 15)
    }
  }
  
  private var addressLabel: some View {
    HStack(spacing: 10) {
      Image(.marker)
        .foregroundStyle(.accent)
      Text(station.street)
        .font(.system(size: 14))
        .fontWeight(.medium)
        .fontDesign(.monospaced)
        .foregroundStyle(.gray)
        .lineLimit(2)
        .multilineTextAlignment(.leading)
    }
  }
  
  private var scheduleLabel: some View {
    HStack(spacing: 10) {
      Image(.clock)
        .foregroundStyle(.accent)
      Text(station.schedule)
        .font(.system(size: 14))
        .fontWeight(.medium)
        .fontDesign(.monospaced)
        .foregroundStyle(.gray)
    }
  }
  
  private var paymentLabel: some View {
    HStack(spacing:0) {
      Image(.money)
        .foregroundStyle(.accent)
      Text("Payment:")
        .foregroundStyle(.gray)
        .padding(.leading, 10)
      Text("Cash, ApplePay.")
        .padding(.leading, 5)
        .foregroundStyle(.primaryReversed)
    }
    .font(.system(size: 14))
    .fontWeight(.medium)
    .fontDesign(.monospaced)
  }
  
  @ViewBuilder
  private var routeButton: some View {
    if stationVM.isShownRoute {
      Button {
        stationVM.isShownRoute = false
      } label: {
        Text("Hide Route")
          .font(.callout).bold()
          .fontDesign(.monospaced)
          .foregroundStyle(.white)
          .frame(maxWidth: .infinity)
          .padding(.vertical, 8)
      }
      .buttonStyle(.borderedProminent)
      .tint(.red)
      .shadow(radius: 3)
    } else {
      Button {
        stationVM.isShownRoute = true
      } label: {
        Text("Show Route")
          .font(.callout).bold()
          .fontDesign(.monospaced)
          .foregroundStyle(.white)
          .frame(maxWidth: .infinity)
          .padding(.vertical, 8)
      }
      .buttonStyle(.borderedProminent)
      .tint(.accent)
      .shadow(radius: 2)
    }
  }
}

#Preview {
  MapItemView(station: .mockStation)
    .environmentObject( StationViewModel() )
}
