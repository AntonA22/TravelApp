import SwiftUI

struct PlaceholderView: View {
    let title: String

    var body: some View {
        VStack(spacing: 18) {
            Text(title)
                .font(.system(size: 24, weight: .bold))
                .foregroundStyle(Color.travelPrimary)

            NavigationLink("Ошибка сервера") {
                AppErrorView(kind: .server)
            }
            .buttonStyle(SecondaryButtonStyle())

            NavigationLink("Нет интернета") {
                AppErrorView(kind: .network)
            }
            .buttonStyle(SecondaryButtonStyle())
        }
        .padding(16)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.travelBackground)
        .navigationTitle(title)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ErrorStateToolbar()
        }
    }
}
