import SwiftUI

struct DateFormat {
    
    let dailyFormat: DateFormatter = {
        let format = DateFormatter()
        format.dateFormat = "M월 dd일 EEE"
        format.locale = Locale(identifier: "ko_KR")
        return format
    }()
    
    let hourlyFormat: DateFormatter = {
        let format = DateFormatter()
        format.dateFormat = "hh 시"
        format.locale = Locale(identifier: "ko_KR")
        return format
    }()
}
