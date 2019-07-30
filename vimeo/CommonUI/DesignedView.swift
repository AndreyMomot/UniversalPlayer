//
//  DesignedView.swift


import UIKit

extension UIView {
    
    @discardableResult func addContentFromNib (named nibName: String?) -> UIView? {
        if let nib_name = nibName, let containerView = Bundle(for: type(of: self)).loadNibNamed(nib_name, owner: self, options: nil)?.first as? UIView {
            containerView.frame = self.bounds
            containerView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            self.addSubview(containerView)
            return containerView
        }
        else {
            return nil
        }
    }
}
