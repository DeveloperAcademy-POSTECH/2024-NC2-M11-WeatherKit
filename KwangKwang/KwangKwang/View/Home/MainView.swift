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
                    .padding(.leading, 20)
                
                Spacer()
            }
            Text(StringLiterals.Condition.rainy.rawValue)
                .padding(.leading, 3)
                .frame(width: 360, alignment: .leading)
            
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .frame(width: 353, height: 62)
                    .foregroundStyle(.gray6)
                HStack {
                    Spacer()
                    Image(systemName: "cloud.heavyrain")
                        .resizable()
                        .frame(width: 35, height: 34)
                        .padding(.leading, 30)
                    
                    VStack {
                        if let current = weatherManager.currentWeather {
                            Text("\(Int(current.temperature.converted(to: .celsius).value))°")
                                .font(.body)
                                .frame(width: 325, alignment: .leading)
                            HStack {
                                if let daily = weatherManager.dailyWeather {
                                    ForEach(0..<10) { index in
                                        if dailyFormat.string(from: daily[index].date) == dailyFormat.string(from: Date()) {
                                            
                                            Text("최저: \(Int(daily[index].lowTemperature.converted(to: .celsius).value))°")
                                                .font(.caption2)
                                            Text("최고: \(Int(daily[index].highTemperature.converted(to: .celsius).value))°")
                                                .font(.caption2)
                                        }
                                    }
                                    Spacer()
                                }
                            }
                        }
                    }
                }
            }
            Image("wind")
                .resizable()
                .frame(width: 353, height: 396)
            
        }
        .onAppear {
            Task {
                await weatherManager.getWeather(lat: pohang.coordinate.latitude,
                                                long: pohang.coordinate.longitude)
            }
        }
        .font(.title3)
    }
}

#Preview {
    MainView()
}
