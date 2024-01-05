//
//  ObservableViewModel.swift
//  ObservableTodo
//
//  Created by hansol on 2024/01/01.
//

import Foundation

// MARK: - ObservableVMProtocol
protocol ObservableVMProtocol {
    var observableTodo: Observable<[TodoModel]> { get }
    var observableDone: Observable<[TodoModel]> { get }
    var todoCount: Int { get }
    var todoDescription: (Int) -> String? { get }
    var todoIsCompleted: (Int) -> String { get }
    var doneCount: Int { get }
    var doneDescription: (Int) -> String? { get }
    var doneIsCompleted: (Int) -> String { get }
    func addTodo(description: String, isCompleted: Bool)
    func removeTodo(at index: Int)
    func toggleTodo(at index: Int)
    func removeDone(description: String)
}


// MARK: - ObservableViewModel
class ObservableViewModel: ObservableVMProtocol {
    
    var observableTodo: Observable<[TodoModel]> = Observable([])
    
    var observableDone: Observable<[TodoModel]> {
        return Observable(observableTodo.value.filter { $0.isCompleted })
    }
    
    // Todo 개수
    var todoCount: Int {
        return observableTodo.value.count
    }
    
    // Todo 내용
    var todoDescription: (Int) -> String? {
        return { [weak self] index in
            return self?.todoDescription(at: index)
        }
    }
    
    // Todo isCompleted 상태
    var todoIsCompleted: (Int) -> String {
        return { [weak self] index in
            return self?.todoCompleted(at: index) ?? "defaultImageName"
        }
    }
    
    var doneCount: Int {
        return observableDone.value.count
    }
    
    var doneDescription: (Int) -> String? {
        return { [weak self] index in
            return self?.doneDescription(at:index)}
    }
    
    var doneIsCompleted: (Int) -> String {
        return { [weak self] index in
            return self?.doneCompleted(at: index) ?? "defaultImageName"
        }
    }
    
    // 3. Observable의 value에 추가됨
    // Todo 추가
    func addTodo(description: String, isCompleted: Bool) {
        let newTodo = TodoModel(description: description, isCompleted: isCompleted)
        observableTodo.value.append(newTodo)
    }
    
    // Todo 삭제
    func removeTodo(at index: Int) {
        observableTodo.value.remove(at: index)
    }
    
    // Todo 토글
    func toggleTodo(at index: Int) {
        guard index >= 0, index < observableTodo.value.count else {
            return
        }
        observableTodo.value[index].isCompleted.toggle()
    }
    
    // DoneTodo 삭제
    func removeDone(description: String) {
        if let index = observableTodo.value.firstIndex(where: { $0.description == description && $0.isCompleted }) {
            observableTodo.value[index].isCompleted = false
        }
    }
    
    // Todo 내용
    func todoDescription(at index: Int) -> String? {
        guard index >= 0, index < observableTodo.value.count else {
            return nil
        }
        return observableTodo.value[index].description
    }
    
    // Todo isCompleted 상태
    func todoCompleted(at index: Int) -> String {
        guard index >= 0, index < observableTodo.value.count else {
            return "defaultImageName"
        }
        
        let isCompleted = observableTodo.value[index].isCompleted
        return isCompleted ? "chevron.down.circle.fill" : "chevron.down.circle"
    }
    
    // Done 내용
    func doneDescription(at index: Int) -> String? {
        guard index >= 0, index < observableDone.value.count else {
            return nil
        }
        return observableDone.value[index].description
    }
    
    // Done isCompleted 상태
    func doneCompleted(at index: Int) -> String {
        guard index >= 0, index < observableDone.value.count else {
            return "defaultImageName"
        }
        
        let isCompleted = observableDone.value[index].isCompleted
        return isCompleted ? "chevron.down.circle.fill" : "chevron.down.circle"
    }
    
    
}
