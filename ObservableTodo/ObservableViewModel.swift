//
//  ObservableViewModel.swift
//  ObservableTodo
//
//  Created by hansol on 2024/01/01.
//

import Foundation

protocol ViewModelProtocol {
    var observableTodo: Observable<[TodoModel]> { get }
    var todoCount: Int { get }
    var todoDescription: (Int) -> String? { get }
    func addTodo(description: String)
    func removeTodo(at index: Int)
}


class ObservableViewModel: ViewModelProtocol {
    
    var observableTodo: Observable<[TodoModel]> = Observable([])
    
    
    var todoCount: Int {
        return observableTodo.value.count
    }
    
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
    
    func addTodo(description: String) {
        let newTodo = TodoModel(description: description)
        observableTodo.value.append(newTodo)
    }
    
    func removeTodo(at index: Int) {
        observableTodo.value.remove(at: index)
    }
    
 
    
}
