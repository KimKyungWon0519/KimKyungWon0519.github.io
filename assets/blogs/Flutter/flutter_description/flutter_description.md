---
title: Flutter란 무엇인가요?
description: CrossPlatform인 Flutter에 대해 알아봅시다.
tags: 
    - Flutter
    - Dart
createdAt: 2024-03-02
thumbnail: assets/blogs/Flutter/flutter_description/thumbnail.png
---

# 1. Flutter(플러터)란?
Google에서 개발한 **Flutter**는 오픈소스 크로스플랫폼입니다. 지원하는 플랫폼으로는 Android, iOS, Web, Windows, Linux, macOS가 있습니다.  
**Flutter**는 Dart 언어를 사용하며, 선언형 UI와 Google에서 개발한 Skia 렌더링 엔진을 사용합니다.  
(Flutter 3부터는 Android와 iOS는 Impeller 엔진을 사용합니다.)

# 2. Flutter 구성
## 2-1. 아키텍처 레이어
![architecutre](<resource:blogs/Flutter/flutter_description/archdiagram.png>)
### 1. Embedder(임베더)
**Embedder**는 운영 체제와 직접 상호작용합니다. 렌더링, 접근성, 사용자 입력 등의 플랫폼에 종속적인 서비스들의 제어하며, 메시지 이벤트 루프를 관리합니다.
임베더는 현재 Android(Java, C++) iOS/MacOS(Objective-C, Objective-C++), Windows/Linux(C++)를 사용합니다.
### 2. Engine(엔진)
플러터의 핵심은 대부분 C++로 작성된 플러터 **Engine**이며, 이 엔진은 애플리케이션을 지원하는 필요한 기본적인 기능을 지원합니다. 또한 엔진은 새로운 프레임이 그려져야 할 때마다 장면을 레스터화 합니다.
**엔진**은 C++ 코드를 Dart로 감싼 dart:ui를 통해 플러터 프레임워크에 노출됩니다.
dart:ui는 입력, 그래픽(Skia 혹은 Impeller), 렌더링 클래스와 같은 저수준의 기본 기능을 노출합니다.
### 3. Framework(프레임워크)
**Framework**는 일반적으로 개발자들이 Dart 언어를 사용하여 플러터와 상호작용하는 계층입니다. 프레임워크는 플랫폼, 레이아웃, 기본 라이브러리의 풍부한 세트를 포함하며, 일련의 계층으로 구성되어 있습니다.
- 기본 클래스, 애니메이션, 페인팅, 제스처 등의 서비스들이 기본 토대 위에 사용되는 추상화를 제공합니다.
- Rendering(렌더링) 계층은 레이아웃을 처리하는 추상화를 제공합니다. 해당 계층은 렌더링 가능한 동적 객체의 트리를 구축할 수 있습니다. 트리는 자동으로 레이아웃을 업데이트하여 변경 사항을 반영합니다.
- Widget(위젯) 계층은 조합 추상화입니다. 렌더링 계층의 각 렌더링 객체에는 위젯 계층에 대응하는 클래스가 있습니다. 위젯 계층을 사용하면 재사용 가능한 클래스의 조합을 정의할 수 있습니다.
- Material 및 Cupertino는 위젯 계층의 원시적인 기능을 사용하여 Material 또는 iOS 디자인을 구현하는 제어를 제공합니다.

## 2-2. 앱의 구조

아래의 다이어그램 **flutter create**로 생성된 일반적인 flutter 앱의 구성 요소입니다.

![app_anatomy](<resource:blogs/Flutter/flutter_description/app-anatomy.svg>)

### 1. Dart App
- 위젯으로 원하는 UI를 구현합니다.
- 비즈니스 로직을 구현합니다.

### 2. Framework
- 위젯, 제스처 감지, 접근성, 텍스트 입력 등 앱을 구축하기 위한 고수준 API를 제공합니다.

### 3. Engine
- 플러터의 핵심 API의 저수준 구현을 제공합니다.
- 엔진은 dart:ui를 통해 프레임워크에 노출됩니다.
- 임베더 API를 사용하여 특정 플랫폼과 통합합니다.

### 4. Embedder
- 렌더링, 접근성, 사용자 입력과 같은 플랫폼 종속적인 서비스를 제어합니다.

### 5. Runnder
- 임베더의 특정 플랫폼 API를 플러터에서 실행 가능한 패키지로 구성합니다.