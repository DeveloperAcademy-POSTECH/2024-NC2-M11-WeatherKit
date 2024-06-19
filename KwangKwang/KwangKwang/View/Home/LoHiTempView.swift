import SwiftUI

struct LoHiTempView: View {
    
    @State var weatherManager: WeatherManager
    let dailyFormat = DateFormat().dailyFormat
    
    var body: some View {
        
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .frame(width: 353, height: 62)
                .foregroundStyle(.gray6)
            HStack {
                Spacer()
                Image(systemName: choiceImage())
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 36, height: 36)
                    .padding(.leading, 40)
                
                VStack {
                    if let current = weatherManager.currentWeather {
                        Text("\(Int(current.temperature.converted(to: .celsius).value))°")
                            .font(.body)
                            .fontWeight(.medium)
                            .frame(width: 325, alignment: .leading)
                        HStack {
                            if let daily = weatherManager.dailyWeather {
                                ForEach(0..<10) { index in
                                    if dailyFormat.string(from: daily[index].date) == dailyFormat.string(from: Date()) {
                                        Text("최저: \(Int(daily[index].lowTemperature.converted(to: .celsius).value))°")
                                            .font(.caption)
                                        Text("최고: \(Int(daily[index].highTemperature.converted(to: .celsius).value))°")
                                            .font(.caption)
                                    }
                                }
                                Spacer()
                            }
                        }
                    }
                }
            }
        }
    }
    func choiceImage() -> String {
        if let hourly = weatherManager.hourlyWeather {
            switch hourly[0].condition {
            case .blizzard, .blowingSnow, .flurries, .hail, .snow, .frigid, .sleet, .wintryMix, .heavySnow :
                return "cloud.snow"
            case .blowingDust, .breezy, .tropicalStorm, .windy :
                return "wind"
            case .clear, .hot, .sunFlurries, .sunShowers, .mostlyClear :
                return "sun.max"
            case .cloudy, .foggy, .mostlyCloudy, .partlyCloudy :
                return "cloud"
            case .rain :
                return "cloud.rain"
            case .hurricane :
                return "cloud.bolt.rain"
            default :
                return "cloud.heavyrain"
            }
        } else {
            return ""
        }
    }
}
