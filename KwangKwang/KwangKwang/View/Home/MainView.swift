import SwiftUI
import CoreLocation

struct MainView: View {
    
    @ObservedObject private var weatherManager = WeatherManager()
    
    let dateFormat = DateFormat()
    let pohang = CLLocation(latitude: 36.0190178, longitude: 129.343408)
    
    var body: some View {
        VStack(spacing: 12) {
            HStack {
                Text("\(weatherManager.date)")
                    .font(.caption)
                    .padding(.leading)
                
                Spacer()
            }
            Text(StringLiterals.Condition.drizzle.rawValue)
                .frame(width: 360, alignment: .leading)
            HStack {
                Image(systemName: "cloud.heavyrain")
                    .frame(width: 35, height: 34)
                VStack {
                    if let current = weatherManager.currentWeather {
                        Text("\(Int(current.temperature.converted(to: .celsius).value))°")
                            .font(.body)
                    }
                }
            }
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
