# 김경원의 개인 블로그 프로젝트
### 프로젝트 개요
- 사용 언어 : flutter
  - 버전 : 3.24.2
- 사용한 주요 패키지
  - go_router : page 라우터 관리
  - riverpod : 상태관리
  - intl : 텍스트 관리
  - supabase : supabase SDK

### 프로젝트 구조
- /resource
  - **/l10n/arb**  
    다국어(텍스트) 관리
  - /values
    - **color_sheme.dart**  
      앱 색상 관리
    - **theme.dart**  
      앱 테마 관리
  - **assets.dart**  
    assets 경로 관리
- /src
  - /core
    - /riverpods
      - **theme_mode_notifier.dart**  
        테마 상태 관리
    - /routes
      - **app_pages.dart**  
        라우터 config 관리
      - **app_routes.dart**  
        라우터 이름 관리
  - /domain
    - /models/
      - **classification_type.dart**  
        전체보기/카테고리/태그 모델 
  - /presentation
    - /pages
      - **/main_page**  
        메인 페이지 디자인
    - /riverpods
      - **main_notifier.dart**  
        메인 페이지 상태 관리

---
### 프로젝트 준비
1. 패키지 설치
```
$ flutter pub get
```
2. generator 파일 생성
```
$ flutter pub run build_runner build
```
3. .arb => .dart
```
$ flutter pub run intl_utils:generate
```
---
### 프로젝트 실행
```
$ flutter run -d Chrome <build_mode>
```
---
### 프로젝트 빌드
```
$ flutter build web --release
$ dhttpd --path build/web 
```
