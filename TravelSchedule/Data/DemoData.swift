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
}
