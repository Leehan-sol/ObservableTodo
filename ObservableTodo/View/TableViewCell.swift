//
//  TableViewCell.swift
//  ObservableTodo
//
//  Created by hansol on 2024/01/01.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    private let viewModel = ObservableViewModel()
    
    var callBackMethod: (() -> Void)?
    
    // MARK: - UI Properties
    let todoLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let checkButton: UIButton = {
        let button = UIButton(type: .system)
        let chevronImage = UIImage(systemName: "chevron.down.circle")
        button.setImage(chevronImage, for: .normal)
        button.tintColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Life Cycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUI()
        setAddTarget()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Method
    private func setUI() {
        selectionStyle = .none
        contentView.addSubview(todoLabel)
        contentView.addSubview(checkButton)
        
        NSLayoutConstraint.activate([
            todoLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            todoLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            
            checkButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            checkButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
    }
    
    private func setAddTarget() {
        checkButton.addTarget(self, action: #selector(checkButtonTapped), for: .touchUpInside)
    }
    
    // MARK: - @objc
    @objc private func checkButtonTapped() {
        callBackMethod?()
    }

}
