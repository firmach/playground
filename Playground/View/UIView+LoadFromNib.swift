//
//  UIView+LoadFromNib.swift
//
//  Created by Roman Churkin on 28/11/2018.
//

import UIKit


public extension UIView {
    
    class func loadFromNib() -> Self? {
        return viewFromNib(view: self)
    }
    
}


fileprivate func viewFromNib<T: UIView>(view: T.Type) -> T? {
    let bundle = Bundle(for: T.self)
    let className = String(describing: T.self)
    
    guard bundle.path(forResource: className, ofType: "nib") != nil
        else { return .none }
    
    guard let nibContent = bundle.loadNibNamed(className, owner: nil)
        else { return .none }
    
    for element in nibContent where element is T {
        return (element as! T)
    }
    
    return .none
}
