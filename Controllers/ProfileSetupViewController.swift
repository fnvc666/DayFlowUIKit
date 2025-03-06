//
//  ProfileSetupViewController.swift
//  ToDoListWithDesign
//
//

import UIKit

class ProfileSetupViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    // MARK: - UI Components
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "photo.circle.fill")
        imageView.tintColor = .white
        imageView.layer.cornerRadius = 125
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let setProfileImageButton: UIButton = {
        let button = UIButton()
        button.setTitle("Set profile image", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .lightText
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Set your name"
        textField.backgroundColor = .lightText
        textField.borderStyle = .roundedRect
        textField.layer.cornerRadius = 10
        textField.layer.masksToBounds = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let nextButton: UIButton = {
        let button = UIButton()
        button.setTitle("Next", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 10
        button.backgroundColor = .lightText
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    // MARK: - Setup Methods
    
    func setupUI() {
        view.backgroundColor = UIColor(red: 0.762, green: 0.439, blue: 0.445, alpha: 1)
        
        view.addSubview(profileImageView)
        view.addSubview(setProfileImageButton)
        view.addSubview(nameTextField)
        view.addSubview(nextButton)
        
        setupConstaints()
        setupTargets()
    }
    
    func setupConstaints() {
        NSLayoutConstraint.activate([
            profileImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            profileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            profileImageView.heightAnchor.constraint(equalToConstant: 250),
            profileImageView.widthAnchor.constraint(equalToConstant: 250),
            
            setProfileImageButton.topAnchor.constraint(equalTo: profileImageView.bottomAnchor),
            setProfileImageButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            setProfileImageButton.widthAnchor.constraint(equalToConstant: 150),
            setProfileImageButton.heightAnchor.constraint(equalToConstant: 45),
            
            nameTextField.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 120),
            nameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nameTextField.widthAnchor.constraint(equalToConstant: 250),
            nameTextField.heightAnchor.constraint(equalToConstant: 45),
            
            nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nextButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40),
            nextButton.widthAnchor.constraint(equalToConstant: 125),
            nextButton.heightAnchor.constraint(equalToConstant: 45),
        ])
    }
    
    func setupTargets() {
        setProfileImageButton.addTarget(self, action: #selector(setAvatar), for: .touchUpInside)
        nextButton.addTarget(self, action: #selector(nextTapped), for: .touchUpInside)
    }
    
    // MARK: - Action Methods
    
    @objc func setAvatar() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true)
        
    }
    
    @objc func nextTapped() {
        if (nameTextField.text?.isEmpty ?? true) || (profileImageView.image == nil) {
            let alert = UIAlertController(title: "Warning", message: "Set Image and Profile Name", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .cancel)
            
            alert.addAction(ok)
            present(alert, animated: true)
        } else {
            var profile = Profile(name: nameTextField.text, imageData: nil)
            profile.imageData = profileImageView.image?.jpegData(compressionQuality: 0.8)
            DataManager.shared.saveJSON(profile: [profile], key: "profile")
            UserDefaults.standard.set(true, forKey: "hasOnboarded")
            let tabBar = MainTabBarController()
            
            if let sceneDelegate = self.view.window?.windowScene?.delegate as? SceneDelegate,
               let window = sceneDelegate.window {
                UIView.transition(with: window, duration: 0.5, options: .transitionCrossDissolve) {
                    window.rootViewController = tabBar
                }
            }
        }
    }
    
    // MARK: - UIImagePickerControllerDelegate Methods
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[.editedImage] as? UIImage ?? info[.originalImage] as? UIImage {
            profileImageView.image = selectedImage
        }
        picker.dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}
