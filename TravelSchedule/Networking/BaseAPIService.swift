import Foundation

/// Базовый сетевой сервис: хранит общий `Client`.
/// Конкретные сервисы наследуются от него и содержат только бизнес-логику запроса.
class BaseAPIService {
    let client: Client

    init(client: Client) {
        self.client = client
    }
}
