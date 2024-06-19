import Foundation

enum StringLiterals {
    enum Condition: String, CaseIterable {
        
        case sunRise = "상쾌한 날씨가 될 것 같아요 나들이나 가볼까요?"
        case rainy = "오늘은 꼭 우산 갖고 가세요!! 흠뻑 젖을지도 몰라요."
        case summer = "하늘에 구름이 끼여있네요. 평소보다 시원한 날씨가 지속될 예정이예요."
        case winter = "기분은 우중충해도 날씨는 선선할 것 같아요! 아우터를 챙기는게 좋을지도?"
        case typhoon = "오늘 밖에 나가는 건 위험할 것 같아요 집에서 시간을 보내는 건 어떨까요?"
        case drizzle = "비가 조금 올 것으로 보여요!! 접이식 우산을 챙겨볼까요?"
        case fakeSun = "하늘이 맑은 것에 속지 마시고 우산 챙겨가세요!!"
    }
}
