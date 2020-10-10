//
//  BaseViewController.swift
//  MovieShowcase
//
//  Created by Pratik on 10/10/20.
//  Copyright © 2020 Pratik Lad. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    var loaderView: UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pageSettings()
    }
    
    private func pageSettings() {
        view.backgroundColor = #colorLiteral(red: 0.1333333333, green: 0.1529411765, blue: 0.1803921569, alpha: 1)
    }
    /// Task bar network indicator
    /// - Parameter isVisible: bool value
    func networkActivityIndicator(isVisible: Bool) {
        DispatchQueue.main.async {
            UIApplication.shared.isNetworkActivityIndicatorVisible = isVisible
        }
    }
    
    /// Activity indicator add on view
    /// - Parameter onView: presenter view
    func displayActivityIndicator(onView : UIView) {
        let containerView = UIView.init(frame: onView.bounds)
        containerView.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        let activityIndicator = UIActivityIndicatorView.init(style: .whiteLarge)
        activityIndicator.startAnimating()
        activityIndicator.center = containerView.center
        DispatchQueue.main.async {
            containerView.addSubview(activityIndicator)
            onView.addSubview(containerView)
            self.networkActivityIndicator(isVisible: true)
        }
        loaderView = containerView
    }
    
    /// Activity indicator remove
    func removeActivityIndicator() {
        DispatchQueue.main.async {
            self.loaderView?.removeFromSuperview()
            self.loaderView = nil
            self.networkActivityIndicator(isVisible: false)
        }
    }
    
    /// Alert display on controller
    /// - Parameters:
    ///   - title: title for alert
    ///   - message: alert message
    ///   - actions: array of action (default = OK button without action)
    func displayAlert(with title: String = CommonConstant.appName, message: String, actions: [UIAlertAction]? = nil) {
        guard presentedViewController == nil else {
            return
        }
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        //no actions found then add OK button
        if let customActions = actions {
            customActions.forEach { action in
                alertController.addAction(action)
            }
        } else {
            let okButton = UIAlertAction(title: "OK", style: .default)
            alertController.addAction(okButton)
        }
        present(alertController, animated: true)
    }
}
