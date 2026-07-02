import SwiftUI

struct ErrorStateMenuButton: View {
    var body: some View {
        Menu {
            NavigationLink("Ошибка сервера") {
                AppErrorView(kind: .server)
            }

            NavigationLink("Нет интернета") {
                AppErrorView(kind: .network)
            }
        } label: {
            Image(systemName: "exclamationmark.triangle")
                .font(.system(size: 18, weight: .semibold))
                .frame(width: 44, height: 44)
        }
        .tint(Color.travelPrimary)
        .accessibilityLabel("Состояния ошибок")
    }
}

struct ErrorStateToolbar: ToolbarContent {
    var body: some ToolbarContent {
        ToolbarItem(placement: .topBarTrailing) {
            ErrorStateMenuButton()
        }
    }
}
