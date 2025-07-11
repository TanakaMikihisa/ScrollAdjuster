import SwiftUI



struct ScrollPosition<ContentID: Hashable>: Equatable {
  let id = UUID()
  let itemID: ContentID
  let anchor: UnitPoint
}
