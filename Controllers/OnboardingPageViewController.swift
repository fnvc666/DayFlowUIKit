//
//  OnboardingPageViewController.swift
//  ToDoListWithDesign
//
//

import UIKit

class OnboardingPageViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    var currentIndex = 0
    var pages: [UIViewController] = [
        WelcomeViewController(),
        InfoViewController(),
        ProfileSetupViewController()
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        dataSource = self
        delegate = self
        
        if let firstVC = pages.first {
            setViewControllers([firstVC], direction: .forward, animated: true)
        }
    }
    

    // MARK: - DataSource Methods
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = pages.firstIndex(of: viewController), currentIndex > 0 else { return nil }
        return pages[currentIndex - 1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = pages.firstIndex(of: viewController), currentIndex < pages.count - 1 else { return nil }
        return pages[currentIndex + 1]
    }

    // MARK: - PageControl Methods
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return pages.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return currentIndex
    }
}
