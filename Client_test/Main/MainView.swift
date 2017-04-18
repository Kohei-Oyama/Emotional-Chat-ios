//
//  MainView.swift
//  
//
//  Created by Hirano on 2017/04/02.
//
//

import Foundation
import UIKit
import SnapKit
import NextGrowingTextView

// チャットする画面
class MainView : UIView {
    
    var tableView: UITableView = {
        let tableView: UITableView = UITableView(frame: CGRect.zero)
        tableView.backgroundColor = Color.clearBlue
        tableView.separatorColor = UIColor.clear
        tableView.allowsSelection = false
        return tableView
    }()
    private var bottomLayoutConstraint: Constraint?
    var inputTextView = InputTextView()
    
    required override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(self.tableView)
        self.addSubview(self.inputTextView)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShowNotification(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHideNotification(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        tableView.snp.remakeConstraints { (make) -> Void in
            make.top.left.right.equalTo(self)
            make.bottom.equalTo(inputTextView.snp.top)
        }
        
        inputTextView.snp.remakeConstraints { (make) -> Void in
            make.left.right.equalTo(self)
            make.top.equalTo(tableView.snp.bottom)
            self.bottomLayoutConstraint = make.bottom.equalTo(self).constraint
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func requiresConstraintBasedLayout() -> Bool {
        return true
    }
    
    func keyboardWillHideNotification(_ notification: Notification) {
        let userInfo = (notification as NSNotification).userInfo!
        let animationDuration = (userInfo[UIKeyboardAnimationDurationUserInfoKey] as! NSNumber).doubleValue
        let rawAnimationCurve = ((notification as NSNotification).userInfo![UIKeyboardAnimationCurveUserInfoKey] as! NSNumber).uint32Value << 16
        let animationCurve = UIViewAnimationOptions(rawValue: UInt(rawAnimationCurve))
        
        UIView.animate(withDuration: animationDuration, delay: 0.0, options: [.beginFromCurrentState, animationCurve], animations: {
            self.bottomLayoutConstraint?.update(offset: 0)
            self.updateConstraintsIfNeeded()
        }, completion: nil)
    }
    
    func keyboardWillShowNotification(_ notification: Notification) {
        let userInfo = (notification as NSNotification).userInfo!
        let animationDuration = (userInfo[UIKeyboardAnimationDurationUserInfoKey] as! NSNumber).doubleValue
        let keyboardEndFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let convertedKeyboardEndFrame = self.convert(keyboardEndFrame, from: self.window)
        let rawAnimationCurve = ((notification as NSNotification).userInfo![UIKeyboardAnimationCurveUserInfoKey] as! NSNumber).uint32Value << 16
        let animationCurve = UIViewAnimationOptions(rawValue: UInt(rawAnimationCurve))
        UIView.animate(withDuration: animationDuration, delay: 0.0, options: [.beginFromCurrentState, animationCurve], animations: {
            self.bottomLayoutConstraint?.update(offset: -convertedKeyboardEndFrame.height)
            self.updateConstraintsIfNeeded()
        }, completion: nil)
    }
}
