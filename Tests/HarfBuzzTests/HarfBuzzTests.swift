import XCTest
@testable import HarfBuzz

final class HarfBuzzTests: XCTestCase {
    /// Checks that generation exposes the installed library's major version.
    ///
    /// Every supported HarfBuzz release has a positive major version.
    func testVersionMajor() {
        XCTAssertGreaterThan(versionMajor, 0)
    }

#if HARFBUZZ_14_5
    /// Checks that the default work budget uses HarfBuzz's sentinel value.
    ///
    /// The signed minimum requests the library's finite default budget.
    func testDefaultWorkBudget() {
        XCTAssertEqual(budgetDefault, Int64.min)
    }
#endif
}
