//
//  View+Extension.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 14.05.2025.
//

import SwiftUI

extension View {
  
  // MARK: Custom List Style
  
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
  
  // MARK: Custom Input Field Style
  
  func customInputFieldStyle() -> some View {
    self
      .padding()
      .frame(minHeight: 55)
      .overlay {
        RoundedRectangle(cornerRadius: 15)
          .inset(by: 0.5)
          .stroke(.gray.opacity(0.5), lineWidth: 1)
      }
  }
}
