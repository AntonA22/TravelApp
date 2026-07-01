import SwiftUI

struct CarriersView: View {
    @Environment(\.dismiss) private var dismiss

    let fromPoint: RoutePoint?
    let toPoint: RoutePoint?

    @State private var filter = CarrierFilter()
    @StateObject private var dataStore = CarrierDataStore()

    private var carriers: [Carrier] {
        dataStore.carriers.filter { carrier in
            filter.matches(carrier)
        }
    }

    var body: some View {
        VStack(spacing: 0) {
            header

            if dataStore.isLoading {
                ProgressView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else if carriers.isEmpty {
                EmptyListView(title: "Вариантов нет")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {
                ScrollView {
                    LazyVStack(spacing: 8) {
                        ForEach(carriers) { carrier in
                            NavigationLink {
                                PlaceholderView(title: "Карточка перевозчика")
                            } label: {
                                CarrierRow(carrier: carrier)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.bottom, 96)
                }
            }

            NavigationLink {
                CarrierFilterView(filter: $filter)
            } label: {
                Text("Уточнить время")
                    .font(.system(size: 17, weight: .bold))
                    .frame(maxWidth: .infinity)
                    .frame(height: 60)
            }
            .buttonStyle(PrimaryButtonStyle())
            .padding(.horizontal, 16)
            .padding(.bottom, 16)
            .background(Color.travelBackground)
        }
        .background(Color.travelBackground)
        .navigationBarBackButtonHidden(true)
        .toolbar(.hidden, for: .navigationBar)
        .task {
            await dataStore.loadCarriers(from: fromPoint, to: toPoint)
        }
    }

    private var header: some View {
        VStack(alignment: .leading, spacing: 26) {
            HStack {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 24, weight: .semibold))
                        .foregroundStyle(Color.travelPrimary)
                }
                .frame(width: 44, height: 44, alignment: .leading)
                .accessibilityLabel("Назад")

                Spacer()

                ErrorStateMenuButton()
            }

            Text(routeTitle)
                .font(.system(size: 24, weight: .bold))
                .foregroundStyle(Color.travelPrimary)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(.horizontal, 16)
        .padding(.top, 12)
        .padding(.bottom, 12)
    }

    private var routeTitle: String {
        guard let fromPoint, let toPoint else {
            return "Варианты"
        }
        return "\(fromPoint.city) (\(fromPoint.station.name)) -> \(toPoint.city) (\(toPoint.station.name))"
    }
}

private struct CarrierRow: View {
    let carrier: Carrier

    var body: some View {
        VStack(spacing: 18) {
            HStack(alignment: .top, spacing: 12) {
                ZStack {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(.white)

                    Text(carrier.logoText)
                        .font(.system(size: 18, weight: .black))
                        .foregroundStyle(carrier.logoColor)
                }
                .frame(width: 38, height: 38)

                VStack(alignment: .leading, spacing: 4) {
                    Text(carrier.name)
                        .font(.system(size: 17))
                        .foregroundStyle(Color.travelPrimary)

                    if let transferTitle = carrier.transferTitle {
                        Text(transferTitle)
                            .font(.system(size: 12))
                            .foregroundStyle(.red.opacity(0.7))
                    }
                }

                Spacer()

                Text(carrier.date)
                    .font(.system(size: 12))
                    .foregroundStyle(Color.travelPrimary)
            }

            HStack(spacing: 8) {
                Text(carrier.departure)

                Rectangle()
                    .fill(Color.travelSecondary.opacity(0.35))
                    .frame(height: 1)

                Text(carrier.duration)
                    .font(.system(size: 12))

                Rectangle()
                    .fill(Color.travelSecondary.opacity(0.35))
                    .frame(height: 1)

                Text(carrier.arrival)
            }
            .font(.system(size: 17))
            .foregroundStyle(Color.travelPrimary)
        }
        .padding(14)
        .background(Color.travelRouteCard)
        .clipShape(RoundedRectangle(cornerRadius: 24))
    }
}
