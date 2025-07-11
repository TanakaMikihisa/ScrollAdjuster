import SwiftUI


struct ScrollWatcher {
    var scrollOffset: CGFloat = 0 // スクロール位置を監視
    var scrollStopTask: DispatchWorkItem?  //遅延アクション管理
    var scrollViewWidth : CGFloat = 0
}
