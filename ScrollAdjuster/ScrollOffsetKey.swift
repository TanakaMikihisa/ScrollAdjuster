import SwiftUI

/// **スクロールオフセットを取得するためのPreferenceKey**
struct ScrollOffsetKey: PreferenceKey {
    static var defaultValue: ScrollOffset = ScrollOffset(minX: 0, maxX: 0)
    
    static func reduce(value: inout ScrollOffset, nextValue: () -> ScrollOffset) {
        value = nextValue()
    }
}
