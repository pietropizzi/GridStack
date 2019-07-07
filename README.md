# 📱GridStack

A flexible grid layout view for SwiftUI.

Simply pass the minimum width the grid cells should have and the spacing between them and it will adjust depending on the given space.

So writing this:

```swift
GridStack(minCellWidth: 320, spacing: 15, numItems: counterData.count) { index, cellWidth in
    CounterCard(counter: counterData[index])
      .frame(width: cellWidth)
}
```

will give you you this:

![](https://user-images.githubusercontent.com/410305/60769888-6f761a80-a0d5-11e9-83a1-6feb461be288.png)

It also adjusts correctly when the device is rotated:

![](https://user-images.githubusercontent.com/410305/60769889-743ace80-a0d5-11e9-81ad-c438da9e5b34.gif)

## Usage

Thinks of the grid in the way of what is the **minimum width** you want your cells to be. That way it is easy to adjust to any available space. The only other thing you needed to calculate the layout is the **spacing** between the cells.

To actually create the grid we need to know the **numbers of items**. Then the **content** view builder will be called with each index and the **cellWidth** that you can then pass to the frame of whatever you want to display inside.

Here is full initialzer signature:

```swift
GridStack(
    minCellWidth: Length,
    spacing: Length,
    numItems: Int,
    alignment: HorizontalAlignment = .leading,
    content: (Int, CGFloat) -> _
)
```

## Mentions

I created `GridStack` by taking ideas from [FlowStack](https://github.com/johnsusek/FlowStack) by [John Susek](https://github.com/johnsusek).
