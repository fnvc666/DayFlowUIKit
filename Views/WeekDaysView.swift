//
//  WeekDaysView.swift
//  ToDoListWithDesign
//
//

import UIKit

// MARK: - Protocol

protocol WeekDaysViewDelegate: AnyObject {
    func didSelectDay(_ day: Date)
}

// MARK: - WeekDaysView

class WeekDaysView: UIView {
    
    // MARK: - Properties
    
    weak var delegate: WeekDaysViewDelegate?
    private var buttonToDate: [UIButton: Date] = [:]
    private var dates: [Date] = []
    
    // MARK: - UI Components
    
    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 5
        stack.alignment = .center
        stack.distribution = .equalSpacing
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    // MARK: - Initializers
    
    init(dates: [Date]) {
        super.init(frame: .zero)
        self.dates = dates
        setupUI()
        
        // Configure the first day button in the stackView
        if let firstButton = stackView.arrangedSubviews.first as? UIButton {
            firstButton.backgroundColor = UIColor(red: 0.633, green: 0.577, blue: 0.577, alpha: 1)
            firstButton.titleLabel?.textColor = UIColor(red: 0.969, green: 0.941, blue: 0.941, alpha: 1)
            for subview in firstButton.subviews {
                if let label = subview as? UILabel {
                    label.textColor = UIColor(red: 0.969, green: 0.941, blue: 0.941, alpha: 1)
                }
            }
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    // MARK: - Setup Methods
    
    private func setupUI() {
        addSubview(stackView)
        setupConstraints()
        
        for date in dates {
            let button = UIButton(type: .system)
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "E"
            let dayString = dateFormatter.string(from: date)
            dateFormatter.dateFormat = "d"
            let numberOfDayString = dateFormatter.string(from: date)
            
            button.backgroundColor = UIColor(red: 1, green: 0.983, blue: 0.983, alpha: 1)
            button.layer.cornerRadius = 10
            button.layer.masksToBounds = true
            button.layer.borderWidth = 1
            button.layer.borderColor = UIColor(red: 0.723, green: 0.715, blue: 0.715, alpha: 1).cgColor
            
            let dayLabel = UILabel()
            dayLabel.textColor = UIColor(red: 0.723, green: 0.715, blue: 0.715, alpha: 1)
            dayLabel.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
            dayLabel.textAlignment = .center
            dayLabel.text = dayString
            dayLabel.tag = 1
            dayLabel.translatesAutoresizingMaskIntoConstraints = false
            
            let numberOfDayLabel = UILabel()
            numberOfDayLabel.textColor = .black
            numberOfDayLabel.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
            numberOfDayLabel.textAlignment = .center
            numberOfDayLabel.text = numberOfDayString
            numberOfDayLabel.tag = 2
            numberOfDayLabel.translatesAutoresizingMaskIntoConstraints = false
            
            button.addSubview(dayLabel)
            button.addSubview(numberOfDayLabel)
            
            button.heightAnchor.constraint(equalToConstant: 50).isActive = true
            button.widthAnchor.constraint(equalToConstant: 45).isActive = true
            
            dayLabel.topAnchor.constraint(equalTo: button.topAnchor, constant: 3).isActive = true
            dayLabel.centerXAnchor.constraint(equalTo: button.centerXAnchor).isActive = true
            dayLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
            dayLabel.widthAnchor.constraint(equalToConstant: 32).isActive = true
            
            numberOfDayLabel.topAnchor.constraint(equalTo: dayLabel.bottomAnchor).isActive = true
            numberOfDayLabel.centerXAnchor.constraint(equalTo: button.centerXAnchor).isActive = true
            numberOfDayLabel.heightAnchor.constraint(equalToConstant: 22).isActive = true
            numberOfDayLabel.widthAnchor.constraint(equalToConstant: 28).isActive = true
            
            button.addTarget(self, action: #selector(dayButtonTapped(_:)), for: .touchUpInside)
            buttonToDate[button] = date
            
            stackView.addArrangedSubview(button)
        }
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    // MARK: - Action Methods
    
    @objc func dayButtonTapped(_ sender: UIButton) {
        guard let date = buttonToDate[sender] else { return }
        delegate?.didSelectDay(date)
        
        for dayButton in stackView.arrangedSubviews as! [UIButton] {
            dayButton.backgroundColor = UIColor(red: 1, green: 0.983, blue: 0.983, alpha: 1)
            dayButton.titleLabel?.textColor = UIColor(red: 0.723, green: 0.715, blue: 0.715, alpha: 1)
            for subview in dayButton.subviews {
                if let label = subview as? UILabel {
                    label.textColor = (label.tag == 1)
                        ? UIColor(red: 0.723, green: 0.715, blue: 0.715, alpha: 1)
                        : .black
                }
            }
        }
        
        sender.backgroundColor = UIColor(red: 0.633, green: 0.577, blue: 0.577, alpha: 1)
        for subview in sender.subviews {
            if let label = subview as? UILabel {
                label.textColor = UIColor(red: 0.969, green: 0.941, blue: 0.941, alpha: 1)
            }
        }
    }
}
