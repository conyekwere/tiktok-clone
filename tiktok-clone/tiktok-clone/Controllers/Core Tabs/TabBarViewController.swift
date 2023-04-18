//
//  TabBaarViewController.swift
//  tiktok-clone
//
//  Created by Chima onyekwere on 3/25/23.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpControllers()
        // Do any additional setup after loading the view.
    }
    private func setUpControllers(){
        let home = HomeViewController()
        let explore = ExploreViewController()
        let camera = CameraViewController()
        let notifications = NotificationsViewController()
        let profile = ProfileViewController(
            user: User(username: "madebychima",
            profilePictureURL: URL(string: "https://source.unsplash.com/random/1920x1080/?profile,headshot,man,african")!,
            identifier: UUID().uuidString))
        notifications.title = "Notifications"
        profile.title = "Profile"
        
        let navOne = UINavigationController(rootViewController: home)
        let navTwo = UINavigationController(rootViewController: explore)
        let navFour = UINavigationController(rootViewController: notifications)
        let navFive = UINavigationController(rootViewController: profile)
        
        
        navOne.navigationBar.backgroundColor = .clear
        navOne.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navOne.navigationBar.shadowImage = UIImage()
        
        navOne.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "house"), tag: 1)
        navTwo.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "magnifyingglass"), tag: 2)
        camera.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "plus.rectangle"), tag: 3)
        navFour.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "bell"), tag: 4)
        navFive.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "person.circle"), tag: 5)
        
        setViewControllers([navOne,navTwo,camera,navFour,navFive], animated: false)
        
        
    }

}
