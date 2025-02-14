import SwiftUI

struct StationListCell: View {
  
  @EnvironmentObject var stationVM: StationViewModel
  let station: Station
  
  private var isPresentedRoute: Bool {
    stationVM.selectedStation == station
    && stationVM.isShownRoute
  }
  
  var body: some View {
    VStack(alignment: .leading, spacing: 15) {
      addressLabel
      scheduleLabel
      paymentLabel
      routeConditionButton
    }
  }
  
  private var addressLabel: some View {
    HStack(spacing: 10) {
      Image(.marker)
        .foregroundStyle(.accent)
      Text(station.street)
        .font(.footnote)
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
        .font(.footnote)
        .fontWeight(.medium)
        .fontDesign(.monospaced)
        .foregroundStyle(.gray)
    }
  }
  
  private var paymentLabel: some View {
    HStack {
      Image(.money)
        .foregroundStyle(.accent)
      Text("Payment:")
        .foregroundStyle(.gray)
        .padding(.leading, 3)
      Text("Cash, ApplePay.")
        .foregroundStyle(.primaryReversed)
    }
    .font(.footnote)
    .fontWeight(.medium)
    .fontDesign(.monospaced)
  }
  
  @ViewBuilder
  private var routeConditionButton: some View {
    if !isPresentedRoute {
      Button {
        stationVM.isShownDetail = false
        stationVM.selectedStation = station
        stationVM.isShownRoute = true
      } label: {
        Text("Show Route")
          .font(.system(size: 14)).bold()
          .fontDesign(.monospaced)
          .foregroundStyle(.white)
          .frame(maxWidth: .infinity)
          .padding(.vertical, 4)
      }
      .buttonStyle(.borderedProminent)
      .tint(.accent)
      .shadow(radius: 3)
    } else {
      Button {
        stationVM.isShownDetail = false
        stationVM.selectedStation = nil
        stationVM.isShownRoute = false
      } label: {
        Text("Hide Route")
          .font(.system(size: 14)).bold()
          .fontDesign(.monospaced)
          .foregroundStyle(.white)
          .frame(maxWidth: .infinity)
          .padding(.vertical, 5)
      }
      .buttonStyle(.borderedProminent)
      .tint(.red)
      .shadow(radius: 3)
    }
  }
}

#Preview {
  StationListCell(station: .mockStation)
    .environmentObject( StationViewModel() )
}
