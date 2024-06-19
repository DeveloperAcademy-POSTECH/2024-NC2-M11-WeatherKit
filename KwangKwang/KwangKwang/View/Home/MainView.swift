import SwiftUI
import CoreLocation

struct MainView: View {
    
    @ObservedObject private var weatherManager = WeatherManager()
    @State private var conditionImage: String = ""
    @State private var locate: String? = ""
    @State private var myLocation: CLLocation?
    
    let dailyFormat = DateFormat().dailyFormat
    
    var body: some View {
        VStack(spacing: 12) {
            HStack {
                Text("\(weatherManager.date)")
                    .font(.caption)
                    .fontWeight(.semibold)
                    .padding(.leading, 20)
                
                Spacer()
                
                if let locate = locate{
                    Text("\(locate)")
                        .font(.caption)
                        .fontWeight(.bold)
                    Image(systemName: "location.fill")
                        .font(.caption)
                        .padding(.trailing, 25)
                }
                
            }
            
            Text(choiceText())
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
                getLocation()
                if let myLocation = myLocation {
                    await weatherManager.getWeather(lat: myLocation.coordinate.latitude,
                                                    long: myLocation.coordinate.longitude)
                }
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
                return StringLiterals.Condition.rainy.rawValue
            case .blowingDust, .breezy, .tropicalStorm, .windy, .clear, .hot, .sunFlurries, .sunShowers, .mostlyClear :
                return StringLiterals.Condition.sunRise.rawValue
            case .cloudy, .foggy, .mostlyCloudy, .partlyCloudy :
                let calendar = Calendar.current
                let components = calendar.dateComponents([.month], from: daily[0].date)
                
                if components.month! <= 8 {
                    return StringLiterals.Condition.summer.rawValue
                } else {
                    return StringLiterals.Condition.winter.rawValue
                }
            case .hurricane :
                return StringLiterals.Condition.typhoon.rawValue
            case .drizzle, .freezingDrizzle :
                return StringLiterals.Condition.drizzle.rawValue
            case .sunFlurries :
                return StringLiterals.Condition.fakeSun.rawValue
            default :
                return StringLiterals.Condition.rainy.rawValue
            }
        } else {
            return ""
        }
    }
    
    func getLocation() {
        let manager = CLLocationManager()
        manager.desiredAccuracy = kCLLocationAccuracyReduced
        let geocoder = CLGeocoder()
        let lactitude = manager.location?.coordinate.latitude
        let logittude = manager.location?.coordinate.longitude
        
        if let lactitude = lactitude, let logittude = logittude {
            
            let location = CLLocation(latitude: lactitude, longitude: logittude)
            myLocation = location
            geocoder.reverseGeocodeLocation(location) { placemarks, error in
                if let placemarks = placemarks, let address = placemarks.last?.locality {
                    locate = address
                }
            }
        }
        
        
    }
}

#Preview {
    MainView()
}
