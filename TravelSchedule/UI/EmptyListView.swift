import SwiftUI

struct EmptyListView: View {
    let title: String

    var body: some View {
        Text(title)
            .font(.system(size: 24, weight: .bold))
            .foregroundStyle(Color.travelPrimary)
            .multilineTextAlignment(.center)
            .frame(maxWidth: .infinity, minHeight: 220)
    }
}
