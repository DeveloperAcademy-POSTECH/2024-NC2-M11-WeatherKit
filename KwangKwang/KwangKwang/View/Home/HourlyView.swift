import SwiftUI

struct HourlyView: View {
    
    @State var weatherManager: WeatherManager
    let hourFormat = DateFormat().hourlyFormat
    let dailyFormat = DateFormat().dailyFormat
    
    var body: some View {
        VStack {
            HStack {
                Text("시간별 예보")
                    .font(.caption)
                    .padding(.leading, 20)
                Spacer()
            }
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    Spacer().frame(width: 20)
                    if let hourly = weatherManager.hourlyWeather {
                        ZStack {
                            RoundedRectangle(cornerRadius: 5)
                                .foregroundStyle(.gray6)
                                .frame(width: 82, height: 120)
                            VStack {
                                Text("지금")
                                    .font(.caption)
                                Text("\(Int(weatherManager.currentWeather!.temperature.converted(to: .celsius).value))°")
                                    .font(.body)
                            }
                        }
                        ForEach(0..<hourly.count) { index in
                            if dailyFormat.string(from: hourly[index].date) == dailyFormat.string(from: Date()) {
                                if hourly[index].date >= Date() {
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 5)
                                            .foregroundStyle(.gray6)
                                            .frame(width: 82, height: 120)
                                        VStack {
                                            Text("\(hourFormat.string(from: hourly[index].date))시")
                                                .font(.caption)
                                            Text("\(Int(hourly[index].temperature.converted(to: .celsius).value))°")
                                                .font(.body)
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
                .frame(maxWidth: .infinity)
            }
        }
    }
}

//#Preview {
//    DailyView()
//}
