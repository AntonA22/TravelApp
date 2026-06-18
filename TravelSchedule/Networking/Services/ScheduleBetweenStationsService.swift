import Foundation
import OpenAPIRuntime
import OpenAPIURLSession

typealias Segments = Components.Schemas.Segments

protocol ScheduleBetweenStationsServiceProtocol {
    func getSchedule(from: String, to: String) async throws -> Segments
}

/// Сервис «Расписание рейсов между станциями» — `/v3.0/search/`.
final class ScheduleBetweenStationsService: BaseAPIService, ScheduleBetweenStationsServiceProtocol {
    func getSchedule(from: String, to: String) async throws -> Segments {
        let response = try await client.getSchedualBetweenStations(
            query: .init(from: from, to: to)
        )
        return try response.ok.body.json
    }
}
