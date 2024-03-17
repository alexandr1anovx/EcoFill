//
//  HotlineNumbers.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 27.02.2024.
//

import SwiftUI

struct ScrollableHotlineNumbers: View {
  
  var body: some View {
    ScrollView(.horizontal) {
      HStack(spacing: 10) {
        HotlineNumberCell(phoneNumber: "(050)-660-02-30")
        HotlineNumberCell(phoneNumber: "(099)-230-55-35")
        HotlineNumberCell(phoneNumber: "(067)-150-73-95")
      }
      .frame(height: 60)
    }
    .scrollIndicators(.hidden)
    .shadow(radius: 7)
  }
}

#Preview {
  ScrollableHotlineNumbers()
}
