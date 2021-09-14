# 프로젝트 매니저

프로젝트의 CRUD 및 Drag and Drop을 이용한 상태 변경을 지원하고, 디스크 저장 및 REST API를 통해 프로젝트 데이터를 관리할 수 있는 iPad 앱

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

<img src="https://user-images.githubusercontent.com/69730931/133176854-690ca2bc-6a01-4568-81d6-2045e0fe6baf.gif" alt="marketItemListView" width="600"/>

<img src="https://user-images.githubusercontent.com/69730931/133178833-f53cf030-0285-4e99-931f-1e45497b37c8.gif" alt="marketItemListView" width="600"/>

---

# 1. 프로젝트 개요

## MVVM

향후 기능 수정 및 추가가 이루어지더라도 요구한 기능 명세에 따라 동작함을 보장하기 위해 MVVM 아키텍쳐를 적용하여 뷰-로직을 분리 후 각 View Model에 대해 유닛테스트를 수행하였습니다.

## 코드를 통한 레이아웃 구성

각 View 요소가 어떠한 속성을 가지고 초기화되어 있고, auto-layout을 통해 View들 간 어떠한 제약 관계를 가지고 있는지를 명확히 표현하기 위해 스토리보드 대신 코드를 통해 UI를 구성하였습니다.

## 적용된 기술 스택 일람

| Category            | Stacks                         |
| ------------------- | ------------------------------ |
| UI                  | - UIKit                        |
| Networking          | - URLSession                   |
| Encoding / Decoding | - JSONEncoder<br>- JSONDecoder |
| Persistent storing  | - CoreData                     |
| Network Monitoring  | - Network                      |
| Test                | - XCTest                       |

# 2. 기능

## [Drag and Drop을 통한 프로젝트 상태 변경 (구현 방식 바로가기)](#drag-and-drop을-통한-프로젝트-상태-변경-기능으로-돌아가기)
Drag and Drop 동작으로 등록한 프로젝트를의 상태를 변경할 수 있습니다.

![ezgif com-rotate](https://user-images.githubusercontent.com/69730931/133181057-17b92f09-b576-4bb9-9dfc-9b710eedb6ee.gif)


## [REST API를 통해 원격 환경에 프로젝트 실시간 반영 (구현 방식 바로가기)](#rest-api를-통해-원격-환경에-프로젝트-실시간-반영-기능으로-돌아가기)
네트워크가 가용한 환경에서 수행한 프로젝트 생성, 수정, 삭제 작업이 서버 DB에 즉시 반영됩니다.

<img width="325" alt="image" src="https://user-images.githubusercontent.com/69730931/133181697-949aa818-bea6-4b00-8df0-95ba6817a0b0.png"> <img width="600" alt="image" src="https://user-images.githubusercontent.com/69730931/133186183-609bf178-2843-495f-81c8-9a2ab57b4ebe.png">


## [재설치 시 REST API를 통해 기존 데이터 불러오기 (구현 방식 바로가기)](#재설치-시-rest-api를-통해-기존-데이터-불러오기-기능으로-돌아가기)
서버 DB에 저장된 기존 프로젝트가 있을 경우 로컬에 불러와 기기의 디스크에 저장합니다.

![ezgif com-rotate-2](https://user-images.githubusercontent.com/69730931/133182262-dac8df61-c293-4cf7-aaf4-11612b7660c9.gif)


## [네트워크가 연결되지 않은 상태에서 수행한 작업을 재연결 시 원격 환경에 일괄 반영 (구현 방식 바로가기)](#네트워크가-연결되지-않은-상태에서-수행한-작업을-재연결-시-원격-환경에-일괄-반영-기능으로-돌아가기)
네트워크가 연결되지 않은 상태에서 작업한 내용은 네트워크가 가용할 때까지 요청을 지연하여 재연결 시 수행한 작업을 서버에 전달하여 서버 DB와 동기화합니다.

![ezgif com-resize-5](https://user-images.githubusercontent.com/69730931/133189300-28584790-5dca-4810-9d1a-4666b6f88ae6.gif)

작업 후 네트워크 연결 전 초기 서버 DB 상태: 프로젝트 없음

![image](https://user-images.githubusercontent.com/69730931/133189014-1e44d97a-5200-44d9-b24e-5227a444c4fc.png)

네트워크 재연결 후 서버 DB 상태: 기기 데이터와 동기화

![image](https://user-images.githubusercontent.com/69730931/133188872-dff4a45f-7c6b-4d0d-a78a-9fb3c8cbdd77.png)


## [네트워크 연결되지 않은 경우 알림 표시 (구현 방식 바로가기)](#네트워크-연결되지-않은-경우-알림-표시-기능으로-돌아가기)
네트워크가 연결되지 않은 경우 사용자가 인식할 수 있도록 알림을 표시합니다.

<img width="600" alt="image" src="https://user-images.githubusercontent.com/69730931/133189430-c0139ea3-1ad0-4b5c-8779-4a1aa71680fd.png">


## [프로젝트 작업 내용을 실시간으로 디스크에 반영 (구현 방식 바로가기)](#프로젝트-작업-내용을-실시간으로-디스크에-반영-기능으로-돌아가기)
프로젝트 생성, 수정, 상태 변경, 삭제 작업은 수행되는 즉시 디스크 데이터에 반영됩니다.

![ezgif com-resize-6](https://user-images.githubusercontent.com/69730931/133190772-cd22e68c-f509-4df5-9101-0b7a1fbce5ee.gif)


## [재실행 시 디스크에서 데이터 불러오기 (구현 방식 바로가기)](#재실행-시-디스크에서-데이터-불러오기-기능으로-돌아가기)
앱이 재실행되면 기기의 디스크로부터 기존 데이터를 불러옵니다.

![ezgif com-rotate-4](https://user-images.githubusercontent.com/69730931/133190549-0f386309-21bd-45e5-8aca-488c87e0c49a.gif)


## [프로젝트 추가 (구현 방식 바로가기)](#프로젝트-추가-기능으로-돌아가기)
프로젝트를 추가하면 to-do 목록에 추가되고, 서버 DB에 추가한 프로젝트가 저장됩니다.

![ezgif com-resize-4](https://user-images.githubusercontent.com/69730931/133187066-c8d6d87d-cb00-4b77-bd37-a8a29b936f5b.gif)

![image](https://user-images.githubusercontent.com/69730931/133186753-07e1ac6d-7b0d-4b6a-a396-0f4ce19b27e5.png)


## [프로젝트 상세 설명 최대 글자수 제한 (구현 방식 바로가기)](#프로젝트-상세-설명-최대-글자수-제한-기능으로-돌아가기)
최대 글자수를 초과하려하면 짧은 시간 동안 알림을 표시합니다.

![ezgif com-rotate-5](https://user-images.githubusercontent.com/69730931/133191421-b34aabae-f286-486c-8ca7-8250b8006ba1.gif)


## [프로젝트-제목 누락 알림 (구현 방식 바로가기)](#프로젝트-제목-누락-알림-기능으로-돌아가기)
프로젝트 추가 또는 수정 시 제목이 누락되면 알림을 표시합니다.

![ezgif com-rotate-6](https://user-images.githubusercontent.com/69730931/133192152-169ac3ac-ba42-4407-8bbd-93d7f3641526.gif)


## [프로젝트 수정 (구현 방식 바로가기)](#프로젝트-수정-기능으로-돌아가기)
프로젝트를 탭하여 `Edit` 모드로 변경하면 제목, 마감기한과 상세 내용을 수정할 수 있습니다.

![ezgif com-rotate-7](https://user-images.githubusercontent.com/69730931/133192524-654d7395-85ff-46e4-9b8b-76055f922b8a.gif)


## [Swipe action을 통한 프로젝트 삭제 (구현 방식 바로가기)](#swipe-action을-통한-프로젝트-삭제-기능으로-돌아가기)
프로젝트를 왼쪽으로 스와이프하여 삭제할 수 있습니다.

![ezgif com-resize-7](https://user-images.githubusercontent.com/69730931/133192685-7628fe69-f8fa-4e55-b0cc-d6508f5ea99e.gif)


## [작업 이력 보기 (구현 방식 바로가기)](#작업-이력-보기-기능으로-돌아가기)
좌측 상단의 `History` 버튼을 통해 프로젝트 추가, 수정, 상태 변경 및 삭제와 같이 수행했던 작업을 확인할 수 있습니다.

<img width="600" alt="image" src="https://user-images.githubusercontent.com/69730931/133193744-6cc014d1-fd13-4f62-ae6b-49239cd24762.png">

## [언어 설정에 따른 날짜 표현 방식 변경 (구현 방식 바로가기)](#언어-설정에-따른-날짜-표현-방식-변경-기능으로-돌아가기)
사용자가 설정한 선호 언어에 따라 날짜 표기 방식을 변경합니다.

아래는 시스템 설정을 영문으로 하였을 때의 예시입니다.

![image](https://user-images.githubusercontent.com/69730931/133193850-87c51d9e-74c1-46d5-9f78-de4d24e8630b.png)

## [기한이 지난 프로젝트 강조 (구현 방식 바로가기)](#기한이-지난-프로젝트-강조-기능으로-돌아가기)
마감 기한이 지난 프로젝트는 날짜를 붉은색으로 표시하여 기한이 지났음을 강조합니다.

![image](https://user-images.githubusercontent.com/69730931/133193885-d8be2b1f-e108-4bbc-8d3f-af5880aab23e.png)


# 3. 설계 및 구현

## [Drag and Drop을 통한 프로젝트 상태 변경 (기능으로 돌아가기)](#drag-and-drop을-통한-프로젝트-상태-변경-구현-방식-바로가기)



## [REST API를 통해 원격 환경에 프로젝트 실시간 반영 (기능으로 돌아가기)](#rest-api를-통해-원격-환경에-프로젝트-실시간-반영-구현-방식-바로가기)

 

## [재설치 시 REST API를 통해 기존 데이터 불러오기 (기능으로 돌아가기)](#재설치-시-rest-api를-통해-기존-데이터-불러오기-구현-방식-바로가기)



## [네트워크가 연결되지 않은 상태에서 수행한 작업을 재연결 시 원격 환경에 일괄 반영 (기능으로 돌아가기)](#네트워크가-연결되지-않은-상태에서-수행한-작업을-재연결-시-원격-환경에-일괄-반영-구현-방식-바로가기)



## [네트워크 연결되지 않은 경우 알림 표시 (기능으로 돌아가기)](#네트워크-연결되지-않은-경우-알림-표시-구현-방식-바로가기)



## [프로젝트 작업 내용을 실시간으로 디스크에 반영 (기능으로 돌아가기)](#프로젝트-작업-내용을-실시간으로-디스크에-반영-구현-방식-바로가기)



## [재실행 시 디스크에서 데이터 불러오기 (기능으로 돌아가기)](#재실행-시-디스크에서-데이터-불러오기-구현-방식-바로가기)



## [프로젝트 추가 (기능으로 돌아가기)](#프로젝트-추가-구현-방식-바로가기)



## [프로젝트 상세 설명 최대 글자수 제한 (기능으로 돌아가기)](#프로젝트-상세-설명-최대-글자수-제한-구현-방식-바로가기)



## [프로젝트 제목 누락 알림 (기능으로 돌아가기)](#프로젝트-제목-누락-알림-구현-방식-바로가기)



## [프로젝트 수정 (기능으로 돌아가기)](#프로젝트-수정-구현-방식-바로가기)



## [Swipe action을 통한 프로젝트 삭제 (기능으로 돌아가기)](#swipe-action을-통한-프로젝트-삭제-구현-방식-바로가기)



## [작업 이력 보기 (기능으로 돌아가기)](#작업-이력-보기-구현-방식-바로가기)



## [언어 설정에 따른 날짜 표현 방식 변경 (기능으로 돌아가기)](#언어-설정에-따른-날짜-표현-방식-변경-구현-방식-바로가기)



## [기한이 지난 프로젝트 강조 (기능으로 돌아가기)](#기한이-지난-프로젝트-강조-구현-방식-바로가기)


## 동적 TableView Cell 높이 구현

# 4. 테스트

## 네트워크에 의존하지 않는 테스트 구현

# 5. Trouble shooting

## 동일 TableView 내에서 Drag and Drop이 되지 않는 문제


## Core data 모델 인스턴스 삭제 시 접근이 불가능한 문제

soft delete
