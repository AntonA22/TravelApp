import Foundation
import OpenAPIRuntime
import OpenAPIURLSession

typealias AllStations = Components.Schemas.AllStationsResponse

protocol AllStationsServiceProtocol {
    func getAllStations() async throws -> AllStations
}

/// Сервис «Список всех станций» — `/v3.0/stations_list/`.
///
/// Особенность: несмотря на документацию, сервер отдаёт ответ с типом
/// `text/html`, а не `application/json`. Поэтому тело приходит как
/// последовательность байтов (`HTTPBody`), которую мы собираем в `Data`
/// и декодируем вручную через `JSONDecoder`.
final class AllStationsService: BaseAPIService, AllStationsServiceProtocol {
    func getAllStations() async throws -> AllStations {
        let response = try await client.getAllStations(query: .init())
        let responseBody = try response.ok.body.html

        let limit = 50 * 1024 * 1024 // 50 МБ
        let fullData = try await Data(collecting: responseBody, upTo: limit)

        let allStations = try JSONDecoder().decode(AllStations.self, from: fullData)
        return allStations
    }
}
