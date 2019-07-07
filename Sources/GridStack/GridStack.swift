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
    
    public var body: some View {
        GeometryReader { geometry in
            InnerGrid(
                minCellWidth: self.minCellWidth,
                spacing: self.spacing,
                numItems: self.numItems,
                alignment: self.alignment,
                content: self.content,
                availableWidth: geometry.size.width
            )
        }
    }
}

private struct InnerGrid<Content>: View where Content: View {
    
    private let minCellWidth: Length
    private let spacing: Length
    private let numItems: Int
    private let alignment: HorizontalAlignment
    private let content: (Int, CGFloat) -> Content
    private let cellWidth: Length
    private let columns: Int
    
    init(
        minCellWidth: Length,
        spacing: Length,
        numItems: Int,
        alignment: HorizontalAlignment = .leading,
        @ViewBuilder content: @escaping (Int, CGFloat) -> Content,
        availableWidth: Length
    ) {
        self.minCellWidth = minCellWidth
        self.spacing = spacing
        self.numItems = numItems
        self.alignment = alignment
        self.content = content
        
        let columns = max(
            1, Int((availableWidth - spacing) / (minCellWidth + spacing))
        )
        let remainingWidth = availableWidth - (Length((columns + 1)) * spacing)
        
        self.columns = columns
        cellWidth = remainingWidth / Length(columns)
    }
    
    var body : some View {
        ScrollView(.vertical) {
            // Rows
            VStack(alignment: self.alignment, spacing: spacing) {
                ForEach(0 ..< (self.numItems / self.columns)) { row in
                    HStack(spacing: self.spacing) {
                        // Items In Row
                        ForEach(0 ..< self.columns) { column in
                            self.content(
                                // Pass the index to the content
                                (row * self.columns) + column,
                                // Pass the column width to the content
                                self.cellWidth
                            )
                                // Size the content to frame to fill the column
                                .frame(width: self.cellWidth)
                        }
                    }.padding(.horizontal, self.spacing)
                }
                
                // Last row
                // HStacks are our columns
                HStack(spacing: spacing) {
                    ForEach(0 ..< (self.numItems % self.columns)) { column in
                        self.content(
                            // Pass the index to the content
                            ((self.numItems / self.columns) * self.columns) + column,
                            // Pass the column width to the content
                            self.cellWidth
                        )
                            // Size the content to frame to fill the column
                            .frame(width: self.cellWidth)
                    }
                }.padding(.horizontal, self.spacing)
            }.padding(.top, spacing)
        }
    }
}
