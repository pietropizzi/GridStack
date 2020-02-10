# 📱GridStack

A flexible grid layout view for SwiftUI.

![Release](https://img.shields.io/github/v/release/pietropizzi/GridStack?color=blue&sort=semver)

![macOS](https://img.shields.io/badge/supports-macOS-success)
![iOS](https://img.shields.io/badge/supports-iOS-success)
![tvOS](https://img.shields.io/badge/supports-tvOS-success)
![watchOS](https://img.shields.io/badge/supports-watchOS-success)

Simply pass the minimum width the grid cells should have and the spacing between them and it will adjust depending on the available width.

So writing this:

```swift
GridStack(minCellWidth: 300, spacing: 2, numItems: 15) { index, cellWidth in
    Text("\(index)")
        .foregroundColor(.white)
        .frame(width: cellWidth, height: cellWidth * 0.66)
        .background(Color.blue)
}
```

will give you you this:

<img width="1378" alt="Screenshot 2019-07-14 at 14 07 02" src="https://user-images.githubusercontent.com/410305/61183368-de58f380-a640-11e9-9025-1c174c040c6e.png">


It also adjusts correctly when the device is rotated:

![rotation](https://user-images.githubusercontent.com/410305/61183421-6dfea200-a641-11e9-99c8-3f24cc35d1d8.gif)

## 🗺 Usage Overview

Think of the grid in the way of what is the **minimum width** you want your cells to be. That way it is easy to adjust to any available space. The only other size you need to provide is the **spacing** between the cells.

To actually create the grid we need to know the **numbers of items**. Then the **content** view builder will be called with each **index** and the **cellWidth** that you can then pass to the frame of whatever you want to display inside.

## 👕 Sizing your views inside the cells

The grid will wrap each item you provide with in a view that gets the **cellWidth** set as **width**. No height constraint is put on the cell. That is so that you can size your content as flexible as possible. Here are just a couple of examples what you can do.

### Height defined by content

```swift
GridStack(...) { index, cellWidth in
    Text("\(index)")
        // Don't pass any height to the frame to let it be defined by it's content
        .frame(width: cellWidth)
}
```

### Square items

```swift
GridStack(...) { index, cellWidth in
    Text("\(index)")
        // Pass the cellWidth as width and height to the frame to make a square
        .frame(width: cellWidth, height: cellWidth)
}
```

### Aspect Ratio items

```swift
GridStack(...) { index, cellWidth in
    Text("\(index)")
        // Pass the cellWidth as width and a portion of it as height to get a certain aspect ratio
        .frame(width: cellWidth, height: cellWidth * 0.75)
}
```

## ✍️ Signature

```swift
GridStack(
    minCellWidth: Length,
    spacing: Length,
    numItems: Int,
    alignment: HorizontalAlignment = .leading,
    content: (index: Int, cellWidth: CGFloat) -> Void
)
```

## 📝 Mentions

I created `GridStack` by taking ideas from [FlowStack](https://github.com/johnsusek/FlowStack) by [John Susek](https://github.com/johnsusek).
