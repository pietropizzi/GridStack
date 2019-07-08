import SwiftUI

struct GridCalculator {
    typealias GridDefinition = (
        columnWidth: Length,
        columnCount: Int
    )
    
    func calculate(
        availableWidth: Length,
        minimumCellWidth: Length,
        cellSpacing: Length
    ) -> GridDefinition {
        /**
         * 1. Subtract the cell spacing once from all the available width
         * 2. Add the cell spacing to each cell Width
         * 3. See how many fit and round that down (by producing an `Int`)
         */
        let columnsThatFit = Int((availableWidth - cellSpacing) / (minimumCellWidth + cellSpacing))
        let columnCount = max(1, columnsThatFit)
        let remainingWidth = availableWidth - totalSpacingFor(columnCount: columnCount, cellSpacing: cellSpacing)
        
        return (
            columnWidth: remainingWidth / Length(columnCount),
            columnCount: columnCount
        )
    }
    
    private func totalSpacingFor(columnCount: Int, cellSpacing: Length) -> Length {
        // There is a total of `columnCount + 1` spacers
        return Length((columnCount + 1)) * cellSpacing
    }
}
