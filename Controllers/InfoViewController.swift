//
//  InfoViewController.swift
//  ToDoListWithDesign
//
//

import UIKit

class InfoViewController: UIViewController {
    
    // MARK: - Properties
    
    private var noteTimer: Timer?
    
    // MARK: - UI Components
    
    private let noteBackground: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor(red: 0.97, green: 0.941, blue: 0.941, alpha: 1)
        label.layer.cornerRadius = 125
        label.layer.masksToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let noteImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "oc-taking-note")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let noteLabel: UILabel = {
        let label = UILabel()
        label.text = "Great achievements begin with small steps. Plan, execute, succeed!"
        label.font = UIFont.systemFont(ofSize: 17, weight: .light)
        label.textColor = .black
        label.numberOfLines = 3
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let chatServiceBackround: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor(red: 0.97, green: 0.941, blue: 0.941, alpha: 1)
        label.layer.cornerRadius = 125
        label.layer.masksToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let chatServiceImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "ec-chat-service-circle")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let chatServiceLabel: UILabel = {
        let label = UILabel()
        label.text = "Efficient work begins with smart organization!"
        label.font = UIFont.systemFont(ofSize: 17, weight: .light)
        label.textColor = .black
        label.numberOfLines = 3
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        noteBackground.isHidden = true
        chatServiceBackround.isHidden = true
        
        setupUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        noteBackground.transform = CGAffineTransform(translationX: -view.frame.width, y: 0)
        noteBackground.isHidden = false
        UIView.animate(withDuration: 1,
                       delay: 0.1,
                       options: .curveEaseOut,
                       animations: {
            self.noteBackground.transform = .identity
        }, completion: nil)
        
        chatServiceBackround.transform = CGAffineTransform(translationX: -view.frame.width, y: 0)
        chatServiceBackround.isHidden = false
        UIView.animate(withDuration: 1,
                       delay: 1.2,
                       options: .curveEaseOut,
                       animations: {
            self.chatServiceBackround.transform = .identity
        }, completion: nil)
    }
    
    // MARK: - Setup Methods
    
    private func setupUI() {
        view.backgroundColor = UIColor(red: 0.762, green: 0.439, blue: 0.445, alpha: 1)
        
        view.addSubview(noteBackground)
        view.addSubview(chatServiceBackround)
        noteBackground.addSubview(noteImageView)
        noteBackground.addSubview(noteLabel)
        chatServiceBackround.addSubview(chatServiceLabel)
        chatServiceBackround.addSubview(chatServiceImageView)
        
        setupConstraint()
    }
    
    private func setupConstraint() {
        NSLayoutConstraint.activate([
            noteBackground.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 85),
            noteBackground.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            noteBackground.heightAnchor.constraint(equalToConstant: 250),
            noteBackground.widthAnchor.constraint(equalToConstant: 250),
            
            noteImageView.topAnchor.constraint(equalTo: noteBackground.topAnchor, constant: 30),
            noteImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            noteImageView.heightAnchor.constraint(equalToConstant: 100),
            noteImageView.widthAnchor.constraint(equalToConstant: 100),
            
            noteLabel.topAnchor.constraint(equalTo: noteImageView.bottomAnchor, constant: 10),
            noteLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            noteLabel.leadingAnchor.constraint(equalTo: noteBackground.leadingAnchor, constant: 10),
            noteLabel.trailingAnchor.constraint(equalTo: noteBackground.trailingAnchor, constant: -10),
            
            chatServiceBackround.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -85),
            chatServiceBackround.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            chatServiceBackround.heightAnchor.constraint(equalToConstant: 250),
            chatServiceBackround.widthAnchor.constraint(equalToConstant: 250),
            
            chatServiceImageView.topAnchor.constraint(equalTo: chatServiceBackround.topAnchor, constant: 30),
            chatServiceImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            chatServiceImageView.heightAnchor.constraint(equalToConstant: 100),
            chatServiceImageView.widthAnchor.constraint(equalToConstant: 100),
            
            chatServiceLabel.topAnchor.constraint(equalTo: chatServiceImageView.bottomAnchor, constant: 10),
            chatServiceLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            chatServiceLabel.leadingAnchor.constraint(equalTo: chatServiceBackround.leadingAnchor, constant: 10),
            chatServiceLabel.trailingAnchor.constraint(equalTo: chatServiceBackround.trailingAnchor, constant: -10),
        ])
        
    }
}
