# 프로젝트 매니저

프로젝트의 CRUD 및 Drag and Drop을 이용한 상태 변경을 지원하고, 디스크 저장 및 REST API를 통해 프로젝트 데이터를 관리할 수 있는 iPad 앱

# Table of Contents

- [1. 프로젝트 개요](#1-프로젝트-개요)

  + [페어 프로그래밍](#페어-프로그래밍)

  - [MVVM](#mvvm)
  - [코드를 통한 레이아웃 구성](#코드를-통한-레이아웃-구성)
  - [적용된 기술 스택 일람](#적용된-기술-스택-일람)

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

## 페어 프로그래밍

본 프로젝트는 2 인이 함께 수행한 프로젝트로 구조 설계부터 구현, 테스트까지 서로 의논하며 프로그램을 작성하였습니다. @duckbok

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

네트워크가 연결된 환경에서 수행한 프로젝트 생성, 수정, 삭제 작업이 서버 DB에 즉시 반영됩니다.

<img width="325" alt="image" src="https://user-images.githubusercontent.com/69730931/133181697-949aa818-bea6-4b00-8df0-95ba6817a0b0.png"> <img width="600" alt="image" src="https://user-images.githubusercontent.com/69730931/133186183-609bf178-2843-495f-81c8-9a2ab57b4ebe.png">


## [재설치 시 REST API를 통해 기존 데이터 불러오기 (구현 방식 바로가기)](#재설치-시-rest-api를-통해-기존-데이터-불러오기-기능으로-돌아가기)

서버 DB에 저장된 기존 프로젝트가 있을 경우 로컬에 불러와 기기의 디스크에 저장합니다.

![ezgif com-rotate-2](https://user-images.githubusercontent.com/69730931/133182262-dac8df61-c293-4cf7-aaf4-11612b7660c9.gif)


## [네트워크가 연결되지 않은 상태에서 수행한 작업을 재연결 시 원격 환경에 일괄 반영 (구현 방식 바로가기)](#네트워크가-연결되지-않은-상태에서-수행한-작업을-재연결-시-원격-환경에-일괄-반영-기능으로-돌아가기)

네트워크가 연결되지 않은 상태에서 작업한 내용은 네트워크가 재연결될 때까지 요청을 지연하여 재연결 시 수행한 작업을 서버에 전달하여 서버 DB와 동기화합니다.

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



## [기한이 지난 프로젝트 강조 (구현 방식 바로가기)](#기한이-지난-프로젝트-강조-기능으로-돌아가기)

마감 기한이 지난 프로젝트는 날짜를 붉은색으로 표시하여 기한이 지났음을 강조합니다.

![image](https://user-images.githubusercontent.com/69730931/133193885-d8be2b1f-e108-4bbc-8d3f-af5880aab23e.png)


# 3. 설계 및 구현

최종적으로 활용되는 타입이 아닌 경우 타입 간의 느슨한 결합을 위해 프로토콜을 통해 추상화하여 의존성 주입이 가능하도록 구성하였습니다. 이를 통해 프로토콜을 통해 요구된 인터페이스를 가진 타입을 설계함으로써 테스트를 수행합니다. `CoreDataRepository`와 같은 경우 앱 내에서 유일한 디스크 데이터 저장 책임 타입임을 확실히하기 위해 싱글턴 객체를 사용하며, in-memory 타입의 `NSPersistentContainer`를 가진 Mock 인스턴스를 주입함으로써 유닛 테스트를 수행합니다.

Reference semantics 적용이 필요하거나, escaping closure로 인해 mutating self가 강제되는 경우를 제외하고는 최대한 값타입으로 설계하여 메모리 관리로부터 자유롭게끔 구성하였습니다.

![image](https://user-images.githubusercontent.com/69730931/133291123-90d63837-4cae-4d1d-8af2-6676dad47e30.png)

## 화면 구성

### PMViewController (PM: Project Manager)

상태별 Task 목록을 확인하거나 추가, 수정 작업으로 이동할 수 있으며, Drag and Drop을 통해 Task의 상태를 변경하거나 개별 Task에 swipe 액션을 통해 삭제할 수 있는 인터페이스를 제공합니다. `History` 를 통해 Task의 변경이력을 확인할 수 있는 HistoryViewController를 표시할 수 있습니다.



![image](https://user-images.githubusercontent.com/69730931/133294960-1f79f4d1-4de8-4e10-9e47-9872ed1ab9cf.png)



### TaskEditViewController

Task 신규 등록 또는 수정을 할 수 있는 화면으로, 수정 시에는 좌측 상단의 `Edit` 버튼을 활성화해야 수정작업이 가능합니다.



![image](https://user-images.githubusercontent.com/69730931/133296180-faea8a50-8e7d-4f9a-9dcf-54800705401b.png)



### HistoryViewController

수행한 작업 이력을 확인할 수 있는 팝업 형식의 화면입니다.



![image](https://user-images.githubusercontent.com/69730931/133297773-606a9b96-37fa-420a-806f-b109fc267dee.png)

## [Drag and Drop을 통한 프로젝트 상태 변경 (기능으로 돌아가기)](#drag-and-drop을-통한-프로젝트-상태-변경-구현-방식-바로가기)

Drag and Drop 작업을 위해 구현한 프로토콜 요구사항은 모델 타입은 다음과 같습니다.

-  Model (`Task`): `NSProviderReading`, `NSProviderWriting`
- TableView:
  + 타 TableView 간 이동: `UITableViewDragDelegate`, `UITableViewDropDelegate`
  + 동일 TableView 간 이동: `UITableViewDataSource`



Model에서 해당 프로토콜을 준수하는 이유는 아래 그림과 같이 Drag and Drop 작업 시 `Data` 와 같이 원하는 형태 (여기서는 JSON 형식 Data 타입)로 타입 변환을 해주는 과정이 포함되기 때문입니다.

<img width="600" alt="image" src="https://user-images.githubusercontent.com/69730931/133287629-4448ebc9-e7ca-469e-bd14-e8c077cb9c1f.png">

```swift
import Foundation
import MobileCoreServices

extension Task: NSItemProviderReading {

    public static var readableTypeIdentifiersForItemProvider: [String] {
        return [kUTTypeJSON as String]
    }

    public static func object(withItemProviderData data: Data, typeIdentifier: String) throws -> Task {
        if typeIdentifier == kUTTypeJSON as String {
            let droppedTask = try JSONDecoder().decode(Task.self, from: data)
            return droppedTask
        } else {
            throw PMError.invalidTypeIdentifier
        }
    }
}

extension Task: NSItemProviderWriting {

    public static var writableTypeIdentifiersForItemProvider: [String] {
        return [kUTTypeJSON as String]
    }

    public func loadData(
        withTypeIdentifier typeIdentifier: String,
        forItemProviderCompletionHandler completionHandler: @escaping (Data?, Error?) -> Void) -> Progress? {
        if typeIdentifier == kUTTypeJSON as String {
            guard let draggedTask = try? JSONEncoder().encode(self) else {
                completionHandler(nil, PMError.cannotEncodeToJSON(#function))
                return nil
            }
            completionHandler(draggedTask, nil)
        } else {
            completionHandler(nil, PMError.invalidTypeIdentifier)
        }

        return nil
    }
}
```



타 TableView 간 Drag and Drop 작업은 아래와 같은 방식으로 구현하였습니다.

```swift
import UIKit

// MARK: - UITableViewDragDelegate

extension PMViewController: UITableViewDragDelegate {

    func tableView(_ tableView: UITableView,
                   itemsForBeginning session: UIDragSession,
                   at indexPath: IndexPath) -> [UIDragItem] {
        guard let stateTableView = tableView as? StateTableView,
              let state = stateTableView.state else { return [] }

        return dragItem(with: state, at: indexPath.row)
    }

    private func dragItem(with state: Task.State, at index: Int) -> [UIDragItem] {
        guard let draggedTask = viewModel.task(from: state, at: index) else { return [] }
        let itemProvider = NSItemProvider(object: draggedTask)
        let dragItem = UIDragItem(itemProvider: itemProvider)
        return [dragItem]
    }
}

// MARK: - UITableViewDropDelegate

extension PMViewController: UITableViewDropDelegate {

    func tableView(_ tableView: UITableView, canHandle session: UIDropSession) -> Bool {
        return session.canLoadObjects(ofClass: Task.self) && session.items.count == 1
    }

    func tableView(_ tableView: UITableView,
                   dropSessionDidUpdate session: UIDropSession,
                   withDestinationIndexPath destinationIndexPath: IndexPath?) -> UITableViewDropProposal {
        let dropProposal = UITableViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
        return dropProposal
    }

    func tableView(_ tableView: UITableView, performDropWith coordinator: UITableViewDropCoordinator) {
        let destinationIndexPath: IndexPath
        let dropItem: UITableViewDropItem? = coordinator.items.first

        if let indexPath = coordinator.destinationIndexPath {
            destinationIndexPath = indexPath
        } else {
            let row = tableView.numberOfRows(inSection: .zero)
            destinationIndexPath = IndexPath(row: row, section: .zero)
        }

        dropItem?.dragItem.itemProvider.loadObject(ofClass: Task.self) { [weak self] (data, error) in
            guard let task = data as? Task,
                  let stateTableView = tableView as? StateTableView,
                  let destinationState = stateTableView.state,
                  error == nil else { return }

            let sourceState = task.taskState
            self?.viewModel.move(task, to: destinationState, at: destinationIndexPath.row)
            self?.historyViewModel.create(history: History(method: .moved(title: task.title,
                                                                          sourceState: sourceState,
                                                                          destinationState: task.taskState)))
        }
    }
}

```



동일한 TableView 내에서의 이동은 아래와 같이 `UITableViewDataSource` 메서드를 통해 수행합니다.

```swift
// MARK: - UITableViewDataSource

extension PMViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        guard let stateTableView = tableView as? StateTableView,
              let state = stateTableView.state else { return }

        viewModel.move(in: state, from: sourceIndexPath.row, to: destinationIndexPath.row)
    }
}
```



## [REST API를 통해 원격 환경에 프로젝트 실시간 반영 (기능으로 돌아가기)](#rest-api를-통해-원격-환경에-프로젝트-실시간-반영-구현-방식-바로가기)

`Task` 를 추가, 수정, 상태 변경 또는 삭제하면 변경사항이 실시간으로 서버 DB에 반영됩니다. 새 `Task` 가 추가되었을 때의 작업 흐름을 살펴보겠습니다.



먼저, 추가 작업은 `TaskEditViewController` 의 View 요소에서 `Task` 의 내용을 완성하고 Done 버튼을 누름으로써 실행됩니다.

```swift
@objc private func doneButtonTapped() {
    guard let title = titleTextField.text,
          let body = bodyTextView.text else { return }

    guard !title.isEmpty else {
        showTitleRequiredAlert()
        return
    }

    switch editMode {
    case .add:
        viewModel.create(title: title, dueDate: dueDatePicker.date, body: body)
    case .update:
        viewModel.update(title: title, dueDate: dueDatePicker.date, body: body)
    default:
        break
    }

    dismiss(animated: true)
}
```

Done 버튼을 누르면 위의 메서드는 `TaskEditViewModel` 타입인 `viewModel`을 통해 `coreDataRepository` 에 새로운 `Task` 를 추가하며 view의 업데이트 클로저를 실행합니다.

```swift
mutating func create(title: String, dueDate: Date, body: String) {
    guard let date = dueDate.date else { return }
    let body: String? = body.isEmpty ? nil : body

    if let task = try? coreDataRepository.create(title: title, body: body, dueDate: date, state: .todo) {
        self.task = task
        created?(task)
    }
}
```

이후 View와 바인딩된 `created?(task)` 클로저는 `TaskEditViewControllerDelegate` 타입 delegate의 메서드를 호출하여 `TaskViewModel` 에 새로운 `task` 를 추가합니다.

```swift
private func bindWithViewModel() {
    viewModel.updated = { (indexPath, task) -> Void in
        self.delegate?.taskWillUpdate(task, indexPath)
    }

    viewModel.created = { (task) -> Void in
        self.delegate?.taskWillAdd(task)
    }
}

// MARK: - TaskEditViewControllerDelegate

extension PMViewController: TaskEditViewControllerDelegate {

    func taskWillAdd(_ task: Task) {
        viewModel.add(task)
        historyViewModel.create(history: History(method: .added(title: task.title)))
    }
}
```

계속해서 `TaskViewModel`은 추가된 `task`를 `NetworkRepository`로 전달합니다.

```swift
func add(_ task: Task) {
    let addedIndex: Int = count(of: .todo)
    taskList[.todo].append(task)
    added?(addedIndex)
    post(task)
}


private func post(_ task: Task) {
    networkRepository.post(task: task) { [weak self] result in
        switch result {
        case .success:
            self?.coreDataRepository.deleteFromPendingTaskList(task)
        case .failure(let error):
            self?.coreDataRepository.insertFromPendingTaskList(task)
            print(error)
        }
    }
}
```

마지막으로 `NetworkRepository`는 전달받은 `task`를 인코딩하여 서버에 전송함으로써 서버 DB에 신규 `task`를 추가하도록 만듭니다.

```swift
func post(task: Task, completion: @escaping (Result<ResponseTask, PMError>) -> Void) {
    guard let url = URL(string: base + Endpoint.post) else { return }
    guard let httpBody = try? encoder.encode(PostTask(by: task)) else {
        completion(.failure(.cannotEncodeToJSON(#function)))
        return
    }

    let request = URLRequest(url: url, method: .post, contentType: .json, body: httpBody)

    session.dataTask(with: request) { [weak self] data, response, error in
        self?.checkSessionSucceed(error, response, data) { result in
            switch result {
            case .success(let succeed):
                guard let data = succeed.data else {
                    completion(.failure(.dataNotFound))
                    return
                }
                guard let responseTask = try? self?.decoder.decode(ResponseTask.self, from: data) else {
                    completion(.failure(.decodingFailed))
                    return
                }

                completion(.success(responseTask))
            case .failure(let pmError):
                completion(.failure(pmError))
            }
        }
    }.resume()
}
```



## [네트워크가 연결되지 않은 상태에서 수행한 작업을 재연결 시 원격 환경에 일괄 반영 (기능으로 돌아가기)](#네트워크가-연결되지-않은-상태에서-수행한-작업을-재연결-시-원격-환경에-일괄-반영-구현-방식-바로가기)

`CoreData`의 데이터 모델에는 아래 그림과 같이 `Task` 모델타입과 `PendingTaskList`가 Entity로 정의되어 있습니다.  이들은 relationship으로 연결되어 있고, `PendingTaskList`는 이름에 걸맞게 `Task`의 배열을 가지도록 설계되어 있습니다. 

<img width="500" alt="image" src="https://user-images.githubusercontent.com/69730931/133314450-b1fd94f2-db91-4c58-8ddf-e7056bd4e3e5.png">  <img width="500" alt="image" src="https://user-images.githubusercontent.com/69730931/133314491-1022ead2-133d-44d7-8bb4-1db4cc2ea2f2.png">

`PendingTaskList`는 `NetworkRepository`를 통해 서버에 `POST`, `PATCH`, `DELETE` 요청을 보냈지만 네트워킹에 실패한다면 아직 반영되지 못한 변경사항이라는 의미에서 해당 `task`를 `PendingTaskList`에 추가합니다. 

```swift
// MARK: - TaskViewModel

private func post(_ task: Task) {
    networkRepository.post(task: task) { [weak self] result in
        switch result {
        case .success:
            self?.coreDataRepository.deleteFromPendingTaskList(task)
        case .failure(let error):
            self?.coreDataRepository.insertFromPendingTaskList(task)
            print(error)
        }
    }
}

private func patch(_ task: Task) {
    networkRepository.patch(task: task) { [weak self] result in
        switch result {
        case .success:
            print("Patch Succeed!")
            self?.coreDataRepository.deleteFromPendingTaskList(task)
        case .failure(let error):
            self?.coreDataRepository.insertFromPendingTaskList(task)
            print(error)
        }
    }
}

private func delete(_ removedTask: Task) {
    networkRepository.delete(task: removedTask) { [weak self] result in
        switch result {
        case .success(let id):
            self?.coreDataRepository.delete(removedTask.objectID)
            self?.coreDataRepository.deleteFromPendingTaskList(removedTask)
            print("Deletion succeed! ID: \(id)")
        case .failure(let error):
            self?.coreDataRepository.insertFromPendingTaskList(removedTask)
            print(error)
        }
    }
}
```



이후 `Network` 프레임워크의 `NWPathMonitor`를 통해 네트워크 연결 상황을 감시하는 `PMViewController`가 다시 네트워크가 연결되었음을 감지하여 `TaskViewModel`의 `networkDidConnect()` 메서드를 호출하여 미루어둔 작업을 처리하는 `handlePendingTasks(responseTasks:)`를 실행합니다.

```swift
private(set) var isConnected: Bool = false {
    didSet {
        isConnected ? viewModel.networkDidConnect() : viewModel.networkDidDisconnect()
        showNetworkStatus(at: isConnected)
    }
}

func networkDidConnect() {
    if !coreDataRepository.isEmpty {
        taskList = coreDataRepository.read()
        fetchingFinished?()
    }

    networkRepository.fetchTasks { [weak self] result in
        guard let self = self else { return }
        switch result {
        case .success(let responseTasks):
            if self.coreDataRepository.isEmpty {
                self.taskList = TaskList(context: self.coreDataRepository.coreDataStack.context,
                                         responseTasks: responseTasks)
                self.coreDataRepository.coreDataStack.saveContext()
            }

            self.fetchingFinished?()
            self.handlePendingTasks(responseTasks: responseTasks)
        case .failure(let error):
            print(error)
        }
    }
}
```



마지막으로 `networkDidConnect()` 내  `fetchTasks(completion:)` 메서드를 통해 서버로부터 받아온 `task` 들을 현재 로컬 환경에 있는 `task` 들과 비교해 반영되지 않은 변경사항을 추적하여 서버에 확인된 변경사항을 반영 요청합니다. 이러한 비교 방식을 통해 변경이 일어난 `task` 들만 파악하고, 네트워크에 연결되지 않았던 동안 얼마나 많은 변경 사항이 생겼는지에 관계없이 `task`의 최종 상태만 파악하여 불필요한 요청을 절감합니다.

```swift
private func handlePendingTasks(responseTasks: [ResponseTask]) {
    coreDataRepository.readPendingTasks()?.forEach { task in
        let responseTaskIDs = responseTasks.map { $0.id }
        let isCreated: Bool = !responseTaskIDs.contains(task.id) && !task.isRemoved
        let isPatched: Bool = !isCreated && !task.isRemoved
        let isDeleted: Bool = !isCreated && task.isRemoved

        if isCreated {
            post(task)
        } else if isPatched {
            patch(task)
        } else if isDeleted {
            delete(task)
        }
    }
}
```



## [네트워크 연결되지 않은 경우 알림 표시 (기능으로 돌아가기)](#네트워크-연결되지-않은-경우-알림-표시-구현-방식-바로가기)

네트워크 상태 감지는 아래와 같이 `PMViewController`가 `Network` 프레임워크의 `NWPathMonitor`를 이용하여 수행합니다.

```swift
// MARK: Network Monitoring

private func monitorNetwork() {
    let networkMonitor = NWPathMonitor()

    networkMonitor.pathUpdateHandler = { [weak self] nwPath in
        switch nwPath.status {
        case .satisfied:
            self?.isConnected = true
        case .unsatisfied:
            self?.isConnected = false
        default:
            break
        }
    }
    let networkQueue = DispatchQueue(label: Style.networkQueueName)
    networkMonitor.start(queue: networkQueue)
}
```

 감시 중 네트워크의 연결이 끊어지면 `isConnected` 변수가 변경되며 프로퍼티 옵저버를 통해 `showNetworkStatus(at:)` 메서드와 `TaskViewModel`의 `networkDidDisconnect()` 메서드를 호출합니다.

```swift
private(set) var isConnected: Bool = false {
    didSet {
        isConnected ? viewModel.networkDidConnect() : viewModel.networkDidDisconnect()
        showNetworkStatus(at: isConnected)
    }
}
```

`showNetworkStatus`는 네트워크 연결이 끊어졌다는 문구를 나타내는  `networkStatusLabel`의 `isHidden` 프로퍼티를 `isConnected` 프로퍼티와 동일하게 `false`로 변경함으로써 화면에 나타나게 합니다.

```swift
private func showNetworkStatus(at status: Bool) {
    DispatchQueue.main.async {
        UIView.animate(withDuration: Style.networkStatusLabelPresentTime) { [weak self] in
            self?.networkStatusLabel.isHidden = status
        }
    }
}
```



## [프로젝트 작업 내용을 실시간으로 디스크에 반영 (기능으로 돌아가기)](#프로젝트-작업-내용을-실시간으로-디스크에-반영-구현-방식-바로가기)

`task`를 추가하는 시나리오를 따라 설명하겠습니다. 먼저 `TaskEditViewController`의 Done 버튼을 통해 `task`의 추가 작업이 실행됩니다.

```swift
@objc private func doneButtonTapped() {
    guard let title = titleTextField.text,
          let body = bodyTextView.text else { return }

    guard !title.isEmpty else {
        showTitleRequiredAlert()
        return
    }

    switch editMode {
    case .add:
        viewModel.create(title: title, dueDate: dueDatePicker.date, body: body)
    case .update:
        viewModel.update(title: title, dueDate: dueDatePicker.date, body: body)
    default:
        break
    }

    dismiss(animated: true)
}
```

이후 `TaskEditViewModel`의 `create(title:dueDate:body:)` 메서드가 실행되며 `coreDataRepository`의 `create(title:body:dueDate:state:)`를 호출합니다.

```swift
mutating func create(title: String, dueDate: Date, body: String) {
    guard let date = dueDate.date else { return }
    let body: String? = body.isEmpty ? nil : body

    if let task = try? coreDataRepository.create(title: title, body: body, dueDate: date, state: .todo) {
        self.task = task
        created?(task)
    }
}
```

마지막으로, `CoreDataRepository`는 `CoreDataStack`을 통해 stack의 `context`에 입력받은 내용을 저장함으로써 디스크에 신규 `task` 추가 작업이 완료됩니다.

```swift
mutating func create(title: String, body: String? = nil, dueDate: Date, state: Task.State) throws -> Task {
    let task = Task(context: coreDataStack.context, title: title, body: body, dueDate: dueDate, state: state)
    coreDataStack.saveContext()
    return task
}
```



## [재실행 시 디스크에서 데이터 불러오기 (기능으로 돌아가기)](#재실행-시-디스크에서-데이터-불러오기-구현-방식-바로가기)

앱이 실행되면 네트워크에 연결되어 있거나, 그렇지 않은 상황 두 가지 경우가 있습니다. 연결이 있는 상황 또는 없는 상황에 맞게 `networkDidConnect()` 또는 `networkDidDisconnect()` 메서드가 실행되는데, 어떠한 경우에도 첫 번째 옵션은 로컬 디스크에 저장된 데이터를 불러오는 것입니다.



```swift
func networkDidConnect() {
    if !coreDataRepository.isEmpty {
        taskList = coreDataRepository.read()
        fetchingFinished?()
    }

    // 이후 networkRepository를 이용한 서버 DB fetching
    // ...
}

func networkDidDisconnect() {
    taskList = self.coreDataRepository.read()
    fetchingFinished?()
}
```



## [프로젝트 추가 (기능으로 돌아가기)](#프로젝트-추가-구현-방식-바로가기)

[이 내용](#프로젝트-작업-내용을-실시간으로-디스크에-반영-기능으로-돌아가기)을 참고하시기 바랍니다.



## [프로젝트 상세 설명 최대 글자수 제한 (기능으로 돌아가기)](#프로젝트-상세-설명-최대-글자수-제한-구현-방식-바로가기)

최대 글자수 도달 여부 판단은 아래와 같이 `UITextViewDelegate`의 `textView(_:shouldChangeTextIn:replacementText:)` 메서드를 통해 수행합니다. `originText`는 현재 textView에 작성된 텍스트를, `text`는 타이핑 또는 붙여넣기를 통해 입력하고자하는 텍스트를, `range`는 현재 커서에 의해 선택된 텍스트 블럭에 위치한 텍스트를 의미합니다. 현재 설정된 최대 글자수는 1,000 자입니다.

```swift
// MARK: - UITextViewDelegate

extension TaskEditViewController: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let originText: String = textView.text ?? ""
        let isUnderLimit: Bool = originText.count + (text.count - range.length) <= Style.bodyLengthLimit
        if !isUnderLimit {
            showMaxBodyLengthAlert()
        }

        return isUnderLimit
    }
}
```

상기 메서드의 반환이 `false`로 이루어지면 `textView`의 수정 작업이 거절되며, 그 이전 조건에 의해 `showMaxBodyLengthAlert()`가 실행되며 최대 글자수 초과 알림이 화면에 표시됩니다.

```swift
private func showMaxBodyLengthAlert() {
    let alert = UIAlertController(title: Style.maxBodyLengthAlertTitle,
                                  message: Style.maxBodyLengthAlertMessage,
                                  preferredStyle: .alert)
    present(alert, animated: true)
    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Style.maxBodyLengthAlertPresentTime) {
        alert.dismiss(animated: true)
    }
}
```

현재 이 알림의 표시 시간은 0.5초로 설정하였습니다.



## [프로젝트 제목 누락 알림 (기능으로 돌아가기)](#프로젝트-제목-누락-알림-구현-방식-바로가기)

`TaskEditViewController`에서 Done 버튼을 통해 `task` 추가 또는 수정 작업을 완료하려고 할 경우 아래의 `doneButtonTapped()` 메서드가 실행됩니다.

```swift
@objc private func doneButtonTapped() {
    guard let title = titleTextField.text,
          let body = bodyTextView.text else { return }

    guard !title.isEmpty else {
        showTitleRequiredAlert()
        return
    }

    switch editMode {
    case .add:
        viewModel.create(title: title, dueDate: dueDatePicker.date, body: body)
    case .update:
        viewModel.update(title: title, dueDate: dueDatePicker.date, body: body)
    default:
        break
    }

    dismiss(animated: true)
}
```

만약 Done 버튼을 탭하였을 때 `!title.empty` 조건이라면 `showTitleRequiredAlert()`가 실행되며 화면에 적절한 안내문구가 표시됩니다.

```swift
private func showTitleRequiredAlert() {
    let alert = UIAlertController(title: Style.titleRequiredAlertTitle,
                                  message: Style.titleRequiredAlertMessage,
                                  preferredStyle: .alert)
    let okAction = UIAlertAction(title: Style.okActionTitle, style: .default) { _ in
        alert.dismiss(animated: true)
    }
    alert.addAction(okAction)
    present(alert, animated: true)
}
```



## [프로젝트 수정 (기능으로 돌아가기)](#프로젝트-수정-구현-방식-바로가기)

`PMViewController`의 tableView에서 `task`를 선택하여 `TaskEditViewController`로 진입한 후 내용을 수정하여 Done 버튼을 탭하면 아래 메서드에서 `TaskEditViewModel`의 `update(title:dueDate:body:)` 메서드를 실행합니다.

```swift
@objc private func doneButtonTapped() {
    guard let title = titleTextField.text,
          let body = bodyTextView.text else { return }

    guard !title.isEmpty else {
        showTitleRequiredAlert()
        return
    }

    switch editMode {
    case .add:
        viewModel.create(title: title, dueDate: dueDatePicker.date, body: body)
    case .update:
        viewModel.update(title: title, dueDate: dueDatePicker.date, body: body)
    default:
        break
    }

    dismiss(animated: true)
}
```

`update(title:dueDate:body)`는 `coreDataRepository`를 통해 수정된 `task`를 디스크에 반영하고 View와 바인딩된 `updated?(indexPath, task)` 클로저를 통해 view를 업데이트 합니다.

```swift
mutating func update(title: String, dueDate: Date, body: String) {
    guard let task = task,
          let indexPath = indexPath else { return }

    let title: String? = (task.title == title) ? nil : title
    let dueDate: Date? = (task.dueDate == dueDate) ? nil : dueDate
    let body: String? = (task.body == body) ? nil : body

    let isChanged: Bool = title != nil || dueDate != nil || body != nil
    guard isChanged else { return }

    coreDataRepository.update(objectID: task.objectID, title: title, dueDate: dueDate, body: body)
    updated?(indexPath, task)
}
```

바인딩되어 있는 것은 `TaskEditViewControllerDelegate` 타입의 `taskWillUpdate(_:_:)` 메서드를 호출합니다.

```swift
private func bindWithViewModel() {
    viewModel.updated = { (indexPath, task) -> Void in
        self.delegate?.taskWillUpdate(task, indexPath)
    }

    viewModel.created = { (task) -> Void in
        self.delegate?.taskWillAdd(task)
    }
}
```

`taskWillUpdate(_:_:)` 메서드는 `TaskViewModel`의 `update(_:)` 를 호출하여 `networkRepository`를 통해 `PATCH` 작업을 요청합니다.

```swift
// MARK: - TaskEditViewControllerDelegate

extension PMViewController: TaskEditViewControllerDelegate {

    func taskWillUpdate(_ task: Task, _ indexPath: IndexPath) {
        viewModel.update(task)
        let stackView = stateStackViews.filter { $0.state == task.taskState }.first
        stackView?.stateTableView.reloadRows(at: [indexPath], with: .automatic)
    }
}

// MARK: - TaskViewModel

func update(_ task: Task) {
    patch(task)
}

private func patch(_ task: Task) {
    networkRepository.patch(task: task) { [weak self] result in
        switch result {
        case .success:
            print("Patch Succeed!")
            self?.coreDataRepository.deleteFromPendingTaskList(task)
        case .failure(let error):
            self?.coreDataRepository.insertFromPendingTaskList(task)
            print(error)
        }
    }
}
```



## [Swipe action을 통한 프로젝트 삭제 (기능으로 돌아가기)](#swipe-action을-통한-프로젝트-삭제-구현-방식-바로가기)

swipe action을 통해 특정 cell을 삭제하는 작업은 아래와 같이 `UITableViewDelegate`의 메서드로 구현 가능합니다.

```swift
// MARK: - UITableViewDelegate

extension PMViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView,
                   commit editingStyle: UITableViewCell.EditingStyle,
                   forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete,
              let stateTableView = tableView as? StateTableView,
              let state = stateTableView.state else { return }

        if let removedTitle = viewModel.remove(state: state, at: indexPath.row) {
            historyViewModel.create(history: History(method: .removed(title: removedTitle, sourceState: state)))
        }
    }
}
```

실제로 데이터를 삭제하는 작업은 `TaskViewModel`의 `remove(state:at:)` 메서드를 호출하며 수행됩니다.

```swift
/**
 지정한 위치의 Task를 삭제하고 이를 반환한다.

 - Parameter state: 삭제할 task가 위치한 상태
 - Parameter index: 삭제할 task의 상태 내 index
 */
@discardableResult
func remove(state: Task.State, at index: Int) -> String? {
    guard index < taskList[state].count else { return nil }

    let removedTitle: String = taskList[state][index].title
    let removedTask: Task = taskList[state].remove(at: index)
    coreDataRepository.softDelete(removedTask.objectID)
    removed?(state, index)
    delete(removedTask)
    return removedTitle
}
```

추가, 수정 작업과 마찬가지로 `networkRepository`를 통해 `DELETE` 요청을 함으로써 서버 DB로부터 데이터가 삭제됩니다.

```swift
private func delete(_ removedTask: Task) {
    networkRepository.delete(task: removedTask) { [weak self] result in
        switch result {
        case .success(let id):
            self?.coreDataRepository.delete(removedTask.objectID)
            self?.coreDataRepository.deleteFromPendingTaskList(removedTask)
            print("Deletion succeed! ID: \(id)")
        case .failure(let error):
            self?.coreDataRepository.insertFromPendingTaskList(removedTask)
            print(error)
        }
    }
}
```



## [작업 이력 보기 (기능으로 돌아가기)](#작업-이력-보기-구현-방식-바로가기)

작업 이력은 `HistoryViewController`를 통해 조회할 수 있습니다. 위에서 설명된 기능에서 일부 등장했지만, 작업이 수행할 때마다 `HistoryViewModel`의 `create(history:)` 메서드를 통해 `History`를 생성하여 `[History]` 타입의 `histories` 프로퍼티에 추가합니다.

```swift
// MARK: - TaskEditViewControllerDelegate

extension PMViewController: TaskEditViewControllerDelegate {

    func taskWillAdd(_ task: Task) {
        viewModel.add(task)
        historyViewModel.create(history: History(method: .added(title: task.title))) // history 추가
    }
}

// MARK: - HistoryViewModel

func create(history: History) {
    histories.insert(history, at: .zero)
}
```

`HistoryViewController`는 `histories`를 기반으로 tableView를 구성하여 수행한 작업 이력을 보여줍니다.



## [기한이 지난 프로젝트 강조 (기능으로 돌아가기)](#기한이-지난-프로젝트-강조-구현-방식-바로가기)

해당 기능은 `PMViewController`의 각 tableView에 들어가는 TableViewCell인 `TaskCell`이 `setStyle(with:)` 메서드를 통해 수행합니다. 개별 `task`의 연산 프로퍼티인 `isExpired`를 통해 강조 여부를 결정합니다.

```swift
// MARK: - TaskCell

private func setStyle(with task: Task?) {
    guard let isExpired = task?.isExpired else { return }

    dueDateLabel.textColor = isExpired ? Style.expiredDateTextColor : Style.dueDateTextColor
}

// MARK: - Task+CoreDataProperties

var isExpired: Bool? {
    guard let currentDate = Date().date else { return nil }
    return dueDate < currentDate
}
```



# 4. 테스트

제가 테스트를 하는 이유는 [여기](https://github.com/ryan-son/wrap-up-ios-open-market#필자가-테스트를-하는-이유)에서 살펴보실 수 있습니다.

`XCTest` 프레임워크를 이용하여 핵심 로직을 가진 7 개 타입 대상으로 49 개 유닛 테스트를 수행하였으며  View 영역의 코드를 제외한 Code Coverage는 63.3%입니다.

<img width="600" alt="image" src="https://user-images.githubusercontent.com/69730931/133331505-bdc31f56-218f-4fe7-b530-e78160157317.png">

## 네트워크에 의존하지 않는 테스트 구현

`URLSession`에 의존하여 네트워킹 기능을 구현한 앱들은 커스텀 `URLProtocol`을 정의하여 의도적인 응답을 설정할 수 있게 만들어 네트워크 연결 여부와 무관하게 유닛 테스트를 수행할 수 있도록 하고 있습니다. 이 개념은 [Ryan Market](https://github.com/ryan-son/wrap-up-ios-open-market) 프로젝트에서도 적용되었습니다.

 이 방식은 [WWDC18 - Testing tips & tricks](https://developer.apple.com/videos/play/wwdc2018/417/)에서 소개된 방식으로 Request를 처리하는 `URLSessionConfiguration`의 프로퍼티인 `protocolClasses`에 커스텀 프로토콜을 주입함으로써 의도된 방식으로 request에 응답하는 `URLSessionConfiguration`을 만들고, 이를 `URLSession(configuration:)` 이니셜라이저를 통해 주입함으로써 구현합니다.

본 프로젝트에서 정의하여 사용한 [MockURLProtocol](https://github.com/ryan-son/ios-project-manager/blob/main/ProjectManager/ProjectManagerTests/Sources/Mocks/MockURLProtocol.swift)과 이를 이용한 [유닛 테스트](https://github.com/ryan-son/ios-project-manager/blob/main/ProjectManager/ProjectManagerTests/Sources/Tests/Repositories/NetworkRepositoryTests.swift)는 각 링크를 통해 확인하실 수 있습니다.

```swift
// 테스트 예시
func test_post에task를전달하면_전달한task를서버DB에저장할수있다() throws {
    let task = Task(context: coreDataRepository.coreDataStack.context,
                    responseTask: TestAsset.dummyTodoResponseTask)
    let postTask = PostTask(by: task)
    let expectedHTTPBodyResponse = try JSONEncoder().encode(postTask)

    setLoadingHandler(true, expectedHTTPBodyResponse)
    
    let expectation = XCTestExpectation(description: "Post test")
    sutNetworkRepository.post(task: task) { result in
        switch result {
        case .success(let responseTask):
            XCTAssertEqual(responseTask.id, TestAsset.dummyTodoResponseTask.id)
            XCTAssertEqual(responseTask.title, TestAsset.dummyTodoResponseTask.title)
            XCTAssertEqual(responseTask.body, TestAsset.dummyTodoResponseTask.body)
            XCTAssertEqual(responseTask.dueDate, TestAsset.dummyTodoResponseTask.dueDate)
            XCTAssertEqual(responseTask.state, TestAsset.dummyTodoResponseTask.state)
            expectation.fulfill()
        case .failure(let error):
            XCTFail("Post에 실패하였습니다. \(error)")
        }
    }
    wait(for: [expectation], timeout: 2)
}
```



# 5. Trouble shooting

## 동일 TableView 내에서 Drag and Drop이 되지 않는 문제

본래 `UITableViewDragDelegate`와 `UITableViewDropDelegate`를 통해 충분히 동일 tableView 내, 타 tableView 간 Drag and Drop 기능을 구현할 수 있지만, 이 문제는 `PMViewController`와 `TaskViewModel` 간 MVVM 아키텍처를 구성하며 데이터 바인딩 방식의 특성으로 인해 발생하였습니다.



현재 `ViewModel`과 `View` 간 적용하고 있는 바인딩 방식은 `ViewModel` 측에 Task 추가, 수정, 이동, 삭제와 같은 변경에 따라 View 단에서 실행할 코드블럭을 주입해주기 위해 `ViewModel`에서 아래와 같은 클로저를 제공합니다.

```swift
final class TaskViewModel {

    var added: ((_ index: Int) -> Void)?
    var changed: (() -> Void)?
    var inserted: ((_ state: Task.State, _ index: Int) -> Void)?
    var removed: ((_ state: Task.State, _ index: Int) -> Void)?
    var fetchingFinished: (() -> Void)?
}
```

그러면 View 단에서는 아래와 같은 방식으로 상황별 View를 업데이트 하는 로직을 바인딩합니다.

```swift
// Mark: - PMViewController

private func bindWithViewModel() {
    viewModel.added = { index in
        DispatchQueue.main.async { [weak self] in
            let indexPaths = [IndexPath(row: index, section: .zero)]
            let todoStackView = self?.stateStackViews.filter { $0.state == .todo }.first
            todoStackView?.stateTableView.insertRows(at: indexPaths, with: .none)
        }
    }

    viewModel.changed = {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }

            if self.isFirstLoad {
                self.stateStackViews.forEach { stateStackView in
                    stateStackView.showTaskCountLabel()
                    stateStackView.stateTableView.reloadSections(IndexSet(0...0), with: .automatic)
                }
                self.isFirstLoad.toggle()
            }

            self.stateStackViews.forEach {
                guard let state = $0.state else { return }

                let taskCount = self.viewModel.count(of: state)
                $0.setTaskCountLabel(as: taskCount)
            }
        }
    }

    viewModel.removed = { state, row in
        let indexPaths = [IndexPath(row: row, section: .zero)]
        DispatchQueue.main.async { [weak self] in
            let stackView = self?.stateStackViews.filter { $0.state == state }.first
            stackView?.stateTableView.deleteRows(at: indexPaths, with: .none)
        }
    }

    viewModel.inserted = { state, row in
        let indexPaths = [IndexPath(row: row, section: .zero)]
        DispatchQueue.main.async { [weak self] in
            let stackView = self?.stateStackViews.filter { $0.state == state }.first
            stackView?.stateTableView.insertRows(at: indexPaths, with: .none)
        }
    }

    viewModel.fetchingFinished = {
        DispatchQueue.main.async { [weak self] in
            self?.stateStackViews.forEach { $0.stateTableView.reloadSections(IndexSet(0...0), with: .automatic) }
            self?.hideActivityIndicatorView()
        }
    }
}
```

 이러한 배경을 이해한 후 문제가 되었던 '동일 tableView 내 task 이동'이라는 이벤트를 발생시키면 아래와 같이 작업이 수행됩니다.

1. 동일 tableView 내 drag and drop
2. `PMViewController` → `taskViewModel.move(task, to: {sameAsBefore}, at: {destinationIndex})`
3. `move` 메서드는 `remove` → `insert` 메서드로의 조합으로 구성되어 있으며, 각 메서드의 말미에서  View 업데이트를 위해 지정된 클로저 (`removed?(state, index)`, `inserted?(state, index)`)가 실행됨
4. 동일 tableView 내에서 요소 이동이 일어났지만 `move` 메서드 실행 중 `remove`가 먼저 실행됨에 따라 View 단에서 `deleteRows(at:with:)`가 실행됨
5. tableView는 `deleteRows(at:with:)` 가 실행되어 cell의 개수는 감소했지만 ViewModel에 위치한 task들의 수량을 변경되지 않은 것을 확인함
6. tableView의 NumberOfRows와 모델의 개수가 다릅니다! Runtime Error!



결국 데이터 바인딩 과정에서 모델과 View의 동기화 시점이 달라 발생한 문제라고 결론지을 수 있으며, 이는 아래 세 가지 방법으로 해결할 수 있었습니다.

1. 데이터 바인딩 방식을 단순화하여 `task` 추가, 수정, 상태 변경, 삭제가 수행될 때 모든 tableView를 `reloadData()` 시키는 방법 (데이터 변경에 따른 view binding 단순화)
2. 데이터와  View 간 하나의 클로저로 바인딩하는 `move` 메서드를 새로 만드는 방법
3. 동일 tableView 내에서 일어나는 순서 변경을 지원하는  `UITableViewDataSource` 메서드를 구현하고 이에 적합한 `move` 메서드를 추가하는 방법



저와 동료는 각 항목에 대해 아래와 같이 고려하여 3 번 방식으로 구현하기로 결정하였습니다.

1. `reloadData()`
   - 아무리 개별 데이터의 크기와 총 규모가 작다고 해도 관련 없는 tableView까지 `reloadData()`를 수행하는 것은 비용이 크며 합리적이지 않음. 추후 개별 데이터가 커지거나 (이미지 포함) 총 규모가 커지면 (개수 증가) 다시 원상 복귀하여 이 문제에 직면하게 될 가능성이 있음)
2. 신규 `move` 메서드 및 신규 바인딩 클로저 추가
   -  합리적이지만, 이미 바인딩을 위한 클로저가 많이 작성되어 있는 상황에서 추가하기는 부담스러움
3. `UITableViewDataSource` 메서드 구현 및 적절한 `move` 메서드 추가
   - 전용 API로 예상한 기능에 대해 안정적인 작동을 보장하며 데이터 바인딩을 위한 클로저를 추가하지 않아도 됨



구현 방식은 아래와 같습니다.

```swift
// MARK: - UITableViewDataSource

extension PMViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        guard let stateTableView = tableView as? StateTableView,
              let state = stateTableView.state else { return }

        viewModel.move(in: state, from: sourceIndexPath.row, to: destinationIndexPath.row)
    }
}

// Mark: - TaskViewModel

/**
지정한 위치의 Task를 같은 state의 해당하는 index로 이동시킨다.

- Parameter state: 이동할 task
- Parameter sourceIndex: task의 기존 index
- Parameter destinationIndex: task의 이동 후 index
*/
func move(in state: Task.State, from sourceIndex: Int, to destinationIndex: Int) {
    let tasks: [Task] = taskList[state]
    guard sourceIndex < tasks.count,
          destinationIndex < tasks.count else { return }

    let removedTask: Task = taskList[state].remove(at: sourceIndex)
    taskList[state].insert(removedTask, at: destinationIndex)
}
```






## Core data 모델 인스턴스 삭제 시 접근이 불가능한 문제

`CoreData`의 Entity는 Reference semantics를 따르는 `class` 타입으로 지정되어 있습니다. Reference semantics 값들의 특징은 값이 전달될 때 복사가 일어나지 않고 identity가 전달되기 때문에 수정 작업을 하면 그 내용이 모든 곳에서 공유된다는 점입니다.



이러한 점이 이번 프로젝트에서 특히 치명적이었던 부분은 '요소를 디스크에서 삭제하면 더 이상 해당 요소에 접근할 수 없다'는 점이었습니다. 디스크에서 삭제하더라도 해당 요소를 가지고 다른 메서드에 넘겨주거나 네트워크 작업을 수행하는 등 더 해야하는 작업이 남아있어 굉장히 불편했습니다.



이 문제를 해결하기 위해 저와 동료는 **Soft delete**라는 개념을 적용하여 사용하였습니다. 모델 타입에 `isDeleted`라는 Bool 타입 프로퍼티를 만들어 실제로 삭제되지 않았지만 `fetch`와 같은 작업 결과에는 포함되지 않도록 구성하고, 모든 작업이 완료된 후 네트워크로부터 삭제 요청에 대해 성공 응답을 수신하면 실제로 디스크에서 삭제하는 방식을 적용하였습니다.

```swift
// MARK: - TaskViewModel

/**
 지정한 위치의 Task를 삭제하고 이를 반환한다.

 - Parameter state: 삭제할 task가 위치한 상태
 - Parameter index: 삭제할 task의 상태 내 index
 */
@discardableResult
func remove(state: Task.State, at index: Int) -> String? {
    guard index < taskList[state].count else { return nil }

    let removedTitle: String = taskList[state][index].title
    let removedTask: Task = taskList[state].remove(at: index)
    coreDataRepository.softDelete(removedTask.objectID) // soft delete 수행
    removed?(state, index)
    delete(removedTask)
    return removedTitle
}

private func delete(_ removedTask: Task) {
    networkRepository.delete(task: removedTask) { [weak self] result in
        switch result {
        case .success(let id):
            self?.coreDataRepository.delete(removedTask.objectID) // 실제 delete 작업
            self?.coreDataRepository.deleteFromPendingTaskList(removedTask)
            print("Deletion succeed! ID: \(id)")
        case .failure(let error):
            self?.coreDataRepository.insertFromPendingTaskList(removedTask)
            print(error)
        }
    }
}
```

