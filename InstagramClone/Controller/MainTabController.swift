//
//  MainTabController.swift
//  InstagramClone
//
//  Created by Андрей Колесников on 22.12.2021.
//

import UIKit
import Firebase
import YPImagePicker

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
        
        self.delegate = self
        
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
    
    func didFinishPickingMedia(_ picker: YPImagePicker) {
        picker.didFinishPicking { items, _ in
            picker.dismiss(animated: false) {
                guard let selectedImage = items.singlePhoto?.image else { return }
                let controller = UploadPostController()
                controller.selectedImage = selectedImage
                controller.delegate = self
                controller.currentUser = self.user
                let nav = UINavigationController(rootViewController: controller)
                nav.modalPresentationStyle = .fullScreen
                self.present(nav, animated: false, completion: nil)
            }
        }
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


extension MainTabController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        let index = viewControllers?.firstIndex(of: viewController)
        if index == 2 {
            var configuration = YPImagePickerConfiguration()
            configuration.library.mediaType = .photo
            configuration.shouldSaveNewPicturesToAlbum = false
            configuration.startOnScreen = .library
            configuration.screens = [.library]
            configuration.hidesStatusBar = false
            configuration.hidesBottomBar  = false
            configuration.library.maxNumberOfItems = 1
            let picker = YPImagePicker(configuration: configuration)
            
            picker.modalPresentationStyle = .fullScreen
            picker.view.backgroundColor = .white

            present(picker, animated: true)
            didFinishPickingMedia(picker)

        }
        return true
    }
}

//MARK: - UploadPostControllerDelegate
extension MainTabController: UploadPostControllerDelegate {
    func controllerDidFinishUploadingPost(_ controller: UploadPostController) {
        selectedIndex = 0
        controller.dismiss(animated: true, completion: nil)
        
        guard let feedNav = viewControllers?.first as? UINavigationController else { return }
        guard let feed = feedNav.viewControllers.first as? FeedController else { return }
        
        feed.handleRefresh()
    }

}
