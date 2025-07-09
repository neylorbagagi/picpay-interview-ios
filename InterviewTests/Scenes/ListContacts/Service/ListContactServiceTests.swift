import XCTest
@testable import Interview

class ListContactServiceTests: XCTestCase {
    var service: ListContactService!
    var mockSession: MockURLSession!

    override func setUp() {
        super.setUp()
        mockSession = MockURLSession()
        service = ListContactService(session: mockSession)
    }

    override func tearDown() {
        service = nil
        mockSession = nil
        super.tearDown()
    }

    func testFetchContacts_Success() {
        mockSession.data = mockData
        let expectation = self.expectation(description: "Contacts fetched")
        service.fetchContacts { contacts, error in
            XCTAssertNotNil(contacts)
            XCTAssertNil(error)
            XCTAssertEqual(contacts?.count, 1)
            XCTAssertEqual(contacts?.first?.name, "Beyonce")
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1, handler: nil)
    }

    func testFetchContacts_DecodingError() {
        mockSession.data = "invalid json".data(using: .utf8)
        let expectation = self.expectation(description: "Decoding error")
        service.fetchContacts { contacts, error in
            XCTAssertNil(contacts)
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1, handler: nil)
    }

    func testFetchContacts_NetworkError() {
        mockSession.data = nil
        mockSession.error = NSError(domain: "Test", code: 1, userInfo: nil)
        let expectation = self.expectation(description: "Network error")
        service.fetchContacts { contacts, error in
            XCTAssertNil(contacts)
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1, handler: nil)
    }
}


var mockData: Data? {
    """
    [{
      "id": 2,
      "name": "Beyonce",
      "photoURL": "https://api.adorable.io/avatars/285/a2.png"
    }]
    """.data(using: .utf8)
}
