import SwiftUI

struct SettingsView: View {
    @Binding var isDarkThemeEnabled: Bool
    @State private var isAgreementPresented = false

    var body: some View {
        VStack(spacing: 0) {
            VStack(spacing: 0) {
                settingsRow
                    .padding(.top, 48)

                agreementLink
                    .padding(.top, 28)

                Spacer()

                footer
                    .padding(.bottom, 24)
            }
            .padding(.horizontal, 16)
        }
        .background(Color.travelBackground)
        .navigationTitle("")
        .toolbar(.hidden, for: .navigationBar)
        .fullScreenCover(isPresented: $isAgreementPresented) {
            NavigationStack {
                UserAgreementView()
            }
            .preferredColorScheme(isDarkThemeEnabled ? .dark : .light)
        }
    }

    private var settingsRow: some View {
        HStack {
            Text("Темная тема")
                .font(.system(size: 17))
                .foregroundStyle(Color.travelPrimary)

            Spacer()

            Toggle("", isOn: $isDarkThemeEnabled)
                .labelsHidden()
        }
        .frame(height: 44)
    }

    private var agreementLink: some View {
        Button {
            isAgreementPresented = true
        } label: {
            HStack {
                Text("Пользовательское соглашение")
                    .font(.system(size: 17))
                    .foregroundStyle(Color.travelPrimary)

                Spacer()

                Image(systemName: "chevron.right")
                    .font(.system(size: 22, weight: .semibold))
                    .foregroundStyle(Color.travelPrimary)
            }
            .frame(height: 44)
        }
        .buttonStyle(.plain)
    }

    private var footer: some View {
        VStack(spacing: 12) {
            Text("Приложение использует API «Яндекс.Расписания»")
            Text("Версия 1.0 (бета)")
        }
        .font(.system(size: 12))
        .foregroundStyle(Color.travelPrimary)
        .frame(maxWidth: .infinity)
    }
}

private struct UserAgreementView: View {
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text("Оферта на оказание образовательных услуг дополнительного образования Яндекс.Практикум для физических лиц")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundStyle(Color.travelPrimary)

                Text("Данный документ является действующим, если расположен по адресу: https://yandex.ru/legal/practicum_offer")

                Text("Российская Федерация, город Москва")
                    .padding(.top, 8)

                Text("1. ТЕРМИНЫ")
                    .font(.system(size: 24, weight: .bold))
                    .padding(.top, 8)

                Text("Понятия, используемые в Оферте, означают следующее:")

                Text("Авторизованные адреса — адреса электронной почты каждой Стороны. Авторизованным адресом Исполнителя является адрес электронной почты, указанный в разделе 11 Оферты. Авторизованным адресом Студента является адрес электронной почты, указанный Студентом в Личном кабинете.")

                Text("Вводный курс — начальный Курс обучения по предоставленным на Сервисе Программам обучения в рамках выбранной Студентом Профессии или Курсу, рассчитанный на определенное количество часов самостоятельного обучения.")

                Text("Исполнитель — общество с ограниченной ответственностью, оказывающее образовательные услуги по настоящей Оферте.")

                Text("Студент — физическое лицо, принявшее условия настоящей Оферты и получающее доступ к образовательным материалам.")
            }
            .font(.system(size: 17))
            .foregroundStyle(Color.travelPrimary)
            .padding(.horizontal, 16)
            .padding(.top, 12)
            .padding(.bottom, 32)
        }
        .background(Color.travelBackground)
        .navigationTitle("Пользовательское соглашение")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 24, weight: .semibold))
                        .foregroundStyle(Color.travelPrimary)
                }
            }

            ErrorStateToolbar()
        }
    }
}
