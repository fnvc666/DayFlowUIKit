//
//  WelcomeViewController.swift
//  ToDoListWithDesign
//
//

import UIKit

class WelcomeViewController: UIViewController {
    
    // MARK: - Properties
    
    private let images: [UIImage?] = [
        UIImage(systemName: "pencil.and.list.clipboard"),
        UIImage(systemName: "circle"),
        UIImage(systemName: "checkmark.circle.fill")
    ]
    
    private let slideImages: [UIImage?] = [
        UIImage(systemName: "chevron.left.chevron.left.dotted"),
        UIImage(systemName: "chevron.left.2")
    ]
    
    private var currentIndex = 0
    private var currentSlideIndex = 0
    private var imageTimer: Timer?
    private var imageSlideTimer: Timer?
    
    
    // MARK: - UI Components
    
    private let logoImagaView: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = .white
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "DayFlow"
        label.textColor = .white
        label.font = UIFont(name: "Monoton", size: 40)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let slideHere: UILabel = {
        let label = UILabel()
        label.text = "slide"
        label.textColor = .lightText
        label.font = UIFont.systemFont(ofSize: 20, weight: .light)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let slideImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = .lightText
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        animateLogo()
        animatedSlide()
    }
    
    private func setupUI() {
        view.backgroundColor = UIColor(red: 0.762, green: 0.439, blue: 0.445, alpha: 1)
        view.addSubview(logoImagaView)
        view.addSubview(nameLabel)
        view.addSubview(slideHere)
        view.addSubview(slideImageView)
        
        setupConstaints()
    }
    
    private func setupConstaints() {
        NSLayoutConstraint.activate([
            logoImagaView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImagaView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -100),
            logoImagaView.widthAnchor.constraint(equalToConstant: 180),
            logoImagaView.heightAnchor.constraint(equalToConstant: 180),
            
            nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nameLabel.topAnchor.constraint(equalTo: logoImagaView.bottomAnchor, constant: 16),
            
            slideHere.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 250),
            slideHere.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            slideImageView.topAnchor.constraint(equalTo: slideHere.bottomAnchor),
            slideImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            slideImageView.heightAnchor.constraint(equalToConstant: 50),
            slideImageView.widthAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    private func animateLogo() {
        logoImagaView.image = images.first ?? nil
        imageTimer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(changeImage), userInfo: nil, repeats: true)
    }
    
    private func animatedSlide() {
        slideImageView.image = slideImages.first ?? nil
        imageSlideTimer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(changeImageSlide), userInfo: nil, repeats: true)
        
    }

    @objc private func changeImage() {
        currentIndex = (currentIndex + 1) % images.count
        let nextImage = images[currentIndex]
        
        UIView.transition(with: logoImagaView, duration: 0.5, options: .transitionCrossDissolve, animations: {
            self.logoImagaView.image = nextImage }, completion: nil)
    }
    
    @objc private func changeImageSlide() {
        currentSlideIndex = (currentSlideIndex + 1) % slideImages.count
        let nextImage = slideImages[currentSlideIndex]
        
        let screenWidth = view.bounds.width
        
        UIView.animate(withDuration: 0.5, animations: {
            self.slideImageView.transform = CGAffineTransform(translationX: -screenWidth, y: 0)
        }, completion: { _ in
            self.slideImageView.transform = CGAffineTransform(translationX: screenWidth, y: 0)
            self.slideImageView.image = nextImage
            
            UIView.animate(withDuration: 0.5) {
                self.slideImageView.transform = .identity
            }
        })
    }

}
