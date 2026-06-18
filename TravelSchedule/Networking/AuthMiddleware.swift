import Foundation
import HTTPTypes
import OpenAPIRuntime

/// Middleware, добавляющий параметр `apikey` ко всем исходящим запросам.
///
/// Благодаря ему сервисы не знают про API-ключ — авторизация настраивается
/// в одном месте, при создании клиента.
struct AuthMiddleware: ClientMiddleware {
    private let apikey: String

    init(apikey: String) {
        self.apikey = apikey
    }

    func intercept(
        _ request: HTTPRequest,
        body: HTTPBody?,
        baseURL: URL,
        operationID: String,
        next: @Sendable (HTTPRequest, HTTPBody?, URL) async throws -> (HTTPResponse, HTTPBody?)
    ) async throws -> (HTTPResponse, HTTPBody?) {
        var request = request
        let path = request.path ?? ""
        let separator = path.contains("?") ? "&" : "?"
        request.path = path + "\(separator)apikey=\(apikey)"
        return try await next(request, body, baseURL)
    }
}
