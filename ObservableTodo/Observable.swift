//
//  Observable.swift
//  ObservableTodo
//
//  Created by hansol on 2024/01/01.
//

import Foundation

class Observable<T> {

    // 3. listner호출됨
    var todo: [T] = [] {
        didSet {
            self.listener?(todo)
        }
    }
    
    init(todo: [T]) {
        self.todo = todo
    }
    
    var listener: (([T]) -> Void)?
    
    func bind(_ listener: @escaping ([T]) -> Void) {
        listener(todo)
        self.listener = listener
    }
    
    
}
