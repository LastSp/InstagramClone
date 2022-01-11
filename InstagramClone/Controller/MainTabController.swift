//
//  MainTabController.swift
//  InstagramClone
//
//  Created by Андрей Колесников on 22.12.2021.
//

import UIKit
import Firebase

class MainTabController: UITabBarController {
    //MARK: - Properties
    private var user: User? {
        didSet {
            guard let user = user else {
                return
            }
            configureViewControllers(withUser: user)
        }
    }
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        checkIfUserIsLoggedIn()
        fetchUser()
    }
    
    //MARK: - API
    
    
    func fetchUser() {
        UserService.fetchUser { user in
            self.user = user
        }
    }
    
    func checkIfUserIsLoggedIn() {
        if Auth.auth().currentUser == nil {
            DispatchQueue.main.async {
                let controller = LoginController()
                controller.delegate = self
                let nav = UINavigationController(rootViewController: controller)
                nav.modalPresentationStyle = .fullScreen
                self.present(nav, animated: true, completion: nil)
            }
            
        }
    }
    
    func logOut() {
        do {
            try Auth.auth().signOut()
        } catch {
            print("Failed to log out")
        }
    }
    
    //MARK: - Helpers
    
    private func configureViewControllers(withUser user: User) {
        
        let feedLayout = UICollectionViewFlowLayout()
        
        let feed = templateNavigationViewController(unselectedImage: UIImage(named: "home_unselected")!, selectedImage: UIImage(named: "home_selected")!, rootViewController: FeedController(collectionViewLayout: feedLayout))
        
        let search = templateNavigationViewController(unselectedImage: UIImage(named: "search_unselected")!, selectedImage: UIImage(named: "search_selected")!, rootViewController: SearchController())
        
        let select = templateNavigationViewController(unselectedImage: UIImage(named: "plus_unselected")!, selectedImage: UIImage(named: "plus_unselected")!, rootViewController: ImageSelectorController())
        
        let notifications = templateNavigationViewController(unselectedImage: UIImage(named: "like_unselected")!, selectedImage: UIImage(named: "like_selected")!, rootViewController: NotificationsController())
        
        let profileController = ProfileController(user: user)
        let profile = templateNavigationViewController(unselectedImage: UIImage(named: "profile_unselected")!, selectedImage: UIImage(named: "profile_selected")!, rootViewController: profileController)
        
        viewControllers = [feed, search, select, notifications, profile]
        tabBar.tintColor = .black
    }
    
    private func templateNavigationViewController(unselectedImage: UIImage, selectedImage: UIImage, rootViewController: UIViewController) -> UINavigationController {
        let navigationController = UINavigationController(rootViewController: rootViewController)
        navigationController.tabBarItem.image = unselectedImage
        navigationController.tabBarItem.selectedImage = selectedImage
        navigationController.navigationBar.tintColor = .black
        return navigationController
    }
}

//MARK: - AuthenticationDelegate

extension MainTabController: AuthenticationDelegate {
    func authenticationDidComplete() {
        fetchUser()
        self.dismiss(animated: true, completion: nil)
    }
}
