**일일이 README.md** 

![타이틀이미지](./readme/zero.png)
# <center> ⚪️ 일일이 - 나만의 일정 + 일기 관리 서비스 </center>
### Download
- 아래 링크 접속 후 이메일 기입 -> 이메일 확인
  
- [일일이 iOS App 다운로드하기](https://appdistribution.firebase.dev/i/99d6f402cc903800)

## ⚪️ 주요 기능
### 1. 로그인 / 캘린더뷰
![타이틀이미지](./readme/first.png)

- Firebase Auth 이메일/비밀번호 로그인
- 커스텀 캘린더 FSCalenderView 사용
- 커스텀 토스트 메시지 사용
- TableViewController로 날짜 별 일정 목록 출력
  
### 2. 일정 작성 / 리스트뷰
![타이틀이미지](./readme/second.png)

- 일정 데이터 firebase 저장
- TableViewController로 일정 목록 출력 및 조회
  
## ⚪️ 개발 환경
### 사용 스택

| Application |  Language | Framework | Back, DB |
| ---- | ---- | ---- | ---- | 
| iOS App | Swift |  XCode | Firebase |



### Database
- firebase realtime database 구조
- user
    - diaries
        - contentId
        - title
        - content (null)
        - photo(null)
        - timestamp (yyyy/mm/dd hh:mm)

### **Plugins**
    - Login : Firebase Authentication
    - Server Databse : Firebase Realtime Database
    - CI/CD : Firebase App Distribution
    - Calender : FSCalendar


## ⚪️ 프로젝트 산출물
- [일일이 Figma 워크스페이스 가기]([https://woozy-passbook-d4b.notion.site/3d0a32e4d2904317a37bdc4508057f96?pvs=4](https://www.figma.com/design/WEnkFFqq3jFvb3C2lrHg8J/%EC%9D%BC%EC%9D%BC%EC%9D%B4?node-id=0-1&node-type=canvas&t=VLft4WRYm955L3wu-0))

* 단기 개인 프로젝트인 관계로 git은 마스터브랜치를 사용