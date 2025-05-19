//
//  View+Extension.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 14.05.2025.
//

import SwiftUI

extension View {
  
  // MARK: Custom List Setup
  
  func customListStyle(
    rowHeight: CGFloat = 0,
    rowSpacing: CGFloat = 0,
    sectionSpacing: CGFloat = 0,
    scrollDisabled: Bool = false,
    indicators: ScrollIndicatorVisibility = .hidden,
    height: CGFloat? = nil,
    shadow: CGFloat = 0
  ) -> some View {
    self
      .listStyle(.insetGrouped)
      .environment(\.defaultMinListRowHeight, rowHeight)
      .listRowSpacing(rowSpacing)
      .listSectionSpacing(sectionSpacing)
      .scrollContentBackground(.hidden)
      .scrollDisabled(scrollDisabled)
      .scrollIndicators(indicators)
      .frame(height: height)
      .shadow(radius: shadow)
  }
}
