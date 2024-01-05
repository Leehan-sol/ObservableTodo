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
    
    // doneList가 변하면 didSet호출, 실행 될 함수 정의
    private func setBindings(){
        viewModel.observableDone.bind { [weak self] done in
            self?.doneView.tableView.reloadData()
        }
    }
    
}


// MARK: - UITableViewDataSource
extension DoneViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.doneCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as? TableViewCell else {
            return UITableViewCell()
        }
        
        guard let description = viewModel.doneDescription(indexPath.row) else { return cell }
        
        cell.callBackMethod = { [weak self] in
            self?.viewModel.removeDone(description: description)
        }
        
        cell.todoLabel.text = description
        cell.checkButton.setImage(UIImage(systemName: viewModel.doneIsCompleted(indexPath.row)), for: .normal)
    
        return cell
    }
    
    
}
