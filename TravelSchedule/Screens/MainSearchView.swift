import SwiftUI

struct MainSearchView: View {
    @State private var fromPoint: RoutePoint?
    @State private var toPoint: RoutePoint?
    @State private var activePicker: PickerDirection?

    private var isSearchReady: Bool {
        fromPoint != nil && toPoint != nil
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 28) {
                routeSelector

                if isSearchReady {
                    HStack {
                        Spacer()

                        NavigationLink {
                            CarriersView(
                                fromPoint: fromPoint,
                                toPoint: toPoint
                            )
                        } label: {
                            Text("Найти")
                                .font(.system(size: 17, weight: .bold))
                                .frame(width: 150, height: 60)
                        }
                        .buttonStyle(PrimaryButtonStyle())

                        Spacer()
                    }
                }

                Spacer(minLength: 32)
            }
            .padding(.horizontal, 16)
            .padding(.top, 48)
        }
        .background(Color.travelBackground)
        .navigationTitle("")
        .fullScreenCover(item: $activePicker) { direction in
            CitySelectionView(direction: direction) { point in
                switch direction {
                case .from:
                    fromPoint = point
                case .to:
                    toPoint = point
                }
                activePicker = nil
            }
        }
    }

    private var routeSelector: some View {
        HStack(spacing: 16) {
            VStack(spacing: 0) {
                RoutePointButton(
                    title: "Откуда",
                    point: fromPoint
                ) {
                    activePicker = .from
                }

                Divider()
                    .padding(.leading, 16)

                RoutePointButton(
                    title: "Куда",
                    point: toPoint
                ) {
                    activePicker = .to
                }
            }
            .background(Color.travelField)
            .clipShape(RoundedRectangle(cornerRadius: 20))

            Button {
                swap(&fromPoint, &toPoint)
            } label: {
                Image(systemName: "arrow.up.arrow.down")
                    .font(.system(size: 20, weight: .bold))
                    .frame(width: 44, height: 44)
            }
            .buttonStyle(CircleIconButtonStyle())
            .accessibilityLabel("Поменять местами")
        }
        .padding(16)
        .background(Color.travelBlue)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .padding(.top, 44)
    }
}

private struct RoutePointButton: View {
    let title: String
    let point: RoutePoint?
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(title)
                        .font(.system(size: 17))
                        .foregroundStyle(point == nil ? Color.travelPlaceholder : Color.travelPrimary)

                    if let point {
                        Text("\(point.city) (\(point.station.name))")
                            .font(.system(size: 17))
                            .foregroundStyle(Color.travelPrimary)
                            .lineLimit(1)
                    }
                }

                Spacer()
            }
            .frame(minHeight: 48)
            .padding(.horizontal, 16)
            .padding(.vertical, 10)
        }
        .buttonStyle(.plain)
    }
}
