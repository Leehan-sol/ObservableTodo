//
//  ObservableViewModel.swift
//  ObservableTodo
//
//  Created by hansol on 2024/01/01.
//

import Foundation

protocol ObservableVMProtocol {
    var observableTodo: Observable<[TodoModel]> { get }
//    var observableDone: Observable<[TodoModel]> { get }
    var todoCount: Int { get }
    var todoDescription: (Int) -> String? { get }
    func addTodo(description: String, isCompleted: Bool)
    func removeTodo(at index: Int)
    func toggleTodo(at index: Int)
    func todoCompleted(at index: Int) -> Bool
}


class ObservableViewModel: ObservableVMProtocol {
    
    var observableTodo: Observable<[TodoModel]> = Observable([])
    
//    var observableDone: Observable<[TodoModel]> {
//         return Observable(observableTodo.value.filter { $0.isCompleted })
//     }
    
    // Todo 개수
    var todoCount: Int {
        return observableTodo.value.count
    }
    
    // Todo description
    var todoDescription: (Int) -> String? {
        return { [weak self] index in
            return self?.todoDescription(at: index)
        }
    }
    
    func todoDescription(at index: Int) -> String? {
        guard index >= 0, index < observableTodo.value.count else {
            return nil
        }
        return observableTodo.value[index].description
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
    
    // Todo 완료
    func todoCompleted(at index: Int) -> Bool {
        guard index >= 0, index < observableTodo.value.count else {
            return false
        }
        return observableTodo.value[index].isCompleted
    }
    
}
