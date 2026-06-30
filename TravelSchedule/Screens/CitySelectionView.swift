import SwiftUI

struct CitySelectionView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var stationDataStore: StationDataStore

    let direction: PickerDirection
    let onSelect: (RoutePoint) -> Void

    @State private var searchText = ""

    private var filteredCities: [City] {
        guard !searchText.isEmpty else { return stationDataStore.cities }
        return stationDataStore.cities.filter {
            $0.name.localizedCaseInsensitiveContains(searchText)
        }
    }

    var body: some View {
        NavigationStack {
            List {
                if stationDataStore.isLoading {
                    ProgressView()
                        .frame(maxWidth: .infinity, minHeight: 220)
                        .listRowSeparator(.hidden)
                } else if filteredCities.isEmpty {
                    EmptyListView(title: "Город не найден")
                        .listRowSeparator(.hidden)
                } else {
                    ForEach(filteredCities) { city in
                        NavigationLink {
                            StationSelectionView(city: city, onSelect: onSelect)
                        } label: {
                            Text(city.name)
                                .font(.system(size: 17, weight: .regular))
                                .foregroundStyle(Color.travelPrimary)
                                .frame(height: 40)
                        }
                    }
                }
            }
            .listStyle(.plain)
            .scrollContentBackground(.hidden)
            .background(Color.travelBackground)
            .navigationTitle(direction.cityTitle)
            .navigationBarTitleDisplayMode(.inline)
            .searchable(text: $searchText, prompt: "Введите запрос")
            .task {
                await stationDataStore.loadCitiesIfNeeded()
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 18, weight: .semibold))
                    }
                    .tint(Color.travelPrimary)
                    .accessibilityLabel("Назад")
                }
            }
        }
    }
}
