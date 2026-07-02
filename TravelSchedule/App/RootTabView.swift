import SwiftUI

struct RootTabView: View {
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
                SettingsView()
            }
            .tabItem {
                Image(systemName: "gearshape.fill")
                Text("Настройки")
            }
        }
        .tint(Color.travelBlue)
    }
}
