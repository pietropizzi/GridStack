import GridStack
import SwiftUI

struct ContentView : View {
    var body: some View {
        GridStack(minCellWidth: 75, spacing: 2, numItems: 15) { index, cellWidth in
            Text("\(index)")
                .foregroundColor(.white)
                .frame(width: cellWidth, height: cellWidth * 0.66)
                .background(Color.blue)
        }
    }
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
