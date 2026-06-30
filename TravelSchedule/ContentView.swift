import SwiftUI

struct ContentView: View {
    @StateObject private var stationDataStore = StationDataStore()
    @State private var isSplashVisible = true

    var body: some View {
        ZStack {
            if isSplashVisible {
                SplashView()
                    .transition(.opacity)
            } else {
                RootTabView()
                    .environmentObject(stationDataStore)
                    .transition(.opacity)
            }
        }
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
