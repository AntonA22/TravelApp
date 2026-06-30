import SwiftUI

struct AppErrorView: View {
    let kind: AppErrorKind

    var body: some View {
        VStack(spacing: 16) {
            Image(kind.imageName)
                .resizable()
                .scaledToFill()
                .clipShape(RoundedRectangle(cornerRadius: 32))
            .frame(width: 223, height: 223)

            Text(kind.title)
                .font(.system(size: 24, weight: .bold))
                .foregroundStyle(Color.travelPrimary)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.travelBackground)
        .navigationTitle(kind.title)
        .navigationBarTitleDisplayMode(.inline)
    }
}
