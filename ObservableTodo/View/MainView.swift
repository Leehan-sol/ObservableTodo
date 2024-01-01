//
//  MainView.swift
//  ObservableTodo
//
//  Created by hansol on 2024/01/01.
//

import UIKit

class MainView: UIView {
    
    // MARK: - UI Properties
    let goTodoButton: UIButton = {
        let button = UIButton()
        button.setTitle("TodoList", for: .normal)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    let goDoneButton: UIButton = {
        let button = UIButton()
        button.setTitle("DoneList", for: .normal)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    // MARK: - Life Cycle
    override init(frame: CGRect){
        super.init(frame: frame)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Func
    private func setUI(){
        addSubview(goTodoButton)
        addSubview(goDoneButton)
        self.backgroundColor = .systemBackground
        
        goTodoButton.translatesAutoresizingMaskIntoConstraints = false
        goDoneButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            goTodoButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            goTodoButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            goDoneButton.topAnchor.constraint(equalTo: goTodoButton.bottomAnchor, constant: 10),
            goDoneButton.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }
}
