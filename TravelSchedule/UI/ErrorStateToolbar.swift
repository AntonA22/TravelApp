import SwiftUI

struct ErrorStateToolbar: ToolbarContent {
    var body: some ToolbarContent {
        ToolbarItem(placement: .topBarTrailing) {
            Menu {
                NavigationLink("Ошибка сервера") {
                    AppErrorView(kind: .server)
                }

                NavigationLink("Нет интернета") {
                    AppErrorView(kind: .network)
                }
            } label: {
                Image(systemName: "exclamationmark.triangle")
            }
            .tint(Color.travelPrimary)
            .accessibilityLabel("Состояния ошибок")
        }
    }
}
