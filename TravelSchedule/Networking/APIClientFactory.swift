import Foundation
import OpenAPIRuntime
import OpenAPIURLSession

/// Фабрика, собирающая сгенерированный `Client` поверх `URLSession`-транспорта.
enum APIClientFactory {
    /// Готовый клиент API Яндекс Расписаний.
    static func makeClient() -> Client {
        Client(
            serverURL: Constants.baseURL,
            transport: URLSessionTransport()
        )
    }
}
