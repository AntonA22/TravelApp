import Foundation
import OpenAPIRuntime
import OpenAPIURLSession

typealias NearestCity = Components.Schemas.NearestCityResponse

protocol NearestCityServiceProtocol {
    func getNearestCity(lat: Double, lng: Double) async throws -> NearestCity
}

/// Сервис «Ближайший город» — `/v3.0/nearest_settlement/`.
final class NearestCityService: BaseAPIService, NearestCityServiceProtocol {
    func getNearestCity(lat: Double, lng: Double) async throws -> NearestCity {
        let response = try await client.getNearestCity(
            query: .init(lat: lat, lng: lng)
        )
        return try response.ok.body.json
    }
}
