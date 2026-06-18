import Foundation
import OpenAPIRuntime
import OpenAPIURLSession

typealias Copyright = Components.Schemas.CopyrightResponse

protocol CopyrightServiceProtocol {
    func getCopyright() async throws -> Copyright
}

/// Сервис «Копирайт Яндекс Расписаний» — `/v3.0/copyright/`.
final class CopyrightService: BaseAPIService, CopyrightServiceProtocol {
    func getCopyright() async throws -> Copyright {
        let response = try await client.getCopyright(query: .init())
        return try response.ok.body.json
    }
}
