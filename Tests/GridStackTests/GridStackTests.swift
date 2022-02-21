import XCTest
@testable import GridStack

final class GridCalculatorTests: XCTestCase {
    
    private var subject: GridCalculator!
    
    override func setUp() {
        super.setUp()
        subject = GridCalculator()
    }
    
    override func tearDown() {
        subject = nil
        super.tearDown()
    }
    
    func test_threeCellsFitExactlyWithoutSpacing() {
        let (columnWidth, columnCount) = subject.calculate(
            availableWidth: 300,
            minimumCellWidth: 100,
            cellSpacing: 0
        )
        
        XCTAssertEqual(columnWidth, 100)
        XCTAssertEqual(columnCount, 3)
    }
    
    func test_threeCellsFitExactlyWithSpacing() {
        let (columnWidth, columnCount) = subject.calculate(
            availableWidth: 340,
            minimumCellWidth: 100,
            cellSpacing: 10
        )
        XCTAssertEqual(columnWidth, 100)
        XCTAssertEqual(columnCount, 3)
    }
    
    func test_threeCellsJustDontFit() {
        let (columnWidth, columnCount) = subject.calculate(
            availableWidth: 339,
            minimumCellWidth: 100,
            cellSpacing: 10
        )
        XCTAssertEqual(columnWidth, 154.5)
        XCTAssertEqual(columnCount, 2)
    }
    
    func test_minimumCellWidthIsWiderThanAvailableSpace_givesOneColumn() {
        let (columnWidth, columnCount) = subject.calculate(
            availableWidth: 300,
            minimumCellWidth: 310,
            cellSpacing: 0
        )
        
        XCTAssertEqual(columnCount, 1)
        XCTAssertEqual(columnWidth, 300)
    }
    
    func test_minimumCellWidthWithSpacingIsWiderThanAvailableSpace_givesOneColumn() {
        let (columnWidth, columnCount) = subject.calculate(
            availableWidth: 300,
            minimumCellWidth: 290,
            cellSpacing: 10
        )
        
        XCTAssertEqual(columnCount, 1)
        XCTAssertEqual(columnWidth, 280)
    }
    
    func test_zeroAvailableWidth_givesZeroColumnsAndColumnWidth() {
        let (columnWidth, columnCount) = subject.calculate(
            availableWidth: 0,
            minimumCellWidth: 290,
            cellSpacing: 10
        )
        
        XCTAssertEqual(columnCount, 0)
        XCTAssertEqual(columnWidth, 0)
    }
    
    static var allTests = [
        ("test_cellsFitExactlyWithoutSpacing", test_threeCellsFitExactlyWithoutSpacing),
        ("test_cellsFitExactlyWithSpacing", test_threeCellsFitExactlyWithSpacing),
        ("test_threeCellsJustDontFit", test_threeCellsJustDontFit),
        ("test_minimumCellWidthIsWiderThanAvailableSpace_givesOneColumn", test_minimumCellWidthIsWiderThanAvailableSpace_givesOneColumn),
        ("test_minimumCellWidthWithSpacingIsWiderThanAvailableSpace_givesOneColumn", test_minimumCellWidthWithSpacingIsWiderThanAvailableSpace_givesOneColumn),
        ("test_zeroAvailableWidth_givesZeroColumnsAndColumnWidth", test_zeroAvailableWidth_givesZeroColumnsAndColumnWidth)
    ]
}
