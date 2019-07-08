//
//  GridStack.swift
//
//  Created by Peter Minarik on 07.07.19.
//  Copyright © 2019 Peter Minarik. All rights reserved.
//

import SwiftUI

@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
public struct GridStack<Content>: View where Content: View {
    private let minCellWidth: Length
    private let spacing: Length
    private let numItems: Int
    private let alignment: HorizontalAlignment
    private let content: (Int, CGFloat) -> Content
    
    public init(
        minCellWidth: Length,
        spacing: Length,
        numItems: Int,
        alignment: HorizontalAlignment = .leading,
        @ViewBuilder content: @escaping (Int, CGFloat) -> Content
    ) {
        self.minCellWidth = minCellWidth
        self.spacing = spacing
        self.numItems = numItems
        self.alignment = alignment
        self.content = content
    }
    
    var items: [Int] {
        Array(0..<numItems).map { $0 }
    }
    
    public var body: some View {
        GeometryReader { geometry in
            InnerGrid(
                minCellWidth: self.minCellWidth,
                spacing: self.spacing,
                items: self.items,
                alignment: self.alignment,
                content: self.content,
                availableWidth: geometry.size.width
            )
        }
    }
}

private struct InnerGrid<Content>: View where Content: View {
    
    private let spacing: Length
    private let chunkedItems: [[Int]]
    private let alignment: HorizontalAlignment
    private let content: (Int, CGFloat) -> Content
    private let cellWidth: Length
    
    init(
        minCellWidth: Length,
        spacing: Length,
        items: [Int],
        alignment: HorizontalAlignment = .leading,
        @ViewBuilder content: @escaping (Int, CGFloat) -> Content,
                     availableWidth: Length
        ) {
        self.spacing = spacing
        self.alignment = alignment
        self.content = content
        
        let columnCount = max(
            1, Int((availableWidth - spacing) / (minCellWidth + spacing))
        )
        let remainingWidth = availableWidth - (Length((columnCount + 1)) * spacing)
        
        cellWidth = remainingWidth / Length(columnCount)
        chunkedItems = items.chunked(into: columnCount)
    }
    
    var body : some View {
        ScrollView(.vertical) {
            // Rows
            VStack(alignment: alignment, spacing: spacing) {
                ForEach(chunkedItems.identified(by: \.self)) { row in
                    HStack(spacing: self.spacing) {
                        // Items In Row
                        ForEach(row) { item in
                            // Pass the index and the cell width to the content
                            self.content(item, self.cellWidth)
                                .frame(width: self.cellWidth)
                        }
                    }.padding(.horizontal, self.spacing)
                }
            }.padding(.top, spacing)
        }
    }
}
