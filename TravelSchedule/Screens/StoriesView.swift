import SwiftUI

struct StoriesView: View {
    @Environment(\.dismiss) private var dismiss

    private let autoAdvanceTimer = Timer.publish(every: 5, on: .main, in: .common).autoconnect()

    let stories: [TravelStory]
    let initialStory: TravelStory
    let markViewed: (TravelStory) -> Void

    @State private var selectedStoryID: String
    @State private var pageIndexByStoryID: [String: Int] = [:]

    init(
        stories: [TravelStory],
        initialStory: TravelStory,
        markViewed: @escaping (TravelStory) -> Void
    ) {
        self.stories = stories
        self.initialStory = initialStory
        self.markViewed = markViewed
        _selectedStoryID = State(initialValue: initialStory.id)
    }

    var body: some View {
        GeometryReader { proxy in
            ZStack(alignment: .topTrailing) {
            Color.black
                .ignoresSafeArea()

            TabView(selection: $selectedStoryID) {
                ForEach(stories) { story in
                    StoryPageView(
                        availableSize: proxy.size,
                        story: story,
                        pageIndex: Binding(
                            get: { pageIndexByStoryID[story.id, default: 0] },
                            set: { pageIndexByStoryID[story.id] = $0 }
                        ),
                        advance: { advance(from: story, shouldLoop: false) }
                    )
                    .tag(story.id)
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .ignoresSafeArea()
            .onAppear {
                if let story = currentStory {
                    markViewed(story)
                }
            }
            .onChange(of: selectedStoryID) { _, _ in
                if let story = currentStory {
                    markViewed(story)
                }
            }

            closeButton
                .padding(.top, max(proxy.safeAreaInsets.top + 14, 58))
                .padding(.trailing, 30)
                .zIndex(2)
            }
        }
        .background(.black)
        .onReceive(autoAdvanceTimer) { _ in
            guard let currentStory else { return }
            advance(from: currentStory, shouldLoop: true)
        }
    }

    private var currentStory: TravelStory? {
        stories.first { $0.id == selectedStoryID }
    }

    private var closeButton: some View {
        Button {
            dismiss()
        } label: {
            Image(systemName: "xmark")
                .font(.system(size: 17, weight: .bold))
                .foregroundStyle(.white)
                .frame(width: 34, height: 34)
                .background(.black.opacity(0.45), in: Circle())
        }
        .buttonStyle(.plain)
        .accessibilityLabel("Закрыть")
    }

    private func advance(from story: TravelStory, shouldLoop: Bool) {
        let currentPageIndex = pageIndexByStoryID[story.id, default: 0]
        if currentPageIndex < story.pages.count - 1 {
            pageIndexByStoryID[story.id] = currentPageIndex + 1
            return
        }

        guard let storyIndex = stories.firstIndex(of: story),
              storyIndex < stories.count - 1
        else {
            if shouldLoop, let firstStory = stories.first {
                pageIndexByStoryID[firstStory.id] = 0
                selectedStoryID = firstStory.id
                return
            }
            dismiss()
            return
        }

        pageIndexByStoryID[stories[storyIndex + 1].id] = 0
        selectedStoryID = stories[storyIndex + 1].id
    }
}

private struct StoryPageView: View {
    let availableSize: CGSize
    let story: TravelStory
    @Binding var pageIndex: Int
    let advance: () -> Void

    private var page: TravelStoryPage {
        story.pages[pageIndex]
    }

    private var cardWidth: CGFloat {
        max(0, availableSize.width - 32)
    }

    private var cardHeight: CGFloat {
        max(0, availableSize.height - 62)
    }

    var body: some View {
        ZStack {
            Image(page.imageName)
                .resizable()
                .scaledToFill()
                .frame(width: cardWidth, height: cardHeight)

            LinearGradient(
                colors: [
                    Color.black.opacity(0.20),
                    Color.black.opacity(0.04),
                    Color.black.opacity(0.86)
                ],
                startPoint: .top,
                endPoint: .bottom
            )

            VStack(spacing: 0) {
                progressBar
                    .padding(.top, 34)
                    .padding(.horizontal, 12)

                Spacer()

                VStack(alignment: .leading, spacing: 16) {
                    Text(page.title)
                        .font(.system(size: 34, weight: .bold))
                        .lineLimit(2)
                        .minimumScaleFactor(0.75)

                    Text(page.subtitle)
                        .font(.system(size: 20))
                        .lineSpacing(4)
                        .lineLimit(4)
                        .minimumScaleFactor(0.8)
                }
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 24)
                .padding(.bottom, 58)
            }
        }
        .frame(width: cardWidth, height: cardHeight)
        .clipShape(RoundedRectangle(cornerRadius: 40))
        .contentShape(RoundedRectangle(cornerRadius: 40))
        .position(x: availableSize.width / 2, y: availableSize.height / 2)
        .onTapGesture {
            advance()
        }
    }

    private var progressBar: some View {
        HStack(spacing: 6) {
            ForEach(story.pages.indices, id: \.self) { index in
                Capsule()
                    .fill(index <= pageIndex ? Color.white : Color.white.opacity(0.35))
                    .frame(height: 4)
            }
        }
    }
}
