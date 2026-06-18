import Foundation
import OpenAPIRuntime
import OpenAPIURLSession

typealias StationSchedule = Components.Schemas.ScheduleResponse

protocol StationScheduleServiceProtocol {
    func getStationSchedule(station: String) async throws -> StationSchedule
}

/// Сервис «Список рейсов по станции» — `/v3.0/schedule/`.
final class StationScheduleService: BaseAPIService, StationScheduleServiceProtocol {
    func getStationSchedule(station: String) async throws -> StationSchedule {
        let response = try await client.getStationSchedule(
            query: .init(station: station)
        )
        return try response.ok.body.json
    }
}
