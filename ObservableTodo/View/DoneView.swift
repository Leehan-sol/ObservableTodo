//
//  DoneView.swift
//  ObservableTodo
//
//  Created by hansol on 2024/01/01.
//

import UIKit

class DoneView: UIView {
    
    // MARK: - UI Properties
    let doneTableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        return tableView
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
        addSubview(doneTableView)
        self.backgroundColor = .systemBackground
        
        doneTableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            doneTableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            doneTableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            doneTableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            doneTableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
