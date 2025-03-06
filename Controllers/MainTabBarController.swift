import UIKit

class MainTabBarController: UITabBarController {

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewControllers()
        setupAppearance()
    }
    
    // MARK: - Setup Methods
    private func setupViewControllers() {
        let mainVC = MainController()
        let mainTabBarItem = UITabBarItem(
            title: nil,
            image: UIImage(systemName: "square.stack.3d.down.right"),
            selectedImage: UIImage(systemName: "square.stack.3d.down.right.fill")
        )
        mainVC.tabBarItem = mainTabBarItem
        
        
        let taskDetailsVC = TaskDetailsViewController()
        let taskDetailsTabBarItem = UITabBarItem(
            title: nil,
            image: UIImage(systemName: "chart.bar.horizontal.page"),
            selectedImage: UIImage(systemName: "chart.bar.horizontal.page.fill")
        )
        
        taskDetailsVC.tabBarItem = taskDetailsTabBarItem
        
        
        let settingsVC = SettingsViewController()
        let settingsTabBarItem = UITabBarItem(
            title: nil,
            image: UIImage(systemName: "gearshape"),
            selectedImage: UIImage(systemName: "gearshape.fill")
        )
        settingsVC.tabBarItem = settingsTabBarItem
        
        
        let mainNav = UINavigationController(rootViewController: mainVC)
        self.viewControllers = [mainNav, taskDetailsVC, settingsVC]
    }
    
    private func setupAppearance() {
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.backgroundColor = .white

        tabBarAppearance.stackedLayoutAppearance.normal.iconColor = .black
        tabBarAppearance.stackedLayoutAppearance.selected.iconColor = .black

        self.tabBar.standardAppearance = tabBarAppearance
        if #available(iOS 15.0, *) {
            self.tabBar.scrollEdgeAppearance = tabBarAppearance
        }
    }
}
