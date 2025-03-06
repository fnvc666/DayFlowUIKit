//
//  SettingsViewController.swift
//  ToDoListWithDesign
//
//

import UIKit

class SettingsViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {

    // MARK: - UI Components
    let settingsLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor(red: 247/255, green: 240/255, blue: 240/255, alpha: 1)
        label.textColor = .black
        label.text = "Settings"
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.textAlignment = .center
        label.layer.cornerRadius = 25
        label.layer.masksToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let avatarImage: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "avatarImage"))
        imageView.layer.cornerRadius = 50
        imageView.layer.masksToBounds = true
        imageView.isUserInteractionEnabled = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let changeAvatarButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(red: 247/255, green: 240/255, blue: 240/255, alpha: 1)
        button.setTitle("Change avatar", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        button.layer.cornerRadius = 20
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let nameBackgroundLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor(red: 247/255, green: 240/255, blue: 240/255, alpha: 1)
        label.layer.cornerRadius = 20
        label.layer.masksToBounds = true
        label.isUserInteractionEnabled = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "John Doe"
        label.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let changeNameButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "pencil"), for: .normal)
        button.backgroundColor = .white
        button.tintColor = .black
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let resetBackroundLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor(red: 247/255, green: 240/255, blue: 240/255, alpha: 1)
        label.layer.cornerRadius = 20
        label.layer.masksToBounds = true
        label.isUserInteractionEnabled = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let resetLabel: UILabel = {
        let label = UILabel()
        label.text = "Reset App Data"
        label.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let resetButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "exclamationmark.arrow.trianglehead.2.clockwise.rotate.90"), for: .normal)
        button.backgroundColor = .white
        button.tintColor = .black
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let contactBackgroundLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor(red: 247/255, green: 240/255, blue: 240/255, alpha: 1)
        label.layer.cornerRadius = 20
        label.layer.masksToBounds = true
        label.isUserInteractionEnabled = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let contactLabel: UILabel = {
        let label = UILabel()
        label.text = "Contact Us"
        label.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let contactButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "envelope"), for: .normal)
        button.backgroundColor = .white
        button.tintColor = .black
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        
        if let savedProfile = DataManager.shared.loadFromProfileFile().first, let savedImage = savedProfile.image, let savedName = savedProfile.name {
            avatarImage.image = savedImage
            nameLabel.text = savedName
        }
    }
    
    // MARK: - Setup Methods
    
    private func setupUI() {
        view.addSubview(settingsLabel)
        view.addSubview(avatarImage)
        view.addSubview(changeAvatarButton)
        view.addSubview(nameBackgroundLabel)
        view.addSubview(resetBackroundLabel)
        view.addSubview(contactBackgroundLabel)
        
        nameBackgroundLabel.addSubview(nameLabel)
        nameBackgroundLabel.addSubview(changeNameButton)
        
        resetBackroundLabel.addSubview(resetLabel)
        resetBackroundLabel.addSubview(resetButton)
        
        contactBackgroundLabel.addSubview(contactLabel)
        contactBackgroundLabel.addSubview(contactButton)
        
        setupConstraints()
        setupTargets()
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            settingsLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5),
            settingsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            settingsLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            settingsLabel.heightAnchor.constraint(equalToConstant: 50),
            
            avatarImage.topAnchor.constraint(equalTo: settingsLabel.bottomAnchor, constant: 25),
            avatarImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            avatarImage.widthAnchor.constraint(equalToConstant: 150),
            avatarImage.heightAnchor.constraint(equalToConstant: 150),
            
            changeAvatarButton.topAnchor.constraint(equalTo: avatarImage.bottomAnchor, constant: 10),
            changeAvatarButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            changeAvatarButton.heightAnchor.constraint(equalToConstant: 40),
            changeAvatarButton.widthAnchor.constraint(equalToConstant: 120),
            
            nameBackgroundLabel.topAnchor.constraint(equalTo: changeAvatarButton.bottomAnchor, constant: 25),
            nameBackgroundLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            nameBackgroundLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            nameBackgroundLabel.heightAnchor.constraint(equalToConstant: 60),
            
            nameLabel.centerYAnchor.constraint(equalTo: nameBackgroundLabel.centerYAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: nameBackgroundLabel.leadingAnchor, constant: 20),
            
            changeNameButton.centerYAnchor.constraint(equalTo: nameBackgroundLabel.centerYAnchor),
            changeNameButton.trailingAnchor.constraint(equalTo: nameBackgroundLabel.trailingAnchor, constant: -20),
            changeNameButton.heightAnchor.constraint(equalToConstant: 40),
            changeNameButton.widthAnchor.constraint(equalToConstant: 40),
            
            resetBackroundLabel.topAnchor.constraint(equalTo: nameBackgroundLabel.bottomAnchor, constant: 25),
            resetBackroundLabel.leadingAnchor.constraint(equalTo: nameBackgroundLabel.leadingAnchor),
            resetBackroundLabel.trailingAnchor.constraint(equalTo: nameBackgroundLabel.trailingAnchor),
            resetBackroundLabel.heightAnchor.constraint(equalToConstant: 60),
            
            resetLabel.centerYAnchor.constraint(equalTo: resetBackroundLabel.centerYAnchor),
            resetLabel.leadingAnchor.constraint(equalTo: resetBackroundLabel.leadingAnchor, constant: 20),
            
            resetButton.centerYAnchor.constraint(equalTo: resetBackroundLabel.centerYAnchor),
            resetButton.trailingAnchor.constraint(equalTo: resetBackroundLabel.trailingAnchor, constant: -20),
            resetButton.heightAnchor.constraint(equalToConstant: 40),
            resetButton.widthAnchor.constraint(equalToConstant: 40),
            
            contactBackgroundLabel.topAnchor.constraint(equalTo: resetBackroundLabel.bottomAnchor, constant: 25),
            contactBackgroundLabel.leadingAnchor.constraint(equalTo: resetBackroundLabel.leadingAnchor),
            contactBackgroundLabel.trailingAnchor.constraint(equalTo: resetBackroundLabel.trailingAnchor),
            contactBackgroundLabel.heightAnchor.constraint(equalToConstant: 60),
            
            contactLabel.centerYAnchor.constraint(equalTo: contactBackgroundLabel.centerYAnchor),
            contactLabel.leadingAnchor.constraint(equalTo: contactBackgroundLabel.leadingAnchor, constant: 20),
            
            contactButton.centerYAnchor.constraint(equalTo: contactBackgroundLabel.centerYAnchor),
            contactButton.trailingAnchor.constraint(equalTo: contactBackgroundLabel.trailingAnchor, constant: -20),
            contactButton.heightAnchor.constraint(equalToConstant: 40),
            contactButton.widthAnchor.constraint(equalToConstant: 40),
            ])
    }
    
    private func setupTargets() {
        changeAvatarButton.addTarget(self, action: #selector(changeAvatar), for: .touchUpInside)
        changeNameButton.addTarget(self, action: #selector(changeName), for: .touchUpInside)
        resetButton.addTarget(self, action: #selector(resetApp), for: .touchUpInside)
    }
    
    // MARK: - Acrion Methods
    
    @objc func changeAvatar() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true)
    }
    
    @objc func changeName() {
        print("clicked")
        let alertController = UIAlertController(title: "Change name", message: nil, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            if let textField = alertController.textFields?.first {
                self.nameLabel.text = textField.text
                
                var profile = DataManager.shared.loadFromProfileFile().first ?? Profile(name: "NoName", imageData: nil)
                profile.name = textField.text ?? "NoName"
                
                DataManager.shared.saveJSON(profile: [profile], key: "profile")
                
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        alertController.addTextField { textField in
            textField.placeholder = "Enter name"
        }
        
        present(alertController, animated: true)
    }
    
    @objc func resetApp() {
        let alert = UIAlertController(title: "Reset App Data", message: "⚠️This will delete all your tasks and settings. This action cannot be undone.", preferredStyle: .alert)
        
        let yesAction = UIAlertAction(title: "Yes", style: .default) { _ in
            UserDefaults.standard.set(false, forKey: "hasOnboarded")
            DataManager.shared.removeData()
            UserDefaults.standard.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
            UserDefaults.standard.synchronize()
            exit(0)
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        
        alert.addAction(yesAction)
        alert.addAction(cancel)
        
        present(alert, animated: true)
    }
    
    // MARK: - ImagePicker Delegate
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[.editedImage] as? UIImage ?? info[.originalImage] as? UIImage {
            avatarImage.image = selectedImage
            
            var profile = DataManager.shared.loadFromProfileFile().first ?? Profile(name: "Test", imageData: nil)
            profile.imageData = selectedImage.jpegData(compressionQuality: 0.8)
            
            DataManager.shared.saveJSON(profile: [profile], key: "profile")
        }
        picker.dismiss(animated: true)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
    
    // MARK: - Persistent storage
    
}
