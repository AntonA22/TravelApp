import Foundation
import OpenAPIRuntime
import OpenAPIURLSession

/// Фабрика, собирающая сгенерированный `Client` поверх `URLSession`-транспорта.
/// API-ключ добавляется ко всем запросам через `AuthMiddleware`.
enum APIClientFactory {
    static func makeClient() -> Client {
        Client(
            serverURL: Constants.baseURL,
            transport: URLSessionTransport(),
            middlewares: [AuthMiddleware(apikey: Constants.apiKey)]
        )
    }
}
