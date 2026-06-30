import SwiftUI

struct CarrierFilterView: View {
    @Environment(\.dismiss) private var dismiss

    @Binding var filter: CarrierFilter

    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                VStack(alignment: .leading, spacing: 28) {
                    backButton

                    Text("Время отправления")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundStyle(Color.travelPrimary)

                    VStack(spacing: 28) {
                        ForEach(DeparturePeriod.allCases) { period in
                            FilterCheckRow(
                                title: period.title,
                                isSelected: filter.periods.contains(period)
                            ) {
                                toggle(period)
                            }
                        }
                    }

                    Text("Показывать варианты с пересадками")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundStyle(Color.travelPrimary)
                        .padding(.top, 10)

                    VStack(spacing: 28) {
                        ForEach(TransferOption.allCases) { option in
                            FilterRadioRow(
                                title: option.title,
                                isSelected: filter.transferOption == option
                            ) {
                                filter.transferOption = option
                            }
                        }
                    }
                }
                .padding(.horizontal, 16)
                .padding(.top, 12)
                .padding(.bottom, 24)
            }

            if filter.isReadyToApply {
                Button {
                    dismiss()
                } label: {
                    Text("Применить")
                        .font(.system(size: 17, weight: .bold))
                        .frame(maxWidth: .infinity)
                        .frame(height: 60)
                }
                .buttonStyle(PrimaryButtonStyle())
                .padding(.horizontal, 16)
                .padding(.bottom, 16)
            }
        }
        .background(Color.travelBackground)
        .navigationBarBackButtonHidden(true)
        .toolbar(.hidden, for: .navigationBar)
    }

    private var backButton: some View {
        Button {
            dismiss()
        } label: {
            Image(systemName: "chevron.left")
                .font(.system(size: 24, weight: .semibold))
                .foregroundStyle(Color.travelPrimary)
        }
        .frame(width: 44, height: 44, alignment: .leading)
    }

    private func toggle(_ period: DeparturePeriod) {
        if filter.periods.contains(period) {
            filter.periods.remove(period)
        } else {
            filter.periods.insert(period)
        }
    }
}

private struct FilterCheckRow: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack {
                Text(title)
                    .font(.system(size: 17))
                    .foregroundStyle(Color.travelPrimary)

                Spacer()

                Image(systemName: isSelected ? "checkmark.square.fill" : "square")
                    .font(.system(size: 24, weight: .semibold))
                    .foregroundStyle(Color.travelPrimary)
            }
            .frame(height: 48)
        }
        .buttonStyle(.plain)
    }
}

private struct FilterRadioRow: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack {
                Text(title)
                    .font(.system(size: 17))
                    .foregroundStyle(Color.travelPrimary)

                Spacer()

                Image(systemName: isSelected ? "largecircle.fill.circle" : "circle")
                    .font(.system(size: 24, weight: .semibold))
                    .foregroundStyle(Color.travelPrimary)
            }
            .frame(height: 48)
        }
        .buttonStyle(.plain)
    }
}
