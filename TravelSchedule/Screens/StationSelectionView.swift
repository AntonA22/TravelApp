import SwiftUI

struct StationSelectionView: View {
    let city: City
    let onSelect: (RoutePoint) -> Void

    @State private var searchText = ""

    private var filteredStations: [TravelStation] {
        guard !searchText.isEmpty else { return city.stations }
        return city.stations.filter {
            $0.name.localizedCaseInsensitiveContains(searchText)
        }
    }

    var body: some View {
        List {
            if filteredStations.isEmpty {
                EmptyListView(title: "Станция не найдена")
                    .listRowSeparator(.hidden)
            } else {
                ForEach(filteredStations) { station in
                    Button {
                        onSelect(RoutePoint(city: city.name, station: station))
                    } label: {
                        HStack {
                            Text(station.name)
                                .font(.system(size: 17))
                                .foregroundStyle(Color.travelPrimary)
                            Spacer()
                            Image(systemName: "chevron.right")
                                .font(.system(size: 14, weight: .semibold))
                                .foregroundStyle(Color.travelSecondary)
                        }
                        .frame(height: 44)
                    }
                    .buttonStyle(.plain)
                }
            }
        }
        .listStyle(.plain)
        .scrollContentBackground(.hidden)
        .background(Color.travelBackground)
        .navigationTitle("Выбор станции")
        .navigationBarTitleDisplayMode(.inline)
        .searchable(text: $searchText, prompt: "Введите запрос")
    }
}
