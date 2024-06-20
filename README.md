# 2024-NC2-M11-HaHam

### WeatherKit
![Icon](https://github.com/DeveloperAcademy-POSTECH/2024-NC2-M11-WeatherKit/assets/125838606/0cd31f78-1db4-4f11-8822-979df05001b6)

☁️ WeatherKit이란?</br>
여러 가지 유용한 기상 데이터를 제공하는 프레임워크</br>

<img width="763" alt="weather" src="https://github.com/DeveloperAcademy-POSTECH/2024-NC2-M11-WeatherKit/assets/125838606/eb0bf4f8-6d28-4540-8c7e-a3a6d79e5260">

현재 날씨 상황을 제공하고 기온, 강수량, 바람, UV 지수 등에 대한 10일간의 시간별 예보를 제공합니다. 일부 지역에서는 향후 1시간 동안의 분 단위 강수량과 악천후 경보도 제공하며, 현재 날씨, 분당 예보, 시간당 예보, 일일 예보에 따라서 다른 자료들을 제공하고 있습니다.

- 현재 날씨: 자외선 지수, 기온, 풍속 등
- 분당 예보: 가능한 곳의 다음 한 시간 동안 1분 마다 강수량과 같은 정보들을 제공
- 시간당 예보: 현재 시간을 포함한 최대 240시간에 대한 자료를 제공
- 분당 예보: 당일을 포함한 10일 간의 자료를 제공
- 일일 예보: 하루 전체의 정보를 제공. (ex: 최고, 최저 기온 등의 정보)

----

## 집중한 부분과 그 이유

Daily Weather, 그 중에서도 당일의 기상 상황(Condition) 을 가져오는 것에 집중했습니다.

```
weather.dailyForecast[index].condition
```
위와 같은 방식으로 데이터를 가져옵니다. WeatherKit은 일일 예보를 ‘당일을 포함한 10일 간의 정보’를 제공하기 때문에 원하는 날의 일일 예보 데이터를 가져오기 위해서는 적절한 index값을 넣어주어야 합니다.

----
## Use Case

|Problem|
|:----:|

우산 챙기는 것을 깜빡한다.
1. 우산을 깜빡해서 비가 오면 새로 우산을 구매하게 된다.
2. 우산이 없어서 외출 중에 비가 오면 옷이 젖어 불쾌하다.

Who: 우산 챙기는 것을 자주 깜빡하는 사람 </br>
When: 외출전에 사용 </br>
How: 날씨 정보 제공과 더불어 날씨에 따른 우산 챙김 여부를 알려줌

--> WeatherKit을 활용해 날씨에 따른 우산 챙김 서비스를 만들자!

----
## Prototype과 설명
![prototypeImage](https://github.com/DeveloperAcademy-POSTECH/2024-NC2-M11-WeatherKit/assets/125838606/7aa90026-34c1-44fb-ad65-ee36770d1981)

**Point 1. 날씨에 따라 바뀌는 카드와 멘트**

날짜 정보 텍스트 하단에 있는 문구와 이미지는 당일의 기상 상태에 따라서 바뀝니다. 우산을 챙겨야할 지 말아야 할 지를 보여주고 우산을 챙기지 않아도 되는 날씨라면 맑은 날인지 흐린 날인지를 보여 줍니다.

**Point 2. 강우량에 따른 우산 아이콘**

시간별 예보는 현재 시간 부터의 온도 및  시간 마다 바뀌는 기상 상태를 알려주는데 그 상태에 따라서 우산이 접힌 이미지, 펴진 이미지를 띄웁니다.

**Additional 1. 외출 전 알림 설정 및 위젯**

사용자가 설정한 시간에 맞춰 우산 챙김 여부를 알려주는 알람 기능을 제공합니다. 위젯을 제공함으로써 홈 화면에서 바로 오늘 날씨와 우산 여부를 확인할 수 있도록 제공합니다.

**Additional 2. 지역 추가 및 일주일 날씨 제공**

현재 위치 외의 사용자의 관심 지역을 추가해서 더 다양한 날씨 정보를 볼 수 있도록 합니다. 또한, 일주일 날씨 정보를 제공함으로써 미리 기상 상황에 대비할 수 있도록 합니다.

---
## Code 조각 설명

```
let weatherService = WeatherService()
weather = try? await weatherService.weather(for: .init(latitude: lat, longitude: long))
```
Weatherkit 을 사용할 때 가장 핵심이 되는 부분입니다. 
위와 같이 위치 정보(위도 및 경도)를 넣어 주어서 선언 하면 간단하게 기상 자료를 가져올 수 있습니다.

---
데이터를 불러오는 방법
- 현재의 기상 데이터: weather.currentWeather
- 일일 예보: weather.dailyForecast
- 시간당 예보: weather.hourlyForecast

---
## 참고 사항
### 개발 참고 사항

1. 애플 개발자 계정 필요
(https://developer.apple.com/kr/help/account/get-started/about-your-developer-account/)

2. 호출 건수에 따른 비용
<img width="338" alt="스크린샷 2024-06-20 오전 5 25 53" src="https://github.com/DeveloperAcademy-POSTECH/2024-NC2-M11-WeatherKit/assets/125838606/3ef89ee7-7661-4310-afc8-5edfa6ee3154">

3. **Apple 날씨 및 타사 어트리뷰션**
    
    앱, 웹 앱 또는 웹 사이트에 Apple의 날씨 데이터를 표시하는 경우(아래 설명된 바와 같이, 기상 경보, 부가가치 서비스 또는 제품 제외) Apple 날씨 상표(Weather)를 분명하게 표시해야 하며 [기타 데이터 소스](https://developer.apple.com/weatherkit/data-source-attribution/)로 연결되는 법적 링크도 표시해야 합니다.
    
4. 기상 경보 표시
    - 모든 기상 경보를 표시할 때는 Apple에서 개발자에게 제공한 Apple 기상 경보 세부 사항 페이지로 연결되는 링크를 포함하고 있어야 합니다.
    - 악천후 경보 텍스트는 어떠한 방식으로도 수정하거나, 변경하거나, 고치거나 모호하게 만들어서는 안 됩니다.
    - 모든 기상 경보 제목 또는 설명에는 해당 경보를 발표한 **기상청 출처의 정확한 이름을 포함**하고 있어야 합니다. 적용할 수 있는 기상청에 대한 정보와 이러한 기상 경보의 사용 및 배포 관련 자세한 사용 조건은 해당 Apple 날씨 경보 상세 페이지를 방문하시기 바랍니다.

## 팀원 소개
|![Hash](https://github.com/DeveloperAcademy-POSTECH/2024-NC2-M11-WeatherKit/assets/125838606/818eb042-f41b-49d0-b16d-cf73a488db6d)|![Jamie](https://github.com/DeveloperAcademy-POSTECH/2024-NC2-M11-WeatherKit/assets/125838606/94e95224-28f2-4a7e-95fa-b04fa15dffc5)|
|:----:|:----:|
|[해시](https://github.com/JungHash)|[제이미](https://github.com/TakeMos)|
