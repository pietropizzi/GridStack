//
//  GridStack.swift
//
//  Created by Peter Minarik on 07.07.19.
//  Copyright © 2019 Peter Minarik. All rights reserved.
//

import SwiftUI

public struct GridStack<Content>: View where Content: View {
    var minCellWidth: Length
    var spacing: Length
    var numItems: Int
    var alignment: HorizontalAlignment = .leading
    var content: (Int, CGFloat) -> Content
    
    var body: some View {
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
    
    var minCellWidth: Length
    var spacing: Length
    var numItems: Int
    var alignment: HorizontalAlignment
    var content: (Int, CGFloat) -> Content
    var availableWidth: Length
    
    var cellWidth: Length {
        let remainingWidth = availableWidth - (Length((columns + 1)) * spacing)
        return remainingWidth / Length(columns)
    }
    
    var columns: Int {
        max(
            Int((availableWidth - spacing) / (minCellWidth + spacing)),
            1
        )
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
