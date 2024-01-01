//
//  ViewController.swift
//  ObservableTodo
//
//  Created by hansol on 2024/01/01.
//

import UIKit

class TodoViewController: UIViewController {
    
    // MARK: - Properties
    private let todoView = TodoView()
    private let viewModel: ObservableVMProtocol
    
    // 0. 의존성 주입을 통해 ClosureViewModel 전달 (의존성 제거)
    init(observableVM: ObservableVMProtocol) {
        self.viewModel = observableVM
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = todoView
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setAddTarget()
        setTableView()
        setBindings()
    }
    
    
    // MARK: - Method
    private func setAddTarget() {
        todoView.addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
    }
    
    private func setTableView() {
        todoView.tableView.delegate = self
        todoView.tableView.dataSource = self
        todoView.tableView.register(TableViewCell.self, forCellReuseIdentifier: "customCell")
    }
    
    // 5. 뷰모델의 observableTodo.bind 정의, Observable.value값이 변하면 실행됨
    private func setBindings(){
        viewModel.observableTodo.bind { [weak self] todo in
            self?.todoView.tableView.reloadData()
        }
    }
    
    
    // MARK: - @objc
    // 옵저버이용 2. addButton을 누르면 뷰모델의 addTodo() 호출
    @objc func addButtonTapped() {
        let alert = UIAlertController(title: "Add Todo", message: "Enter a new todo item", preferredStyle: .alert)
        
        alert.addTextField { textField in
            textField.placeholder = "Todo item"
        }
        
        let addAction = UIAlertAction(title: "Add", style: .default) { [weak self] _ in
            if let newTodo = alert.textFields?.first?.text {
                self?.viewModel.addTodo(description: newTodo, isCompleted: false)
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addAction(addAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
    
}

// MARK: - UITableViewDelegate
extension TodoViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            viewModel.removeTodo(at: indexPath.row)
        }
    }
    
}


// MARK: - UITableViewDelegate
extension TodoViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.todoCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as? TableViewCell else {
            return UITableViewCell()
        }
        
        cell.callBackMethod = { [weak self] in
            self?.viewModel.toggleTodo(at: indexPath.row)
        }
        
        cell.todoLabel.text = viewModel.todoDescription(indexPath.row)
        
        // ✨ 버튼 이미지 구하는 로직도 뷰모델로 빼기
        let isCompleted = viewModel.todoCompleted(at: indexPath.row)
        let buttonImage = isCompleted ? UIImage(systemName: "chevron.down.circle.fill") : UIImage(systemName: "chevron.down.circle")
        cell.checkButton.setImage(buttonImage, for: .normal)
        
        return cell
    }
    
}

