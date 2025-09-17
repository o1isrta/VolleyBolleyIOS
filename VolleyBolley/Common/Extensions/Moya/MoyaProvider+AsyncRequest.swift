//
//  MoyaProvider+AsyncRequest.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 11.09.2025.
//

import Foundation
import Moya

extension MoyaProvider {

    /// Performs an asynchronous network request for the given Moya target and returns the raw `Response`.
    ///
    /// This helper bridges Moya's callback-based `request(_:completion:)` API into Swift Concurrency using
    /// `withCheckedThrowingContinuation`, allowing you to `await` the result.
    ///
    /// - Parameter target: The `Target` describing the API endpoint to request.
    /// - Returns: A `Response` containing the server’s raw data, HTTP status code, and headers.
    /// - Throws: A `MoyaError` if the request fails at the networking layer or is cancelled.
    /// - Important: This variant does not validate HTTP status codes or decode the payload. If you need
    ///   automatic status-code validation and JSON decoding, use the generic `asyncRequest(_:type:decoder:)`.
    /// - Note: The continuation resumes exactly once with either the successful `Response` or the encountered error.
    func asyncRequest(_ target: Target) async throws -> Response {
        try await withCheckedThrowingContinuation { continuation in
            self.request(target) { result in
                switch result {
                case .success(let response):
                    continuation.resume(returning: response)
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }

    /// Performs an asynchronous network request for the given Moya target and decodes the response body.
    ///
    /// This helper bridges Moya’s callback-based API into Swift Concurrency and adds:
    /// - HTTP status code validation (only 200..<300 is considered successful).
    /// - Automatic decoding of the response `Data` into a `Decodable` model using `JSONDecoder` (configurable).
    ///
    /// - Parameters:
    ///   - target: The `Target` describing the API endpoint to request.
    ///   - type: The expected `Decodable` model type to decode from the response body.
    ///   - decoder: A `JSONDecoder` used to decode the response. Defaults to a new `JSONDecoder()`.
    ///
    /// - Returns: An instance of `T` decoded from the response body.
    ///
    /// - Throws:
    ///   - `MoyaError` if the underlying network request fails or is cancelled.
    ///   - `MoyaError.statusCode` if the HTTP status code is not in the 200..<300 range.
    ///   - A decoding error (e.g. `DecodingError`) if the response body cannot be decoded into `T`.
    ///
    /// - Important: This method enforces a successful HTTP status code before attempting to decode.
    ///   If you need access to the raw `Response` (e.g., to inspect headers or non-2xx payloads),
    ///   use the non-generic `asyncRequest(_:)` variant instead.
    ///
    /// - Note: The provided `decoder` allows for custom strategies (e.g., date decoding, key decoding).
    func asyncRequest<T: Decodable>(
        _ target: Target,
        type: T.Type,
        decoder: JSONDecoder = JSONDecoder()
    ) async throws -> T {
        let response = try await asyncRequest(target)

        try validate(response)

        return try decoder.decode(T.self, from: response.data)
    }

    func asyncRequest(
        _ target: Target,
        decoder: JSONDecoder = JSONDecoder()
    ) async throws {
        let response = try await asyncRequest(target)

        try validate(response)
    }

    // MARK: - Private helpers
    private func validate(_ response: Response) throws {
        guard
            (200..<300).contains(response.statusCode)
        else {
            throw MoyaError.statusCode(response)
        }
    }
}
