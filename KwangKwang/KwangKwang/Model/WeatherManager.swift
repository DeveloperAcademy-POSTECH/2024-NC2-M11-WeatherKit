import SwiftUI
import WeatherKit

class WeatherManager: ObservableObject {
    
    let dateFormat = DateFormat()
    private let weatherService = WeatherService()
    @Published var weather: Weather?
    
    func getWeather(lat: Double, long: Double) async {
        do {
            weather = try await weatherService.weather(for: .init(latitude: lat, longitude: long))
        } catch {
            print("Failed to get weather data. \(error)")
        }
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
    
    var hourlyWeather: Forecast<HourWeather>? {
        
        if let hourly = weather?.hourlyForecast {
            return hourly
        } else {
            print("hourly weather Error")
            return nil
        }
    }
    
    var date: String {
        guard let date = weather?.currentWeather.date else { return ""}
        
        return dateFormat.dailyFormat.string(from: date) + "요일"
    }
}
