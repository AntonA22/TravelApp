import SwiftUI

struct CarrierDetailView: View {
    @Environment(\.dismiss) private var dismiss

    let carrier: Carrier

    var body: some View {
        VStack(spacing: 0) {
            header

            VStack(alignment: .leading, spacing: 30) {
                logo
                    .frame(maxWidth: .infinity)
                    .padding(.top, 56)

                Text(carrier.legalName)
                    .font(.system(size: 24, weight: .bold))
                    .foregroundStyle(Color.travelPrimary)

                contactBlock(title: "E-mail", value: carrier.email)

                contactBlock(title: "Телефон", value: carrier.phone)

                Spacer()
            }
            .padding(.horizontal, 16)
        }
        .background(Color.travelBackground)
        .navigationBarBackButtonHidden(true)
        .toolbar(.hidden, for: .navigationBar)
    }

    private var header: some View {
        HStack(spacing: 0) {
            Button {
                dismiss()
            } label: {
                Image(systemName: "chevron.left")
                    .font(.system(size: 24, weight: .semibold))
                    .foregroundStyle(Color.travelPrimary)
                    .frame(width: 44, height: 44, alignment: .leading)
            }
            .accessibilityLabel("Назад")

            Text("Информация о перевозчике")
                .font(.system(size: 17, weight: .bold))
                .foregroundStyle(Color.travelPrimary)
                .frame(maxWidth: .infinity)

            Color.clear
                .frame(width: 44, height: 44)
        }
        .padding(.horizontal, 16)
        .padding(.top, 12)
    }

    private var logo: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.travelField)

            Text(carrier.logoText)
                .font(.system(size: 86, weight: .black))
                .foregroundStyle(carrier.logoColor)
        }
        .frame(width: 180, height: 104)
    }

    private func contactBlock(title: String, value: String) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .font(.system(size: 17))
                .foregroundStyle(Color.travelPrimary)

            Text(value)
                .font(.system(size: 12))
                .foregroundStyle(Color.travelBlue)
        }
    }
}
