import SwiftUI
import OpenAPIRuntime
import OpenAPIURLSession

struct ContentView: View {
    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "tram.fill")
                .font(.system(size: 48))
                .foregroundStyle(.tint)
            Text("Расписание Путешествий")
                .font(.title2)
                .bold()
            Text("Сетевой слой готов.\nВызовы сервисов выполняются при запуске —\nрезультаты смотрите в консоли Xcode.")
                .font(.footnote)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
        }
        .padding()
        .task {
            await runAllServices()
        }
    }

    /// Демонстрационные вызовы всех сетевых сервисов с минимальным набором
    /// входных параметров. Нужны, чтобы убедиться, что сервисы работают.
    private func runAllServices() async {
        let client = APIClientFactory.makeClient()
        let apikey = Constants.apiKey

        // 1. Список ближайших станций
        do {
            let service = NearestStationsService(client: client, apikey: apikey)
            let result = try await service.getNearestStations(lat: 55.75222, lng: 37.61556, distance: 50)
            print("✅ nearest_stations:", result.stations?.count ?? 0, "станций")
        } catch {
            print("❌ nearest_stations:", error)
        }

        // 2. Расписание рейсов между станциями
        do {
            let service = ScheduleBetweenStationsService(client: client, apikey: apikey)
            let result = try await service.getSchedule(from: "c146", to: "c213")
            print("✅ search:", result.segments?.count ?? 0, "сегментов")
        } catch {
            print("❌ search:", error)
        }

        // 3. Список рейсов по станции
        do {
            let service = StationScheduleService(client: client, apikey: apikey)
            let result = try await service.getStationSchedule(station: "s9600213")
            print("✅ schedule:", result.schedule?.count ?? 0, "рейсов")
        } catch {
            print("❌ schedule:", error)
        }

        // 4. Список станций следования (нитка)
        do {
            let service = RouteStationsService(client: client, apikey: apikey)
            let result = try await service.getRouteStations(uid: "098S_3_2")
            print("✅ thread:", result.stops?.count ?? 0, "остановок")
        } catch {
            print("❌ thread:", error)
        }

        // 5. Ближайший город
        do {
            let service = NearestCityService(client: client, apikey: apikey)
            let result = try await service.getNearestCity(lat: 55.75222, lng: 37.61556)
            print("✅ nearest_settlement:", result.title ?? "—")
        } catch {
            print("❌ nearest_settlement:", error)
        }

        // 6. Информация о перевозчике
        do {
            let service = CarrierService(client: client, apikey: apikey)
            let result = try await service.getCarrierInfo(code: "680")
            print("✅ carrier:", result.carriers?.first?.title ?? "—")
        } catch {
            print("❌ carrier:", error)
        }

        // 7. Список всех станций
        do {
            let service = AllStationsService(client: client, apikey: apikey)
            let result = try await service.getAllStations()
            print("✅ stations_list:", result.countries?.count ?? 0, "стран")
        } catch {
            print("❌ stations_list:", error)
        }

        // 8. Копирайт Яндекс Расписаний
        do {
            let service = CopyrightService(client: client, apikey: apikey)
            let result = try await service.getCopyright()
            print("✅ copyright:", result.copyright?.text ?? "—")
        } catch {
            print("❌ copyright:", error)
        }
    }
}

#Preview {
    ContentView()
}
