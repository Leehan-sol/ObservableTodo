//
//  ObservableViewModel.swift
//  ObservableTodo
//
//  Created by hansol on 2024/01/01.
//

import Foundation

protocol ViewModelProtocol {
    var observableTodo: Observable<TodoModel> { get }
    var todoCount: Int { get }
    var todoDescription: (Int) -> String? { get }
    func addTodo(description: String)
    func removeTodo(at index: Int)
}


class ObservableViewModel: ViewModelProtocol {
    
    var observableTodo: Observable<TodoModel> = Observable(todo: [])
    
    var todoCount: Int {
        return observableTodo.todo.count
    }
    
    var todoDescription: (Int) -> String? {
        return { [weak self] index in
            return self?.todoDescription(at: index)
        }
    }
    
    // 2. observableTodo.todo에 추가됨
    func addTodo(description: String) {
        observableTodo.todo.append(TodoModel(description: description))
    }
    
    func removeTodo(at index: Int) {
        observableTodo.todo.remove(at: index)
    }
    
    func todoDescription(at index: Int) -> String? {
        guard index >= 0, index < observableTodo.todo.count else {
            return nil
        }
        return observableTodo.todo[index].description
    }
    
}
