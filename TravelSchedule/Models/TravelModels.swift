import SwiftUI

struct RoutePoint: Hashable {
    let city: String
    let station: TravelStation
}

struct City: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let stations: [TravelStation]
}

struct TravelStation: Identifiable, Hashable {
    let name: String
    let code: String?

    var id: String {
        code ?? name
    }
}

struct Carrier: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let legalName: String
    let email: String
    let phone: String
    let date: String
    let departure: String
    let arrival: String
    let duration: String
    let period: DeparturePeriod
    let hasTransfer: Bool
    let logoText: String
    let logoColor: Color
    let transferTitle: String?
}

struct TravelStory: Identifiable, Hashable {
    let id: String
    let title: String
    let subtitle: String
    let imageName: String
    let accentColor: Color
    let pages: [TravelStoryPage]
}

struct TravelStoryPage: Identifiable, Hashable {
    let id: String
    let title: String
    let subtitle: String
    let imageName: String
    let accentColor: Color
}

struct CarrierFilter: Hashable {
    var periods = Set<DeparturePeriod>()
    var transferOption: TransferOption?

    var isReadyToApply: Bool {
        !periods.isEmpty && transferOption != nil
    }

    func matches(_ carrier: Carrier) -> Bool {
        let periodMatches = periods.isEmpty || periods.contains(carrier.period)
        let transferMatches = transferOption?.matches(carrier) ?? true
        return periodMatches && transferMatches
    }
}

enum PickerDirection: String, Identifiable {
    case from
    case to

    var id: String { rawValue }

    var cityTitle: String {
        "Выбор города"
    }
}

enum DeparturePeriod: String, CaseIterable, Identifiable {
    case morning
    case day
    case evening
    case night

    var id: String { rawValue }

    var title: String {
        switch self {
        case .morning:
            return "Утро 06:00 - 12:00"
        case .day:
            return "День 12:00 - 18:00"
        case .evening:
            return "Вечер 18:00 - 00:00"
        case .night:
            return "Ночь 00:00 - 06:00"
        }
    }
}

enum TransferOption: String, CaseIterable, Identifiable {
    case any
    case withoutTransfers

    var id: String { rawValue }

    var title: String {
        switch self {
        case .any:
            return "Да"
        case .withoutTransfers:
            return "Нет"
        }
    }

    func matches(_ carrier: Carrier) -> Bool {
        switch self {
        case .any:
            return true
        case .withoutTransfers:
            return !carrier.hasTransfer
        }
    }
}

enum AppErrorKind {
    case server
    case network

    var title: String {
        switch self {
        case .server:
            return "Ошибка сервера"
        case .network:
            return "Нет интернета"
        }
    }

    var imageName: String {
        switch self {
        case .server:
            return "ServerError"
        case .network:
            return "NoInternet"
        }
    }
}
