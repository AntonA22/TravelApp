import SwiftUI

struct StoriesView: View {
    @Environment(\.dismiss) private var dismiss

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
        ZStack {
            Color.black
                .ignoresSafeArea()

            TabView(selection: $selectedStoryID) {
                ForEach(stories) { story in
                    StoryPageView(
                        story: story,
                        pageIndex: Binding(
                            get: { pageIndexByStoryID[story.id, default: 0] },
                            set: { pageIndexByStoryID[story.id] = $0 }
                        ),
                        advance: { advance(from: story) },
                        close: { dismiss() }
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
        }
        .background(.black)
    }

    private var currentStory: TravelStory? {
        stories.first { $0.id == selectedStoryID }
    }

    private func advance(from story: TravelStory) {
        let currentPageIndex = pageIndexByStoryID[story.id, default: 0]
        if currentPageIndex < story.pages.count - 1 {
            pageIndexByStoryID[story.id] = currentPageIndex + 1
            return
        }

        guard let storyIndex = stories.firstIndex(of: story),
              storyIndex < stories.count - 1
        else {
            dismiss()
            return
        }

        selectedStoryID = stories[storyIndex + 1].id
    }
}

private struct StoryPageView: View {
    let story: TravelStory
    @Binding var pageIndex: Int
    let advance: () -> Void
    let close: () -> Void

    private var page: TravelStoryPage {
        story.pages[pageIndex]
    }

    var body: some View {
        ZStack(alignment: .topTrailing) {
            ZStack {
                Image(page.imageName)
                    .resizable()
                    .scaledToFill()

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

                        Text(page.subtitle)
                            .font(.system(size: 20))
                            .lineSpacing(4)
                            .lineLimit(4)
                    }
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 24)
                    .padding(.bottom, 58)
                }
            }
            .clipShape(RoundedRectangle(cornerRadius: 40))
            .contentShape(RoundedRectangle(cornerRadius: 40))
            .onTapGesture {
                advance()
            }

            Button(action: close) {
                Image(systemName: "xmark")
                    .font(.system(size: 17, weight: .bold))
                    .foregroundStyle(.white)
                    .frame(width: 34, height: 34)
                    .background(.black.opacity(0.35), in: Circle())
            }
            .padding(.top, 58)
            .padding(.trailing, 14)
            .accessibilityLabel("Закрыть")
        }
        .padding(.horizontal, 16)
        .padding(.top, 34)
        .padding(.bottom, 28)
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
