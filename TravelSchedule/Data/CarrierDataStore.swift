import Foundation
import SwiftUI

@MainActor
final class CarrierDataStore: ObservableObject {
    @Published private(set) var carriers: [Carrier] = []
    @Published private(set) var isLoading = false
    @Published private(set) var errorMessage: String?

    func loadCarriers(from fromPoint: RoutePoint?, to toPoint: RoutePoint?) async {
        guard let fromCode = fromPoint?.station.code,
              let toCode = toPoint?.station.code,
              !fromCode.isEmpty,
              !toCode.isEmpty else {
            carriers = DemoData.carriers
            errorMessage = nil
            return
        }

        guard Constants.isAPIKeyConfigured else {
            carriers = DemoData.carriers
            errorMessage = "API-ключ не задан"
            return
        }

        isLoading = true
        defer { isLoading = false }

        do {
            let service = ScheduleBetweenStationsService(client: APIClientFactory.makeClient())
            let schedule = try await service.getSchedule(from: fromCode, to: toCode)
            let apiCarriers = Self.makeCarriers(from: schedule)

            carriers = apiCarriers
            errorMessage = nil
        } catch {
            carriers = DemoData.carriers
            errorMessage = error.localizedDescription
        }
    }

    private static func makeCarriers(from schedule: Segments) -> [Carrier] {
        (schedule.segments ?? []).compactMap { segment in
            guard let departure = segment.departure,
                  let arrival = segment.arrival else {
                return nil
            }

            let name = segment.thread?.carrier?.title?.nilIfBlank
                ?? segment.thread?.title?.nilIfBlank
                ?? "Перевозчик"
            let hasTransfer = segment.thread?.title?.localizedCaseInsensitiveContains("пересад") == true

            return Carrier(
                name: name,
                date: makeDateTitle(from: departure),
                departure: makeTimeTitle(from: departure),
                arrival: makeTimeTitle(from: arrival),
                duration: makeDurationTitle(seconds: segment.duration),
                period: DeparturePeriod(date: departure),
                hasTransfer: hasTransfer,
                logoText: String(name.prefix(1)).uppercased(),
                logoColor: .red,
                transferTitle: hasTransfer ? "С пересадкой" : nil
            )
        }
    }

    private static func makeTimeTitle(from date: Date) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ru_RU")
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: date)
    }

    private static func makeDateTitle(from date: Date) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ru_RU")
        formatter.dateFormat = "d MMMM"
        return formatter.string(from: date)
    }

    private static func makeDurationTitle(seconds: Int?) -> String {
        guard let seconds else { return "" }

        let hours = seconds / 3_600
        let minutes = (seconds % 3_600) / 60

        if minutes == 0 {
            return "\(hours) ч"
        }

        return "\(hours) ч \(minutes) м"
    }
}

private extension DeparturePeriod {
    init(date: Date) {
        let hour = Calendar.current.component(.hour, from: date)

        switch hour {
        case 6..<12:
            self = .morning
        case 12..<18:
            self = .day
        case 18..<24:
            self = .evening
        default:
            self = .night
        }
    }
}

private extension String {
    var nilIfBlank: String? {
        let value = trimmingCharacters(in: .whitespacesAndNewlines)
        return value.isEmpty ? nil : value
    }
}
