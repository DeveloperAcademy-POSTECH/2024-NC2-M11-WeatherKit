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
        format.dateFormat = "a h"
        format.locale = Locale(identifier: "ko_KR")
        return format
    }()
}
