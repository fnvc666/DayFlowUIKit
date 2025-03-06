//
//  ViewController.swift
//  ToDoListWithDesign
//
//

import UIKit

class MainController: UIViewController, UITableViewDelegate, UITableViewDataSource, WeekDaysViewDelegate, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    // MARK: - Properties
    
    private var selectedTab: TabState = .all
    private var tasksList: [Task] = []
    private var selectedEmoji: String? = nil
    private var selectedDate: Date = Date()
    private var profile: Profile?
    
    // MARK: UI Components
    
    private let topView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 247/255, green: 240/255, blue: 240/255, alpha: 1)
        view.layer.cornerRadius = 58
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy private var avatarImage: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "avatarImage"))
        imageView.image = profile?.image
        imageView.layer.cornerRadius = 31
        imageView.layer.masksToBounds = true
        imageView.isUserInteractionEnabled = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy private var greetingLabel: UILabel = {
        let label = UILabel()
        let name = profile?.name ?? "incorrect name"
        label.text = "Hello, \(name)\nNew day - new you"
        label.numberOfLines = 2
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 24, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let todaysDate: UILabel = {
        let label = UILabel()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd, yyyy"
        label.text = dateFormatter.string(from: Date())
        label.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let weekDaysView: WeekDaysView = {
        let today = Date()
        let calendar = Calendar.current
        let days = (0..<7).compactMap {
            calendar.date(byAdding: .day, value: $0, to: today)
        }
        let view = WeekDaysView(dates: days)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let allButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(red: 0.633, green: 0.577, blue: 0.577, alpha: 1)
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor(red: 0.723, green: 0.715, blue: 0.715, alpha: 1).cgColor
        button.setTitle("All", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        button.setTitleColor(UIColor(red: 0.969, green: 0.941, blue: 0.941, alpha: 1), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let tasksButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(red: 1, green: 0.983, blue: 0.983, alpha: 1)
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor(red: 0.762, green: 0.439, blue: 0.445, alpha: 1).cgColor
        button.setTitle("Tasks", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        button.setTitleColor(UIColor(red: 0.723, green: 0.715, blue: 0.715, alpha: 1), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let goalsButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(red: 1, green: 0.983, blue: 0.983, alpha: 1)
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor(red: 0.439, green: 0.574, blue: 0.762, alpha: 1).cgColor
        button.setTitle("Goals", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        button.setTitleColor(UIColor(red: 0.723, green: 0.715, blue: 0.715, alpha: 1), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let addNewButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(red: 0.969, green: 0.941, blue: 0.941, alpha: 1)
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor(red: 0.633, green: 0.577, blue: 0.577, alpha: 1).cgColor
        button.setTitle("⊕ Add new", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        button.setTitleColor(UIColor(red: 0.522, green: 0.522, blue: 0.522, alpha: 1), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy private var tasksTableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CustomTaskCell.self, forCellReuseIdentifier: "TaskCell")
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "addNewCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    // MARK: - Computed Properties
    
    private var filteredTasks: [Task] {
        let tasksForDay = tasksList.filter {
            Calendar.current.isDate($0.date, inSameDayAs: selectedDate)
        }
        switch selectedTab {
            case .all:
                return tasksForDay
            case .tasks:
                return tasksForDay.filter { $0.tasktype == "task" }
            case .goals:
                return tasksForDay.filter { $0.tasktype == "goal" }
        }
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        weekDaysView.delegate = self
        tasksList = DataManager.shared.loadFromTaskFile()
        profile = DataManager.shared.loadFromProfileFile().first
        setupUI()
        setupTargets()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        profile = DataManager.shared.loadFromProfileFile().first
        avatarImage.image = profile?.image
        greetingLabel.text = "Hello, \(profile?.name ?? "incorrect name")\nNew day - new you"
    }
    
    
    // MARK: - Setup Methods
    
    private func setupUI() {
        view.addSubview(topView)
        
        topView.addSubview(avatarImage)
        topView.addSubview(greetingLabel)
        topView.addSubview(todaysDate)
        topView.addSubview(weekDaysView)
        
        view.addSubview(allButton)
        view.addSubview(tasksButton)
        view.addSubview(goalsButton)
        view.addSubview(tasksTableView)
        
        setupConstraints()
    }
    
    private func setupTargets() {
        allButton.addTarget(self, action: #selector(tabButtonTapped), for: .touchUpInside)
        tasksButton.addTarget(self, action: #selector(tabButtonTapped), for: .touchUpInside)
        goalsButton.addTarget(self, action: #selector(tabButtonTapped), for: .touchUpInside)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(changeAvatar))
        avatarImage.addGestureRecognizer(tapGesture)
        
        updateTabUI()
    }
    
    private func updateTabUI() {
        let selectedBG = UIColor(red: 0.633, green: 0.577, blue: 0.577, alpha: 1)
        let selectedText = UIColor(red: 0.969, green: 0.941, blue: 0.941, alpha: 1)
        let unselectedBG = UIColor(red: 1, green: 0.983, blue: 0.983, alpha: 1)
        let unselectedText = UIColor(red: 0.723, green: 0.715, blue: 0.715, alpha: 1)
        
        if selectedTab == .all {
            allButton.backgroundColor = selectedBG
            allButton.setTitleColor(selectedText, for: .normal)
        } else {
            allButton.backgroundColor = unselectedBG
            allButton.setTitleColor(unselectedText, for: .normal)
        }
        
        if selectedTab == .tasks {
            tasksButton.backgroundColor = selectedBG
            tasksButton.setTitleColor(selectedText, for: .normal)
        } else {
            tasksButton.backgroundColor = unselectedBG
            tasksButton.setTitleColor(unselectedText, for: .normal)
        }
        
        if selectedTab == .goals {
            goalsButton.backgroundColor = selectedBG
            goalsButton.setTitleColor(selectedText, for: .normal)
        } else {
            goalsButton.backgroundColor = unselectedBG
            goalsButton.setTitleColor(unselectedText, for: .normal)
        }
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            // Top view constraints
            topView.topAnchor.constraint(equalTo: view.topAnchor),
            topView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.34),
            topView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            avatarImage.topAnchor.constraint(equalTo: topView.topAnchor, constant: 76),
            avatarImage.leadingAnchor.constraint(equalTo: topView.leadingAnchor, constant: 31),
            avatarImage.widthAnchor.constraint(equalToConstant: 62),
            avatarImage.heightAnchor.constraint(equalToConstant: 62),
            
            greetingLabel.topAnchor.constraint(equalTo: avatarImage.topAnchor),
            greetingLabel.leadingAnchor.constraint(equalTo: avatarImage.trailingAnchor, constant: 15),
            
            todaysDate.topAnchor.constraint(equalTo: avatarImage.bottomAnchor, constant: 35),
            todaysDate.leadingAnchor.constraint(equalTo: topView.leadingAnchor, constant: 24),
            
            weekDaysView.topAnchor.constraint(equalTo: todaysDate.bottomAnchor, constant: 24),
            weekDaysView.leadingAnchor.constraint(equalTo: topView.leadingAnchor, constant: 24),
            weekDaysView.trailingAnchor.constraint(equalTo: topView.trailingAnchor, constant: -24),
            
            // Middle view constraints
            allButton.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: 13),
            allButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            allButton.heightAnchor.constraint(equalToConstant: 33),
            allButton.widthAnchor.constraint(equalToConstant: 45),
            
            tasksButton.topAnchor.constraint(equalTo: allButton.topAnchor),
            tasksButton.leadingAnchor.constraint(equalTo: allButton.trailingAnchor, constant: 8),
            tasksButton.heightAnchor.constraint(equalToConstant: 33),
            tasksButton.widthAnchor.constraint(equalToConstant: 79),
            
            goalsButton.topAnchor.constraint(equalTo: allButton.topAnchor),
            goalsButton.leadingAnchor.constraint(equalTo: tasksButton.trailingAnchor, constant: 8),
            goalsButton.heightAnchor.constraint(equalToConstant: 33),
            goalsButton.widthAnchor.constraint(equalToConstant: 79),
            
            // TableView constraints
            tasksTableView.topAnchor.constraint(equalTo: allButton.bottomAnchor, constant: 21),
            tasksTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            tasksTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            tasksTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    // MARK: - UITableViewDataSource Methods
    
    func numberOfSections(in tableView: UITableView) -> Int {
        filteredTasks.count + 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section < filteredTasks.count {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath) as! CustomTaskCell
            cell.configure(with: filteredTasks[indexPath.section])
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "addNewCell", for: indexPath)
            var content = cell.defaultContentConfiguration()
            content.text = "⊕ Add new"
            content.textProperties.font = .systemFont(ofSize: 16, weight: .semibold)
            content.textProperties.alignment = .center
            content.textProperties.color = UIColor(red: 0.522, green: 0.522, blue: 0.522, alpha: 1)
            cell.contentConfiguration = content
            cell.backgroundColor = UIColor(red: 0.969, green: 0.941, blue: 0.941, alpha: 1)
            cell.layer.borderColor = UIColor(red: 0.633, green: 0.577, blue: 0.577, alpha: 1).cgColor
            cell.layer.cornerRadius = 10
            cell.layer.borderWidth = 1
            cell.selectionStyle = .none
            return cell
        }
    }
    
    // MARK: - UITableViewDelegate Methods
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.section == filteredTasks.count ? 36 : 72
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == filteredTasks.count {
            addNewButtonTapped()
        } else {
            var task = filteredTasks[indexPath.section]
            task.isCompleted.toggle()
            
            if let index = tasksList.firstIndex(where: { $0.date == task.date && $0.name == task.name }) {
                tasksList[index].isCompleted = task.isCompleted
            }
            
            DataManager.shared.saveJSON(tasks: tasksList, key: "tasks")
            
            if let cell = tableView.cellForRow(at: indexPath) as? CustomTaskCell {
                cell.isChecked = task.isCompleted
            }
        }
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        21
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView()
        footerView.backgroundColor = .clear
        return footerView
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        if indexPath.section == filteredTasks.count {
            return nil
        }
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { _, _, completionHandler in
            let taskToRemove = self.filteredTasks[indexPath.section]
            
            if let index = self.tasksList.firstIndex(where: { $0.id == taskToRemove.id }) {
                self.tasksList.remove(at: index)
                tableView.deleteSections(IndexSet(integer: indexPath.section), with: .automatic)
                completionHandler(true)
                DataManager.shared.saveJSON(tasks: self.tasksList, key: "tasks")
            } else {
                completionHandler(false)
            }
        }
        
        deleteAction.backgroundColor = .red
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        
        return configuration
    }
    
    // MARK: - Action Methods
    
    @objc private func tabButtonTapped(_ sender: UIButton) {
        switch sender {
            case allButton:
                selectedTab = .all
            case tasksButton:
                selectedTab = .tasks
            case goalsButton:
                selectedTab = .goals
            default:
                break
        }
        
        updateTabUI()
        tasksTableView.reloadData()
    }
    
    @objc private func changeAvatar() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true)
    }
    
    // MARK: - UIImagePickerControllerDelegate Methods
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[.editedImage] as? UIImage ?? info[.originalImage] as? UIImage {
            avatarImage.image = selectedImage
        }
        picker.dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
    
    // MARK: - WeekDaysViewDelegate Method
    
    func didSelectDay(_ date: Date) {
        selectedDate = date
        tasksTableView.reloadData()
    }
    
    // MARK: - Additional Methods
    
    func addNewButtonTapped() {
        let alert = UIAlertController(title: "Add New", message: nil, preferredStyle: .alert)
        let customVC = CustomAlertViewController()
        
        let addAction = UIAlertAction(title: "Add", style: .default) { _ in
            self.tasksList.append(Task(
                date: self.selectedDate,
                name: customVC.inputTextField.text ?? "",
                additionalInfo: customVC.inputAdditionalInfoTextField.text ?? "",
                tasktype: customVC.switcher.isOn ? "task" : "goal",
                isCompleted: false,
                emoji: customVC.selectedEmoji))
            self.tasksTableView.reloadData()
            DataManager.shared.saveJSON(tasks: self.tasksList, key: "tasks")
        }
        
        addAction.isEnabled = false
        
        customVC.onInputChange = { [weak self] in
            guard let _ = self else { return }
            addAction.isEnabled = !(customVC.inputTextField.text?.isEmpty ?? true) &&
            !(customVC.inputAdditionalInfoTextField.text?.isEmpty ?? true) &&
            !customVC.selectedEmoji.isEmpty
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.setValue(customVC, forKey: "contentViewController")
        alert.addAction(addAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
    }
}
