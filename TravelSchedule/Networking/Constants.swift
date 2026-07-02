import Foundation

/// Глобальные константы сетевого слоя приложения «Расписание Путешествий».
enum Constants {
    /// Базовый адрес API Яндекс Расписаний.
    static let baseURL = URL(string: "https://api.rasp.yandex.net")!

    /// Ваш API-ключ Яндекс Расписаний.
    /// Получить его можно в кабинете разработчика: https://yandex.ru/dev/rasp/
    /// ⚠️ Подставьте сюда собственный ключ перед запуском.
    static let apiKey = ""

    static var isAPIKeyConfigured: Bool {
        !apiKey.isEmpty && apiKey != "YOUR_YANDEX_RASP_API_KEY"
    }
}
