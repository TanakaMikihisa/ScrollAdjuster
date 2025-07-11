import SwiftUI

// スクロール位置を保存する PreferenceKey
struct ScrollOffset: Equatable {
    var minX: CGFloat
    var maxX: CGFloat
}
