import SwiftUI

struct RootTabView: View {
    @Binding var isDarkThemeEnabled: Bool

    var body: some View {
        TabView {
            NavigationStack {
                MainSearchView()
            }
            .tabItem {
                Image(systemName: "magnifyingglass")
                Text("Поиск")
            }

            NavigationStack {
                SettingsView(isDarkThemeEnabled: $isDarkThemeEnabled)
            }
            .tabItem {
                Image(systemName: "gearshape.fill")
                Text("Настройки")
            }
        }
        .tint(Color.travelBlue)
    }
}
