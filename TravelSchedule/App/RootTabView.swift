import SwiftUI

struct RootTabView: View {
    @Binding var isDarkThemeEnabled: Bool
    @State private var selectedTab: AppTab = .search

    var body: some View {
        VStack(spacing: 0) {
            Group {
                switch selectedTab {
                case .search:
                    NavigationStack {
                        MainSearchView()
                    }
                case .settings:
                    NavigationStack {
                        SettingsView(isDarkThemeEnabled: $isDarkThemeEnabled)
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)

            AppTabBar(selectedTab: $selectedTab)
        }
        .background(Color.travelBackground)
    }
}

private enum AppTab {
    case search
    case settings
}

private struct AppTabBar: View {
    @Binding var selectedTab: AppTab

    var body: some View {
        VStack(spacing: 0) {
            Rectangle()
                .fill(Color.travelSeparator)
                .frame(height: 1)

            HStack(spacing: 0) {
                tabButton(
                    tab: .search,
                    systemName: "arrow.up.message.fill",
                    label: "Поиск"
                )

                tabButton(
                    tab: .settings,
                    systemName: "gearshape.fill",
                    label: "Настройки"
                )
            }
            .frame(height: 68)
            .padding(.bottom, 10)
            .background(Color.travelBackground)
        }
    }

    private func tabButton(
        tab: AppTab,
        systemName: String,
        label: String
    ) -> some View {
        Button {
            selectedTab = tab
        } label: {
            Image(systemName: systemName)
                .font(.system(size: 30, weight: .semibold))
                .foregroundStyle(selectedTab == tab ? Color.travelPrimary : Color.travelSecondary.opacity(0.45))
                .frame(maxWidth: .infinity)
                .frame(height: 58)
        }
        .buttonStyle(.plain)
        .accessibilityLabel(label)
    }
}
