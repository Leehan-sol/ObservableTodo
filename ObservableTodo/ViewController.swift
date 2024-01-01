//
//  ViewController.swift
//  ObservableTodo
//
//  Created by hansol on 2024/01/01.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - UI Component
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private let addButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("투두추가(옵저버)", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        return button
    }()
    
    
    // MARK: - Properties
    let observableViewModel: ViewModelProtocol
    
    // 0. 의존성 주입을 통해 ClosureViewModel 전달 (의존성 제거)
    init(observableVM: ViewModelProtocol) {
        self.observableViewModel = observableVM
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setTableView()
        setBindings()
    }
    
    
    // MARK: - Method
    func setUI(){
        view.backgroundColor = .systemBackground
        
        view.addSubview(tableView)
        view.addSubview(addButton)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -80),
            
            addButton.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 8),
            addButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    func setTableView(){
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }
    
    
    // MARK: - @objc
    // 옵저버이용 1. addButton을 누르면 뷰모델의 addTodo() 호출
    @objc func addButtonTapped() {
        let alert = UIAlertController(title: "Add Todo", message: "Enter a new todo item", preferredStyle: .alert)
        
        alert.addTextField { textField in
            textField.placeholder = "Todo item"
        }
        
        let addAction = UIAlertAction(title: "Add", style: .default) { [weak self] _ in
            if let newTodo = alert.textFields?.first?.text {
                self?.observableViewModel.addTodo(description: newTodo)
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addAction(addAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    // 4. 뷰모델의 observableTodo.bind 정의
    func setBindings(){
        observableViewModel.observableTodo.bind { [weak self] todo in
            self?.tableView.reloadData()
        }
    }
    
}

// MARK: - UITableViewDelegate
extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            observableViewModel.removeTodo(at: indexPath.row)
        }
    }
    
}

// MARK: - UITableViewDelegate
extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return observableViewModel.todoCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        cell.textLabel?.text = observableViewModel.todoDescription(indexPath.row)
        
        return cell
    }
    
}

