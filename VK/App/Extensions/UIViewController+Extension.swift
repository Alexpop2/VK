//
//  UIViewController.swift
//  VK
//
//  Created by Рабочий on 14/02/2019.
//  Copyright © 2019 Рабочий. All rights reserved.
//

import UIKit

extension UIViewController {
    
    // MARK: - Properties
    
    @nonobjc static var storyboardId: String {
        return String(describing: self)
    }
    
    // MARK: - Initialization
    
    class func instantiateFromStoryboard(with storyboardName: StoryboardName, storyboardID: String? = nil) -> Self? {
        let storyboard = UIStoryboard(name: storyboardName.rawValue, bundle: nil)
        return instantiate(from: storyboard, withIdentifier: storyboardID ?? self.storyboardId)
    }
    private class func instantiate<T>(from storyboard: UIStoryboard, withIdentifier identifier: String) -> T? {
        return storyboard.instantiateViewController(withIdentifier: identifier) as? T
    }
    
}
