//
//  DoneViewController.swift
//  ObservableTodo
//
//  Created by hansol on 2024/01/01.
//

import UIKit

class DoneViewController: UIViewController {
    
    // MARK: - Properties
    private let doneView = DoneView()
    private let viewModel: ObservableVMProtocol
    
    init(viewModel: ObservableVMProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Life Cycle
    override func loadView() {
        view = doneView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
        setBindings()
    }
    
    
    // MARK: - Method
    private func setTableView() {
        doneView.tableView.dataSource = self
        doneView.tableView.register(TableViewCell.self, forCellReuseIdentifier: "customCell")
    }
    
    //  doneList가 변하면 didSet호출시 실행 될 함수 정의
    private func setBindings(){
        viewModel.observableTodo.bind { [weak self] done in
            self?.doneView.tableView.reloadData()
        }
    }
    
}


// MARK: - UITableViewDataSource
extension DoneViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.observableDone.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as? TableViewCell else {
            return UITableViewCell()
        }
        
        // ✨ 필터된것만 보여주도록 수정, 이렇게 필터해서 쓰면 정렬이 안됨
        cell.todoLabel.text = viewModel.observableDone.value[indexPath.row].description
        
        let isCompleted = viewModel.observableDone.value[indexPath.row].isCompleted
        let buttonImage = isCompleted ? UIImage(systemName: "chevron.down.circle.fill") : UIImage(systemName: "chevron.down.circle")
        cell.checkButton.setImage(buttonImage, for: .normal)
        
        return cell
    }
    
    
}
