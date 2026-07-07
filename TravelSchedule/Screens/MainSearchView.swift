import SwiftUI

struct MainSearchView: View {
    @State private var fromPoint: RoutePoint?
    @State private var toPoint: RoutePoint?
    @State private var activePicker: PickerDirection?
    @State private var selectedStory: TravelStory?
    @State private var viewedStoryIDs = Set(["night", "city"])

    private var isSearchReady: Bool {
        fromPoint != nil && toPoint != nil
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 28) {
                storiesCollection

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
            .padding(.top, 24)
        }
        .background(Color.travelBackground)
        .navigationTitle("")
        .toolbar {
            ErrorStateToolbar()
        }
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
        .fullScreenCover(item: $selectedStory) { story in
            StoriesView(
                stories: DemoData.stories,
                initialStory: story
            ) { viewedStoryIDs.insert($0.id) }
        }
    }

    private var storiesCollection: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                ForEach(DemoData.stories) { story in
                    StoryPreviewButton(
                        story: story,
                        isViewed: viewedStoryIDs.contains(story.id)
                    ) {
                        viewedStoryIDs.insert(story.id)
                        selectedStory = story
                    }
                }
            }
            .padding(.horizontal, 16)
        }
        .padding(.horizontal, -16)
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
            .frame(height: 96)

            Button {
                swap(&fromPoint, &toPoint)
            } label: {
                Image(systemName: "arrow.up.arrow.down")
                    .font(.system(size: 18, weight: .bold))
                    .frame(width: 36, height: 36)
            }
            .buttonStyle(CircleIconButtonStyle())
            .accessibilityLabel("Поменять местами")
        }
        .frame(height: 128)
        .padding(.horizontal, 16)
        .background(Color.travelBlue)
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}

private struct StoryPreviewButton: View {
    let story: TravelStory
    let isViewed: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            ZStack(alignment: .bottomLeading) {
                Image(story.imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 92, height: 140)

                LinearGradient(
                    colors: [
                        Color.clear,
                        Color.black.opacity(0.72)
                    ],
                    startPoint: .center,
                    endPoint: .bottom
                )

                Text(story.title)
                    .font(.system(size: 12, weight: .regular))
                    .foregroundStyle(.white)
                    .lineLimit(3)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(8)
            }
            .frame(width: 92, height: 140)
            .opacity(isViewed ? 0.48 : 1)
            .overlay {
                RoundedRectangle(cornerRadius: 16)
                    .stroke(isViewed ? Color.clear : Color.travelBlue, lineWidth: 4)
            }
            .clipShape(RoundedRectangle(cornerRadius: 16))
        }
        .buttonStyle(.plain)
        .accessibilityLabel(story.title)
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
            .frame(height: 48)
            .padding(.horizontal, 16)
        }
        .buttonStyle(.plain)
    }
}
