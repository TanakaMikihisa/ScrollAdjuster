import SwiftUI

struct ContentView: View {
    let ITEMS = ["🍎","🍊","🍇","🍌","🍉","🍐","🍒"]
    let ITEM_SPACE : CGFloat = 70  //アイテム間のスペース
    let ITEM_WIDTH : CGFloat = 100  //アイテムの幅
    @State var centerIndex : Int = 0  //中央に表示するアイテムのインデックス
    @State var scrollStopTask: DispatchWorkItem?  //遅延アクション管理
    var body: some View {
        GeometryReader{ geometry in
            
            VStack{
                Text(centerIndex.description)
                
                ScrollViewReader { proxy in
                    ScrollView(.horizontal,showsIndicators: false) {
                        LazyHStack(spacing:ITEM_SPACE){
                            ForEach(Array(ITEMS.enumerated()), id: \.offset) { index , item in
                                ZStack{
                                    Rectangle()
                                        .frame(width: ITEM_WIDTH, height: 100)
                                        .cornerRadius(12)
                                        .foregroundColor(Color(.systemGray6))
                                    Text(item)
                                }
                            }
                        }  //LazyStack終点
                        .overlay(
                            GeometryReader { proxy in
                                Color.clear.preference(
                                    key: ScrollOffsetKey.self,
                                    value: proxy.frame(in: .global).minX
                                )
                            }
                        )
                    }
                    .onPreferenceChange(ScrollOffsetKey.self) { value in  //スクロール管理
                        detectScrollEnd(value, proxy: proxy, geometry: geometry)
                    }
                }
            }
        }
    }
    // スクロールの変化を検知し、一定時間後にスクロール終了を判定
    private func detectScrollEnd(_ newOffset: CGFloat,proxy:ScrollViewProxy, geometry : GeometryProxy) {
        let moveIndex = calculateIndex(newOffset, geometry: geometry)

        
        // すでにスケジュールされたタスクをキャンセル
        scrollStopTask?.cancel()
        
        
        // 新しいタスクを作成して 0.2 秒後にスクロール停止と判定
        let task = DispatchWorkItem {
            Task{
                print("📌 スクロールが終了しました！\(moveIndex)")
                withAnimation {
                    proxy.scrollTo(moveIndex, anchor: .center)
                }
            }
        }
        
        scrollStopTask = task
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: task)
        
    }
    
    private func calculateIndex(_ newOffset: CGFloat, geometry : GeometryProxy) -> Int {
        
        let adjustedOffset = -newOffset + geometry.size.width/2  //画面中央から右向きに計測したスクロール量
        
        let double_index : Double = ((adjustedOffset) / (ITEM_SPACE + ITEM_WIDTH))
        
        
        centerIndex = Int(double_index)
        return Int(double_index)
        
    }
    
    
}

#Preview {
    ContentView()
}








