//
//  TaskDetailsViewController.swift
//  ToDoListWithDesign
//
//

import UIKit

class TaskDetailsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // MARK: - Properties
    
    private var tasksList: [Task] = []
    
    // MARK: - UI Components
    
    private let archiveLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor(red: 247/255, green: 240/255, blue: 240/255, alpha: 1)
        label.textColor = .black
        label.text = "Archive"
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.textAlignment = .center
        label.layer.cornerRadius = 25
        label.layer.masksToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy private var allTasksTableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CustomTaskDetailsCell.self, forCellReuseIdentifier: "cell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        tasksList = DataManager.shared.loadFromTaskFile()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tasksList = DataManager.shared.loadFromTaskFile()
        allTasksTableView.reloadData()
    }
    
    // MARK: - Setup Methods
    
    private func setupUI() {
        view.addSubview(archiveLabel)
        view.addSubview(allTasksTableView)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            archiveLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            archiveLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 5),
            archiveLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -5),
            archiveLabel.heightAnchor.constraint(equalToConstant: 50),
            
            allTasksTableView.topAnchor.constraint(equalTo: archiveLabel.bottomAnchor, constant: 15),
            allTasksTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            allTasksTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5),
            allTasksTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 5)
        ])
    }
    
    // MARK: - UITableViewDataSource Methods

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomTaskDetailsCell
        cell.configure(with: tasksList[indexPath.section])
        return cell
    }
    
    // MARK: - UITableViewDelegate Methods
    
    func numberOfSections(in tableView: UITableView) -> Int {
        tasksList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 72
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView()
        footerView.backgroundColor = .clear
        return footerView
    }
    

}
