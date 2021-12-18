//
//  APIServiceTest.swift
//  Rick and MortyTests
//
//  Created by Chris Park on 12/18/21.
//

import XCTest
@testable import Rick_and_Morty

class APIServiceTest: XCTestCase {
    
    func testFetchDataShouldFail() {
        let expectation = expectation(description: "Fetched data unsuccessfully!")
        let apiService = MockFailureAPIService()
        Task {
            do {
                let _ : Characters = try await apiService.fetchData(for: RMEndpoint.characters(page: 1))
                XCTFail("Fetching data succeeded.")
            } catch {
                expectation.fulfill()
            }
        }
        
        self.waitForExpectations(timeout: 3)
    }

    func testFetchImageShouldFail() {
        let expectation = expectation(description: "Fetched data unsuccessfully!")
        let apiService = MockFailureAPIService()
        Task {
            do {
                let _ : UIImage = try await apiService.fetchImage(for: RMEndpoint.avatar(component: ""))
                XCTFail("Fetching data succeeded.")
            } catch {
                expectation.fulfill()
            }
        }
        
        self.waitForExpectations(timeout: 3)
    }
    
    func testFetchDataShouldSucceed() {
        let expectation = expectation(description: "Fetched data successfully!")
        let apiService = MockSuccessAPIService()
        Task {
            do {
                let _ : Characters = try await apiService.fetchData(for: RMEndpoint.characters(page: 1))
                expectation.fulfill()
            } catch {
                XCTFail("Fetching data failed.")
            }
        }
        
        self.waitForExpectations(timeout: 3)
    }
    
    func testFetchImageShouldSucceed() {
        let expectation = expectation(description: "Fetched data unsuccessfully!")
        let apiService = MockSuccessAPIService()
        Task {
            do {
                let _ : UIImage = try await apiService.fetchImage(for: RMEndpoint.avatar(component: ""))
                expectation.fulfill()
            } catch {
                XCTFail("Fetching data failed.")
            }
        }
        
        self.waitForExpectations(timeout: 3)
    }
}

enum MockAPIError: Error {
    case failedToFetchData
    case failedToFetchImage
}

class MockFailureAPIService: APIService {
    func fetchData<T>(for endPoint: Endpoint) async throws -> T where T : Decodable {
        throw MockAPIError.failedToFetchData
    }
    
    func fetchImage(for endpoint: Endpoint) async throws -> UIImage {
        throw MockAPIError.failedToFetchImage
    }
}

class MockSuccessAPIService: APIService {
    func fetchData<T>(for endPoint: Endpoint) async throws -> T where T : Decodable {
        let characters: Characters = Characters(characters: [Character(name: "", status: "", species: "", locationURL: LocationURL(url: ""), imageURL: "")])
        return characters as! T
    }
    
    func fetchImage(for endpoint: Endpoint) async throws -> UIImage {
        return UIImage()
    }
}
