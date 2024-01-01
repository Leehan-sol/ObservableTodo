//
//  DoneViewController.swift
//  ObservableTodo
//
//  Created by hansol on 2024/01/01.
//

import UIKit

class DoneViewController: UIViewController {
    
    private let doneView = DoneView()
    private let viewModel: ObservableVMProtocol
    
    init(viewModel: ObservableVMProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = doneView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBindings()
    }
    
    //  doneList가 변하면 didSet호출시 실행 될 함수 정의
    private func setBindings(){
        viewModel.observableTodo.bind { [weak self] todo in
            self?.doneView.doneTableView.reloadData()
        }
    }
    
    
}
