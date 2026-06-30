import Foundation

@MainActor
final class StationDataStore: ObservableObject {
    @Published private(set) var cities: [City] = DemoData.cities
    @Published private(set) var isLoading = false
    @Published private(set) var errorMessage: String?

    private var didLoad = false

    func loadCitiesIfNeeded() async {
        guard !didLoad else { return }
        didLoad = true

        guard Constants.isAPIKeyConfigured else {
            errorMessage = "API-ключ не задан"
            return
        }

        isLoading = true
        defer { isLoading = false }

        do {
            let service = AllStationsService(client: APIClientFactory.makeClient())
            let response = try await service.getAllStations()
            let apiCities = Self.makeCities(from: response)

            if !apiCities.isEmpty {
                cities = apiCities
                errorMessage = nil
            } else {
                errorMessage = "API вернул пустой список"
            }
        } catch {
            errorMessage = error.localizedDescription
        }
    }

    private static func makeCities(from response: AllStations) -> [City] {
        let cities = response.countries?
            .flatMap { $0.regions ?? [] }
            .flatMap { $0.settlements ?? [] }
            .compactMap { settlement -> City? in
                guard let cityName = settlement.title?.trimmingCharacters(in: .whitespacesAndNewlines),
                      !cityName.isEmpty else {
                    return nil
                }

                let stations = (settlement.stations ?? [])
                    .compactMap { station -> TravelStation? in
                        guard let title = station.title?.trimmingCharacters(in: .whitespacesAndNewlines),
                              !title.isEmpty else {
                            return nil
                        }

                        let code = station.code?.trimmingCharacters(in: .whitespacesAndNewlines)
                        return TravelStation(
                            name: title,
                            code: code?.isEmpty == false ? code : nil
                        )
                    }

                guard !stations.isEmpty else { return nil }

                return City(
                    name: cityName,
                    stations: stations.uniqued().sortedByName()
                )
            } ?? []

        return Array(
            Dictionary(grouping: cities, by: \.name)
                .map { name, duplicateCities in
                    let stations = duplicateCities
                        .flatMap(\.stations)
                        .uniqued()
                        .sortedByName()
                    return City(name: name, stations: stations)
                }
        )
        .sorted { $0.name.localizedCaseInsensitiveCompare($1.name) == .orderedAscending }
    }
}

extension Array where Element: Hashable {
    func uniqued() -> [Element] {
        var seen = Set<Element>()
        return filter { seen.insert($0).inserted }
    }
}

private extension Array where Element == TravelStation {
    func sortedByName() -> [TravelStation] {
        sorted { $0.name.localizedCaseInsensitiveCompare($1.name) == .orderedAscending }
    }
}
