//
//  GetPhotoInfoUseCaseImplTests.swift
//  SPProbaFeladat
//
//  Created by Kormos Ádám on 2025. 09. 28..
//


import XCTest
@testable import SPProbaFeladat

final class GetPhotoInfoUseCaseImplTests: XCTestCase {

    private final class MockFlickrRepository: FlickrRepository {
        var stubbedResult: FlickrPhotoInfo?
        var stubbedError: Error?

        private(set) var receivedPhotoId: String?
        private(set) var receivedSecret: String?

        func photoInfo(photoId: String, secret: String) async throws -> FlickrPhotoInfo {
            receivedPhotoId = photoId
            receivedSecret = secret

            if let stubbedError {
                throw stubbedError
            }
            if let stubbedResult {
                return stubbedResult
            }
            throw CustomError(message: "No stubbed result")
        }

        func searchPhotos(text: String, page: Int, perPage: Int) async throws -> FlickrSearchResult {
            throw CustomError(message: "not used in test")
        }
    }

    func testExecute_ReturnsPhotoInfo_WhenRepositorySucceeds() async throws {
        // Given
        let mockRepo = MockFlickrRepository()
        let expectedInfo = FlickrPhotoInfo(id: "123", server: "server", secret: "secret")
        mockRepo.stubbedResult = expectedInfo
        let sut = await GetPhotoInfoUseCaseImpl(repository: mockRepo)

        // When
        let result = try await sut.execute(photoId: "123", secret: "sec")

        // Then
        let id = await result.id
        XCTAssertEqual(id, "123")
        XCTAssertEqual(mockRepo.receivedPhotoId, "123")
        XCTAssertEqual(mockRepo.receivedSecret, "sec")
    }

    func testExecute_ThrowsError_WhenRepositoryFails() async {
        // Given
        enum TestError: Error { case network }
        let mockRepo = MockFlickrRepository()
        mockRepo.stubbedError = TestError.network
        let sut = await GetPhotoInfoUseCaseImpl(repository: mockRepo)

        // When / Then
        do {
            _ = try await sut.execute(photoId: "999", secret: "oops")
            XCTFail("Expected error to be thrown")
        } catch let error as TestError {
            XCTAssertEqual(error, .network)
        } catch {
            XCTFail("Unexpected error type: \(error)")
        }
    }
}
