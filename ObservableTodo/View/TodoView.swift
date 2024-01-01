//
//  TodoView.swift
//  ObservableTodo
//
//  Created by hansol on 2024/01/01.
//

import UIKit

class TodoView: UIView {
    
    // MARK: - UI Components
   let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    let addButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("할일추가", for: .normal)
        button.tintColor = .black
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        button.translatesAutoresizingMaskIntoConstraints = false
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
    
    
    // MARK: - Method
    private func setUI(){
        backgroundColor = .systemBackground
        
        addSubview(tableView)
        addSubview(addButton)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -80),
            
            addButton.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 8),
            addButton.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }
}
