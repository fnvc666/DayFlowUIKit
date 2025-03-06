//
//  CustomAlertViewController.swift
//  ToDoListWithDesign
//
//

import UIKit

class CustomAlertViewController: UIViewController {
    
    // MARK: - Properties
    
    private let emojiOptions = ["📚", "🏋️", "📅", "💼", "🎯", "📝"]
    var selectedEmoji: String = ""
    var onInputChange: (() -> Void)?
    
    // MARK: - UI Components
    
    let switcher: UISwitch = {
        let switchView = UISwitch()
        switchView.onTintColor = UIColor(red: 0.762, green: 0.439, blue: 0.445, alpha: 1)
        switchView.backgroundColor = UIColor(red: 0.439, green: 0.574, blue: 0.762, alpha: 1)
        switchView.layer.cornerRadius = 16
        switchView.translatesAutoresizingMaskIntoConstraints = false
        return switchView
    }()
    
    private let goalLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "Goal"
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.layer.cornerRadius = 20
        label.layer.masksToBounds = true
        label.layer.borderWidth = 1
        label.layer.borderColor = UIColor(red: 0.439, green: 0.574, blue: 0.762, alpha: 1).cgColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let taskLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "Task"
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.layer.cornerRadius = 20
        label.layer.masksToBounds = true
        label.layer.borderWidth = 1
        label.layer.borderColor = UIColor(red: 0.762, green: 0.439, blue: 0.445, alpha: 1).cgColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let inputTextField: UITextField = {
        let textField = UITextField()
        textField.layer.masksToBounds = true
        textField.borderStyle = .roundedRect
        textField.backgroundColor = .lightGray
        textField.placeholder = "Task/Goal"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let inputAdditionalInfoTextField: UITextField = {
        let textField = UITextField()
        textField.layer.masksToBounds = true
        textField.borderStyle = .roundedRect
        textField.backgroundColor = .lightGray
        textField.placeholder = "Additional info"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let emojiStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(red: 0.97, green: 0.941, blue: 0.941, alpha: 1)
        setupSubviews()
        setupEmojiSelection()
        setupConstraints()
        
        inputTextField.addTarget(self, action: #selector(textFieldsDidChange), for: .editingChanged)
        inputAdditionalInfoTextField.addTarget(self, action: #selector(textFieldsDidChange), for: .editingChanged)
    }
    
    // MARK: - Setup Methods
    
    private func setupSubviews() {
        view.addSubview(switcher)
        view.addSubview(goalLabel)
        view.addSubview(taskLabel)
        view.addSubview(inputTextField)
        view.addSubview(inputAdditionalInfoTextField)
        view.addSubview(emojiStackView)
    }
    
    private func setupEmojiSelection() {
        for emoji in emojiOptions {
            let button = UIButton()
            button.setTitle(emoji, for: .normal)
            button.titleLabel?.font = .systemFont(ofSize: 20)
            button.addTarget(self, action: #selector(emojiTapped(_:)), for: .touchUpInside)
            emojiStackView.addArrangedSubview(button)
        }
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            inputTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            inputTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            inputTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            inputTextField.heightAnchor.constraint(equalToConstant: 30),
            
            inputAdditionalInfoTextField.topAnchor.constraint(equalTo: inputTextField.bottomAnchor, constant: 10),
            inputAdditionalInfoTextField.leadingAnchor.constraint(equalTo: inputTextField.leadingAnchor),
            inputAdditionalInfoTextField.trailingAnchor.constraint(equalTo: inputTextField.trailingAnchor),
            inputAdditionalInfoTextField.heightAnchor.constraint(equalToConstant: 30),
            
            goalLabel.topAnchor.constraint(equalTo: inputAdditionalInfoTextField.bottomAnchor, constant: 25),
            goalLabel.trailingAnchor.constraint(equalTo: switcher.leadingAnchor, constant: -20),
            goalLabel.heightAnchor.constraint(equalToConstant: 40),
            goalLabel.widthAnchor.constraint(equalToConstant: 65),
            
            switcher.centerYAnchor.constraint(equalTo: goalLabel.centerYAnchor),
            switcher.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            taskLabel.topAnchor.constraint(equalTo: goalLabel.topAnchor),
            taskLabel.leadingAnchor.constraint(equalTo: switcher.trailingAnchor, constant: 20),
            taskLabel.heightAnchor.constraint(equalToConstant: 40),
            taskLabel.widthAnchor.constraint(equalToConstant: 65),
            
            emojiStackView.topAnchor.constraint(equalTo: taskLabel.bottomAnchor, constant: 20),
            emojiStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emojiStackView.heightAnchor.constraint(equalToConstant: 40),
            
            view.heightAnchor.constraint(equalToConstant: 240),
            view.widthAnchor.constraint(equalToConstant: 270)
        ])
    }
    
    // MARK: - Action Methods
    
    @objc func emojiTapped(_ sender: UIButton) {
        guard let emoji = sender.titleLabel?.text else { return }
        
        for subview in emojiStackView.arrangedSubviews {
            if let button = subview as? UIButton {
                UIView.animate(withDuration: 0.15) {
                    button.transform = .identity
                }
            }
        }
    
        UIView.animate(withDuration: 0.15) {
            sender.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        }
        
        selectedEmoji = emoji
        onInputChange?()
    }
    
    @objc func textFieldsDidChange() {
        onInputChange?()
    }
}
