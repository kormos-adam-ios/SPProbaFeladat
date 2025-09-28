//
//  SearchPhotosUseCaseImplTests.swift
//  SPProbaFeladat
//
//  Created by Kormos Ádám on 2025. 09. 27..
//


import XCTest
@testable import SPProbaFeladat

final class SearchPhotosUseCaseImplTests: XCTestCase {

    private final class MockFlickrRepository: FlickrRepository {
        var stubbedResult: FlickrSearchResult?
        var stubbedError: Error?

        private(set) var receivedText: String?
        private(set) var receivedPage: Int?
        private(set) var receivedPerPage: Int?

        func searchPhotos(text: String, page: Int, perPage: Int) async throws -> FlickrSearchResult {
            receivedText = text
            receivedPage = page
            receivedPerPage = perPage

            if let stubbedError { throw stubbedError }
            if let stubbedResult { return stubbedResult }

            return FlickrSearchResult(totalPages: 0, photos: [])
        }
        
        func photoInfo(photoId: String, secret: String) async throws -> FlickrPhotoInfo {
            throw CustomError(message: "not used in test")
        }
        
    }

    private func makeNonEmptyResult() -> FlickrSearchResult {
        let samplePhoto = FlickrPhoto(id: "1", server: "s", secret: "sec", page: 1)
        return FlickrSearchResult(totalPages: 1, photos: [samplePhoto])
    }

    func testExecute_ReturnsResult_WhenPhotosNotEmpty() async throws {
        // Given
        let repo = MockFlickrRepository()
        repo.stubbedResult = makeNonEmptyResult()
        let sut = await SearchPhotosUseCaseImpl(repository: repo)

        // When
        let result = try await sut.execute(text: "cats", page: 2, perPage: 40)

        // Then
        let hasPhotos = await !result.photos.isEmpty
        XCTAssertTrue(hasPhotos)
        XCTAssertEqual(repo.receivedText, "cats")
        XCTAssertEqual(repo.receivedPage, 2)
        XCTAssertEqual(repo.receivedPerPage, 40)
    }

    func testExecute_ThrowsCustomError_WhenPhotosEmpty() async {
        // Given
        let repo = MockFlickrRepository()
        repo.stubbedResult = FlickrSearchResult(totalPages: 1, photos: [])
        let sut = await SearchPhotosUseCaseImpl(repository: repo)

        // When / Then
        do {
            _ = try await sut.execute(text: "nothing", page: 1, perPage: 20)
            XCTFail("Expected to throw when photos are empty")
        } catch let error as CustomError {
            XCTAssertNotNil(error.errorDescription)
        } catch {
            XCTFail("Unexpected error type: \(error)")
        }
    }

    func testExecute_PropagatesRepositoryError() async {
        // Given
        enum RepoError: Error { case network }
        let repo = MockFlickrRepository()
        repo.stubbedError = RepoError.network
        let sut = await SearchPhotosUseCaseImpl(repository: repo)

        // When / Then
        do {
            _ = try await sut.execute(text: "dogs", page: 1, perPage: 20)
            XCTFail("Expected repository error to be thrown")
        } catch let error as RepoError {
            XCTAssertEqual(error, .network)
        } catch {
            XCTFail("Unexpected error type: \(error)")
        }
    }
}
