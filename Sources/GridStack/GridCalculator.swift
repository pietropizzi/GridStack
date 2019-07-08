import SwiftUI


struct GridCalculator {
    private let availableWidth: Length
    private let minimumCellWidth: Length
    private let cellSpacing: Length
    
    init(
        availableWidth: Length,
        minimumCellWidth: Length,
        cellSpacing: Length
    ) {
        self.availableWidth = availableWidth
        self.minimumCellWidth = minimumCellWidth
        self.cellSpacing = cellSpacing
    }
    
    var cellWidth: Length {
        let remainingWidth: Length = availableWidth - totalSpacingFor(columnCount: columnCount)
        
        return remainingWidth / Length(columnCount)
    }
    
    var columnCount: Int {
        return max(1, columnsThatFit)
    }
    
    private func totalSpacingFor(columnCount: Int) -> Length {
        // There is a total of `columnCount + 1` spacers
        return Length((columnCount + 1)) * cellSpacing
    }
    
    private var columnsThatFit: Int {
        /**
         * 1. Subtract the cell spacing once from all the available width
         * 2. Add the cell spacing to each cell Width
         * 3. See how many fit and round that down (by producing an `Int`)
         */
        Int((availableWidth - cellSpacing) / (minimumCellWidth + cellSpacing))
    }
}
