//
//  CustomTaskCell.swift
//  ToDoListWithDesign
//
//

import UIKit

class CustomTaskCell: UITableViewCell {
    
    // MARK: - UI Components
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.textColor = UIColor(red: 0.938, green: 0.938, blue: 0.938, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let additionalInfoLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 11, weight: .regular)
        label.textColor = UIColor(red: 0.857, green: 0.857, blue: 0.857, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let taskEmojiLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 30, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let taskTypeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 11, weight: .regular)
        label.textAlignment = .center
        label.backgroundColor = UIColor(red: 1, green: 0.983, blue: 0.983, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.layer.cornerRadius = 8
        label.layer.masksToBounds = true
        label.layer.borderWidth = 1
        label.layer.borderColor = UIColor(red: 0.723, green: 0.715, blue: 0.715, alpha: 1).cgColor
        return label
    }()
    
    private let checkmarkView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 13
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let checkmarkImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "checkmark")
        imageView.tintColor = .white
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    // MARK: - Properties
    
    var isChecked: Bool = false {
        didSet {
            updateCheckmark()
        }
    }
    
    // MARK: - Initializers
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        setupCellUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        selectionStyle = .none
    }
    
    // MARK: - Setup Methods
    
    private func setupCellUI() {
        contentView.layer.cornerRadius = 10
        contentView.layer.masksToBounds = true
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(additionalInfoLabel)
        contentView.addSubview(taskEmojiLabel)
        contentView.addSubview(taskTypeLabel)
        contentView.addSubview(checkmarkView)
        checkmarkView.addSubview(checkmarkImage)
        
        NSLayoutConstraint.activate([
            // Task Emoji Label
            taskEmojiLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            taskEmojiLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            taskEmojiLabel.widthAnchor.constraint(equalToConstant: 40),
            taskEmojiLabel.heightAnchor.constraint(equalToConstant: 40),
            
            // Title Label
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            titleLabel.leadingAnchor.constraint(equalTo: taskEmojiLabel.trailingAnchor, constant: 13),
            titleLabel.heightAnchor.constraint(equalToConstant: 20),
            
            // Additional Info Label
            additionalInfoLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            additionalInfoLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            additionalInfoLabel.heightAnchor.constraint(equalToConstant: 25),
            
            // Task Type Label
            taskTypeLabel.topAnchor.constraint(equalTo: additionalInfoLabel.bottomAnchor),
            taskTypeLabel.leadingAnchor.constraint(equalTo: additionalInfoLabel.leadingAnchor),
            taskTypeLabel.widthAnchor.constraint(equalToConstant: 54),
            taskTypeLabel.heightAnchor.constraint(equalToConstant: 16),
            
            // Checkmark View
            checkmarkView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            checkmarkView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            checkmarkView.heightAnchor.constraint(equalToConstant: 26),
            checkmarkView.widthAnchor.constraint(equalToConstant: 26),
            
            // Checkmark Image
            checkmarkImage.centerYAnchor.constraint(equalTo: checkmarkView.centerYAnchor),
            checkmarkImage.centerXAnchor.constraint(equalTo: checkmarkView.centerXAnchor)
        ])
    }
    
    // MARK: - Reuse
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
        additionalInfoLabel.text = nil
        taskEmojiLabel.text = nil
        taskTypeLabel.text = nil
        backgroundColor = .white
    }
    
    // MARK: - Public Methods
    
    func configure(with task: Task) {
        titleLabel.text = task.name
        additionalInfoLabel.text = task.additionalInfo
        taskEmojiLabel.text = task.emoji
        taskTypeLabel.text = "#" + task.tasktype
        isChecked = task.isCompleted
        
        if task.tasktype == "task" {
            contentView.backgroundColor = UIColor(red: 0.762, green: 0.439, blue: 0.445, alpha: 1)
            taskTypeLabel.textColor = UIColor(red: 0.762, green: 0.439, blue: 0.445, alpha: 1)
        } else {
            contentView.backgroundColor = UIColor(red: 0.439, green: 0.574, blue: 0.762, alpha: 1)
            taskTypeLabel.textColor = UIColor(red: 0.439, green: 0.574, blue: 0.762, alpha: 1)
        }
    }
    
    // MARK: - Private Methods
    
    private func updateCheckmark() {
        if isChecked {
            checkmarkView.backgroundColor = .systemGreen
        } else {
            checkmarkView.backgroundColor = .white
        }
    }
}
