//
//  MainTabBarController.swift
//  04_02TabbarController_NoStoryboard
//
//  Created by 이윤주 on 9/1/24.
//

import UIKit

class MainTabBarController:UITabBarController{
    override func viewDidLoad() {
        super.viewDidLoad()
        let firstNC = UINavigationController.init(rootViewController: MyViewController(title:"첫번째", bgColor: UIColor.red))
        let secondNC = UINavigationController.init(rootViewController: MyViewController(title:"두번째", bgColor: UIColor.blue))
        let thirdNC = UINavigationController.init(rootViewController: MyViewController(title:"세번째", bgColor: UIColor.purple))
        let fourthNC = UINavigationController.init(rootViewController: MyViewController(title:"네번째", bgColor: UIColor.systemPink))
        
        self.viewControllers = [firstNC,secondNC,thirdNC,fourthNC]
        
        let firstTabBarItem = UITabBarItem(title: "첫번째", image: UIImage(systemName: "airplayaudio"), tag: 0)
        let secondTabBarItem = UITabBarItem(title: "두번째", image: UIImage(systemName: "airplayvideo"), tag: 1)
        let thirdTabBarItem = UITabBarItem(title: "세번째", image: UIImage(systemName: "arrow.clockwise.icloud.fill"), tag: 2)
        let fourthTabBarItem = UITabBarItem(title: "네번째", image: UIImage(systemName: "safari.fill"), tag: 3)
        
        firstNC.tabBarItem = firstTabBarItem
        secondNC.tabBarItem = secondTabBarItem
        thirdNC.tabBarItem = thirdTabBarItem
        fourthNC.tabBarItem = fourthTabBarItem
        
    }

}
