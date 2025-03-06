//
//  CustomTaskDetailsCell.swift
//  ToDoListWithDesign
//
//
import UIKit

class CustomTaskDetailsCell: UITableViewCell {
    
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
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 11, weight: .regular)
        label.textAlignment = .center
        label.layer.cornerRadius = 8
        label.layer.masksToBounds = true
        label.layer.borderWidth = 1
        label.layer.borderColor = UIColor(red: 0.723, green: 0.715, blue: 0.715, alpha: 1).cgColor
        label.text = "12:00"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Initialization
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: .none)
        setupCellUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Methods
    
    func setupCellUI() {
        layer.cornerRadius = 10
        layer.masksToBounds = true
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(additionalInfoLabel)
        contentView.addSubview(taskTypeLabel)
        contentView.addSubview(dateLabel)
        setupConstraints()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            titleLabel.heightAnchor.constraint(equalToConstant: 20),
            
            additionalInfoLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            additionalInfoLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            additionalInfoLabel.heightAnchor.constraint(equalToConstant: 20),
            
            taskTypeLabel.topAnchor.constraint(equalTo: additionalInfoLabel.bottomAnchor),
            taskTypeLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            taskTypeLabel.widthAnchor.constraint(equalToConstant: 54),
            taskTypeLabel.heightAnchor.constraint(equalToConstant: 16),
            
            dateLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            dateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            dateLabel.widthAnchor.constraint(equalToConstant: 120),
            dateLabel.heightAnchor.constraint(equalToConstant: 35),
            ])
    }

    
    // MARK: - Reuse
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
        additionalInfoLabel.text = nil
        taskTypeLabel.text = nil
        dateLabel.text = nil
        backgroundColor = .white
    }
    
    // MARK: - Public Methods
    
    func configure(with task: Task) {
        titleLabel.text = task.name
        additionalInfoLabel.text = task.additionalInfo
        taskTypeLabel.text = task.tasktype
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy HH:mm"
        let formattedDate = dateFormatter.string(from: task.date)
        dateLabel.text = formattedDate
        
        if task.isCompleted {
            backgroundColor = UIColor(red: 107/256, green: 144/256, blue: 128/256, alpha: 1)
            let color = UIColor(red: 204/256, green: 227/256, blue: 222/256, alpha: 1)
            titleLabel.textColor = color
            additionalInfoLabel.textColor = color
            taskTypeLabel.backgroundColor = color
            dateLabel.backgroundColor = color
        } else {
            backgroundColor = UIColor(red: 201/256, green: 24/256, blue: 74/256, alpha: 1)
            let color = UIColor(red: 255/256, green: 204/256, blue: 213/256, alpha: 1)
            titleLabel.textColor = color
            additionalInfoLabel.textColor = color
            taskTypeLabel.backgroundColor = color
            dateLabel.backgroundColor = color
        }
    }
}
