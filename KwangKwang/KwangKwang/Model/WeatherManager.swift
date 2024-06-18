import SwiftUI
import WeatherKit

class WeatherManager: ObservableObject {
    
    let dateFormat = DateFormat()
    private let weatherService = WeatherService()
    @Published var weather: Weather?
    
    func getWeather(lat: Double, long: Double) async {
        do {
            weather = try await Task.detached(priority: .userInitiated) { [weak self] in
                return try await self?.weatherService.weather(for: .init(latitude: lat, longitude: long))
            }.value
            
        } catch {
            print("Failed to get weather data. \(error)")
        }
    }

    var icon: String {
        guard let iconName = weather?.currentWeather.symbolName else { return "--" }
        
        return iconName
    }
    
    var currentWeather: CurrentWeather? {
        if let current = weather?.currentWeather {
            return current
        } else {
            print("current weather Error")
            return nil
        }
    }
    
    var dailyWeather: Forecast<DayWeather>? {
        
        if let daily = weather?.dailyForecast {
            return daily
        } else {
            print("daily weather Error")
            return nil
        }
    }
    
    var temperature: String {
        guard let temp = weather?.currentWeather.temperature else { return "--" }
        let convert = temp.converted(to: .celsius).value
        
        return String(Int(convert)) + "°C"
    }
    
    var humidity: String {
        guard let humidity = weather?.currentWeather.humidity else { return "--" }
        let computedHumidity = humidity * 100
        
        return String(Int(computedHumidity)) + "%"
    }
    
    var date: String {
        guard let date = weather?.currentWeather.date else { return ""}
        
        return dateFormat.dailyFormat.string(from: date) + "요일"
    }
}
