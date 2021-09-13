# 프로젝트 매니저
프로젝트의 CRUD 및 Drag and Drop을 이용한 상태 변경을 지원하고, 디스크 캐싱 및 REST API를 통해 데이터를 관리할 수 있는 iPad 앱

# Table of Contents
- [1. 프로젝트 개요](#1-프로젝트-개요)
  + [MVVM](#mvvm)
  + [코드를 통한 레이아웃 구성](#코드를-통한-레이아웃-구성)
  + [적용된 기술 스택 일람](#적용된-기술-스택-일람)
- [2. 기능](#2-기능)
- [3. 설계 및 구현](#3-설계-및-구현)
- [4. 테스트](#4-테스트)
  + [네트워크에 의존하지 않는 테스트 구현](#네트워크에-의존하지-않는-테스트-구현)
- [5. Trouble shooting](#5-trouble-shooting)

---

// 작동 예시

---

# 1. 프로젝트 개요

## MVVM
향후 기능 수정 및 추가가 이루어지더라도 요구한 기능 명세에 따라 동작함을 보장하기 위해 MVVM 아키텍쳐를 적용하여 뷰-로직을 분리 후 각 View Model에 대해 유닛테스트를 수행하였습니다.

## 코드를 통한 레이아웃 구성
각 View 요소가 어떠한 속성을 가지고 초기화되어 있고, auto-layout을 통해 View들 간 어떠한 제약 관계를 가지고 있는지를 명확히 표현하기 위해 스토리보드 대신 코드를 통해 UI를 구성하였습니다.

## 적용된 기술 스택 일람
| Category            | Stacks                         |
|---------------------|--------------------------------|
| UI                  | - UIKit                        |
| Networking          | - URLSession                   |
| Encoding / Decoding | - JSONEncoder<br>- JSONDecoder |
| Persistent storing  | - CoreData                     |
| Network Monitoring  | - Network                      |
| Test                | - XCTest                       |

# 2. 기능

# 3. 설계 및 구현

# 4. 테스트

## 네트워크에 의존하지 않는 테스트 구현

# 5. Trouble shooting
