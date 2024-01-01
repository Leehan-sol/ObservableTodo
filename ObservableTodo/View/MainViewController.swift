//
//  MainViewController.swift
//  ObservableTodo
//
//  Created by hansol on 2024/01/01.
//

import UIKit

class MainViewController: UIViewController {
    
    // MARK: - Properties
    private let mainView = MainView()
    private let observableVM = ObservableViewModel()
    
    
    // MARK: - Life Cycle
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setAddtarget()
    }
    
    
    // MARK: - Method
    private func setAddtarget() {
        mainView.goTodoButton.addTarget(self, action: #selector(goTodoButtonTapped), for: .touchUpInside)
        mainView.goDoneButton.addTarget(self, action: #selector(goDoneButtonTapped), for: .touchUpInside)
    }
    
    
    // MARK: - @objc
    // 1. 뷰컨 생성 시 프로토콜 타입 뷰모델 의존성 주입
    @objc func goTodoButtonTapped() {
        let todoVC = TodoViewController(observableVM: observableVM)
        
        self.navigationController?.pushViewController(todoVC, animated: true)
    }
    
    @objc func goDoneButtonTapped() {
        let doneVC = DoneViewController(viewModel: observableVM)
        
        self.navigationController?.pushViewController(doneVC, animated: true)
    }
    
}
