# Расписание Путешествий

Учебный проект (спринт 18). Сетевой слой поверх API Яндекс Расписаний,
сгенерированный с помощью [Swift OpenAPI Generator](https://github.com/apple/swift-openapi-generator).

## Что внутри

- `TravelSchedule/openapi.yaml` — описание всех 8 сетевых запросов API.
- `TravelSchedule/openapi-generator-config.yaml` — конфигурация генератора (`types`, `client`).
- `TravelSchedule/Networking/Generated/` — сгенерированный код (`Types.swift`, `Client.swift`).
- `TravelSchedule/Networking/Services/` — по сервису на каждый запрос.
- `TravelSchedule/ContentView.swift` — демонстрационные вызовы всех сервисов.

## Сервисы

| Сервис | Эндпоинт | operationId |
|---|---|---|
| Список ближайших станций | `/v3.0/nearest_stations/` | `getNearestStations` |
| Расписание между станциями | `/v3.0/search/` | `getSchedualBetweenStations` |
| Список рейсов по станции | `/v3.0/schedule/` | `getStationSchedule` |
| Список станций следования (нитка) | `/v3.0/thread/` | `getRouteStations` |
| Ближайший город | `/v3.0/nearest_settlement/` | `getNearestCity` |
| Информация о перевозчике | `/v3.0/carrier/` | `getCarrierInfo` |
| Список всех станций | `/v3.0/stations_list/` | `getAllStations` |
| Копирайт | `/v3.0/copyright/` | `getCopyright` |

## Запуск

1. Подставьте свой API-ключ Яндекс Расписаний в `TravelSchedule/Networking/Constants.swift`.
2. Откройте `TravelSchedule.xcodeproj`, выберите симулятор iPhone и запустите.
3. Результаты вызовов сервисов печатаются в консоль при старте приложения.

## Про кодогенерацию

Код в `Networking/Generated/` сгенерирован заранее CLI-генератором из `openapi.yaml`:

```sh
swift-openapi-generator generate TravelSchedule/openapi.yaml \
  --config TravelSchedule/openapi-generator-config.yaml \
  --output-directory TravelSchedule/Networking/Generated
```

При изменении `openapi.yaml` перегенерируйте код этой же командой.
Альтернатива — подключить build-tool плагин `OpenAPIGenerator` к таргету в Xcode;
тогда папку `Generated/` нужно удалить (код будет генерироваться при каждой сборке).
