import SwiftUI
import CoreLocation

struct MainView: View {
    
    @ObservedObject private var weatherManager = WeatherManager()
    @State private var conditionImage: String = ""
    
    let dailyFormat = DateFormat().dailyFormat
    let pohang = CLLocation(latitude: 36.0190178, longitude: 129.343408)
    
    var body: some View {
        VStack(spacing: 12) {
            HStack {
                Text("\(weatherManager.date)")
                    .font(.caption)
                    .fontWeight(.semibold)
                    .padding(.leading, 20)
                
                Spacer()
            }
            Text(StringLiterals.Condition.rainy.rawValue)
                .padding(.leading, 3)
                .frame(width: 360, alignment: .leading)
            
            LoHiTempView(weatherManager: weatherManager)
            
            Image(choiceImage())
                .resizable()
                .frame(width: 353, height: 396)
            
            HourlyView(weatherManager: weatherManager)
                .padding(.top, 20)
        }
        .onAppear {
            Task {
                await weatherManager.getWeather(lat: pohang.coordinate.latitude,
                                                long: pohang.coordinate.longitude)
            }
        }
        .font(.title3)
    }
    func choiceImage() -> String {
        
        if let hourly = weatherManager.hourlyWeather {
            switch hourly[0].condition {
            case .blizzard, .blowingSnow, .flurries, .hail, .snow, .frigid, .sleet, .wintryMix, .heavySnow :
                return "snow"
            case .blowingDust, .breezy, .tropicalStorm, .windy :
                return "wind"
            case .clear, .hot, .sunFlurries, .sunShowers, .mostlyClear :
                return "sunRise"
            case .cloudy, .foggy, .mostlyCloudy, .partlyCloudy :
                return "cloud"
            case .hurricane :
                return "typhoon"
            default :
                return "rainy"
            }
        } else {
            return ""
        }
    }
    func choiceText() -> String {
        if let daily = weatherManager.dailyWeather {
            switch daily[0].condition {
            case .blizzard, .blowingSnow, .flurries, .hail, .snow, .frigid, .sleet, .wintryMix, .heavySnow :
                return "snow"
            case .blowingDust, .breezy, .tropicalStorm, .windy :
                return "wind"
            case .clear, .hot, .sunFlurries, .sunShowers, .mostlyClear :
                return "sunRise"
            case .cloudy, .foggy, .mostlyCloudy, .partlyCloudy :
                return "cloud"
            case .hurricane :
                return "typhoon"
            default :
                return "rainy"
            }
        } else {
            return ""
        }
    }
}

#Preview {
    MainView()
}
