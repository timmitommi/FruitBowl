import XCTest
@testable import MuseumArtCollectionAPI

final class MuseumArtCollectionAPITests: XCTestCase {
    func testExample() async throws {
        let client = APIClient()
        
        let result = try? await client.getAvailableArtObjects(filteredByDepartmentsIds: 1,2,3)
        let result2 = try? await client.getArtObject(withId: 437133)
        let result3 = try? await client.getAvailableDepartments()
        // XCTest Documentation
        // https://developer.apple.com/documentation/xctest

        // Defining Test Cases and Test Methods
        // https://developer.apple.com/documentation/xctest/defining_test_cases_and_test_methods
    }
}
