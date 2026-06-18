import Foundation
import OpenAPIRuntime
import OpenAPIURLSession

typealias RouteStations = Components.Schemas.ThreadStationsResponse

protocol RouteStationsServiceProtocol {
    func getRouteStations(uid: String) async throws -> RouteStations
}

/// Сервис «Список станций следования» (нитка) — `/v3.0/thread/`.
final class RouteStationsService: BaseAPIService, RouteStationsServiceProtocol {
    func getRouteStations(uid: String) async throws -> RouteStations {
        let response = try await client.getRouteStations(
            query: .init(uid: uid)
        )
        return try response.ok.body.json
    }
}
