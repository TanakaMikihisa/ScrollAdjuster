import SwiftUI
/// **スクロールオフセットを取得するためのPreferenceKey**
struct ScrollOffsetKey: PreferenceKey {
    
    static var defaultValue: CGFloat = 0
    
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}
