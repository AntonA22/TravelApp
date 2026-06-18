import Foundation
import OpenAPIRuntime
import OpenAPIURLSession

typealias CarrierInfo = Components.Schemas.CarrierResponse

protocol CarrierServiceProtocol {
    func getCarrierInfo(code: String) async throws -> CarrierInfo
}

/// Сервис «Информация о перевозчике» — `/v3.0/carrier/`.
final class CarrierService: BaseAPIService, CarrierServiceProtocol {
    func getCarrierInfo(code: String) async throws -> CarrierInfo {
        let response = try await client.getCarrierInfo(
            query: .init(code: code)
        )
        return try response.ok.body.json
    }
}
