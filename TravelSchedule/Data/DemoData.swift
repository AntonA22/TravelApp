import SwiftUI

enum DemoData {
    static let cities: [City] = [
        City(
            name: "Москва",
            stations: [
                TravelStation(name: "Киевский вокзал", code: "s2000007"),
                TravelStation(name: "Курский вокзал", code: "s2000001"),
                TravelStation(name: "Ярославский вокзал", code: "s2000002"),
                TravelStation(name: "Белорусский вокзал", code: "s2000006"),
                TravelStation(name: "Савеловский вокзал", code: "s2000009"),
                TravelStation(name: "Ленинградский вокзал", code: "s2006004")
            ]
        ),
        City(
            name: "Санкт-Петербург",
            stations: [
                TravelStation(name: "Московский вокзал", code: "s9602497"),
                TravelStation(name: "Ладожский вокзал", code: "s9602498"),
                TravelStation(name: "Балтийский вокзал", code: "s9602496"),
                TravelStation(name: "Финляндский вокзал", code: "s9602499")
            ]
        ),
        City(
            name: "Горный воздух",
            stations: [
                TravelStation(name: "Горный воздух", code: nil),
                TravelStation(name: "Санаторная", code: nil)
            ]
        ),
        City(
            name: "Краснодар",
            stations: [
                TravelStation(name: "Краснодар-1", code: "s2064788"),
                TravelStation(name: "Краснодар-2", code: "s2064789"),
                TravelStation(name: "Пашковская", code: "s2064790")
            ]
        ),
        City(
            name: "Омск",
            stations: [
                TravelStation(name: "Омск-Пассажирский", code: "s9602481"),
                TravelStation(name: "Московка", code: nil),
                TravelStation(name: "Входная", code: nil)
            ]
        ),
        City(
            name: "Казань",
            stations: [
                TravelStation(name: "Казань-Пассажирская", code: "s9602494"),
                TravelStation(name: "Восстание-Пассажирская", code: "s9602495"),
                TravelStation(name: "Аэропорт Казань", code: "s9623415")
            ]
        ),
        City(
            name: "Сочи",
            stations: [
                TravelStation(name: "Сочи", code: "s9602858"),
                TravelStation(name: "Адлер", code: "s9602859"),
                TravelStation(name: "Олимпийский парк", code: "s9868201")
            ]
        ),
        City(
            name: "Екатеринбург",
            stations: [
                TravelStation(name: "Екатеринбург-Пассажирский", code: "s9607404"),
                TravelStation(name: "Шарташ", code: nil),
                TravelStation(name: "Кольцово", code: "s9600370")
            ]
        )
    ]

    static let carriers: [Carrier] = [
        Carrier(
            name: "РЖД",
            legalName: "ОАО «РЖД»",
            email: "info@rzd.ru",
            phone: "+7 (800) 775-00-00",
            date: "14 января",
            departure: "22:30",
            arrival: "08:15",
            duration: "20 часов",
            period: .evening,
            hasTransfer: true,
            logoText: "Р",
            logoColor: .red,
            transferTitle: "С пересадкой в Костроме"
        ),
        Carrier(
            name: "ФГК",
            legalName: "АО «ФГК»",
            email: "info@fgk.ru",
            phone: "+7 (495) 663-10-20",
            date: "15 января",
            departure: "01:15",
            arrival: "09:00",
            duration: "9 часов",
            period: .night,
            hasTransfer: false,
            logoText: "Ф",
            logoColor: .orange,
            transferTitle: nil
        ),
        Carrier(
            name: "Урал Логистика",
            legalName: "ООО «Урал Логистика»",
            email: "support@ural-logistics.ru",
            phone: "+7 (343) 222-18-11",
            date: "15 января",
            departure: "12:30",
            arrival: "21:00",
            duration: "9 часов",
            period: .day,
            hasTransfer: false,
            logoText: "У",
            logoColor: Color.travelBlue,
            transferTitle: nil
        ),
        Carrier(
            name: "Гранд Сервис Экспресс",
            legalName: "АО ТК «Гранд Сервис Экспресс»",
            email: "info@grandtrain.ru",
            phone: "+7 (800) 775-54-53",
            date: "16 января",
            departure: "14:10",
            arrival: "23:50",
            duration: "9 ч 40 м",
            period: .day,
            hasTransfer: true,
            logoText: "Г",
            logoColor: .purple,
            transferTitle: "С пересадкой"
        )
    ]

    static let stories: [TravelStory] = [
        TravelStory(
            id: "mountains",
            title: "Кабина машиниста",
            subtitle: "Маршрут изнутри",
            imageName: "StoryMountains",
            accentColor: Color(red: 0.20, green: 0.45, blue: 0.85),
            pages: [
                TravelStoryPage(
                    id: "mountains-1",
                    title: "Кабина машиниста",
                    subtitle: "Смотрите, как поездка начинается с первых минут маршрута.",
                    imageName: "StoryMountains",
                    accentColor: Color(red: 0.20, green: 0.45, blue: 0.85)
                ),
                TravelStoryPage(
                    id: "mountains-2",
                    title: "В дороге спокойно",
                    subtitle: "Выберите удобный рейс и проверьте перевозчика заранее.",
                    imageName: "StoryTickets",
                    accentColor: Color(red: 0.12, green: 0.58, blue: 0.44)
                )
            ]
        ),
        TravelStory(
            id: "tickets",
            title: "Работа проводника",
            subtitle: "Детали поездки",
            imageName: "StoryTickets",
            accentColor: Color(red: 0.85, green: 0.25, blue: 0.30),
            pages: [
                TravelStoryPage(
                    id: "tickets-1",
                    title: "Работа проводника",
                    subtitle: "Расписание помогает подготовиться к маршруту и времени отправления.",
                    imageName: "StoryTickets",
                    accentColor: Color(red: 0.85, green: 0.25, blue: 0.30)
                ),
                TravelStoryPage(
                    id: "tickets-2",
                    title: "Проверяйте детали",
                    subtitle: "В карточке перевозчика доступны контакты и основная информация.",
                    imageName: "StoryNight",
                    accentColor: Color(red: 0.92, green: 0.52, blue: 0.18)
                )
            ]
        ),
        TravelStory(
            id: "night",
            title: "Вагон в пути",
            subtitle: "Место для паузы",
            imageName: "StoryNight",
            accentColor: Color(red: 0.36, green: 0.31, blue: 0.78),
            pages: [
                TravelStoryPage(
                    id: "night-1",
                    title: "Вагон в пути",
                    subtitle: "Фильтры помогут найти удобное время отправления.",
                    imageName: "StoryNight",
                    accentColor: Color(red: 0.36, green: 0.31, blue: 0.78)
                ),
                TravelStoryPage(
                    id: "night-2",
                    title: "Без лишних пересадок",
                    subtitle: "Сравнивайте варианты и оставляйте только подходящие рейсы.",
                    imageName: "StoryMountains",
                    accentColor: Color(red: 0.16, green: 0.56, blue: 0.78)
                )
            ]
        ),
        TravelStory(
            id: "city",
            title: "Дальние маршруты",
            subtitle: "Поезд и новые места",
            imageName: "StoryCity",
            accentColor: Color(red: 0.25, green: 0.62, blue: 0.32),
            pages: [
                TravelStoryPage(
                    id: "city-1",
                    title: "Дальние маршруты",
                    subtitle: "Выберите город, станцию и быстро найдите варианты маршрута.",
                    imageName: "StoryCity",
                    accentColor: Color(red: 0.25, green: 0.62, blue: 0.32)
                ),
                TravelStoryPage(
                    id: "city-2",
                    title: "Всё под рукой",
                    subtitle: "Главный экран, Stories, фильтры и карточка перевозчика работают вместе.",
                    imageName: "StoryTickets",
                    accentColor: Color(red: 0.16, green: 0.50, blue: 0.76)
                )
            ]
        )
    ]
}
