import Foundation

enum City: String, Identifiable, CaseIterable {
    case kyiv = "Kyiv"
    case mykolaiv = "Mykolaiv"
    case odesa = "Odesa"
    
    var id: Self { self }
}
