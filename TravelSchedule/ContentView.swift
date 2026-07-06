import SwiftUI

struct ContentView: View {
    @StateObject private var stationDataStore = StationDataStore()
    @AppStorage("isDarkThemeEnabled") private var isDarkThemeEnabled = false
    @State private var isSplashVisible = true

    var body: some View {
        ZStack {
            if isSplashVisible {
                SplashView()
                    .transition(.opacity)
            } else {
                RootTabView(isDarkThemeEnabled: $isDarkThemeEnabled)
                    .environmentObject(stationDataStore)
                    .transition(.opacity)
            }
        }
        .preferredColorScheme(isDarkThemeEnabled ? .dark : .light)
        .animation(.easeInOut(duration: 0.35), value: isSplashVisible)
        .task {
            try? await Task.sleep(nanoseconds: 1_200_000_000)
            isSplashVisible = false
        }
    }
}

#Preview {
    ContentView()
}
