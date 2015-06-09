//
//  ViewController.swift
//  IBANBICRechner
//
//  Created by Christian Lobach on 21/05/15.
//  Copyright (c) 2015 Christian Lobach. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {

    @IBOutlet weak var blzTextField: UITextField!
    @IBOutlet weak var ktoTextField: UITextField!
    
    @IBOutlet weak var ibanLabel: UILabel!
    @IBOutlet weak var bicLabel: UILabel!
    
    @IBOutlet weak var bankNameLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    
    @IBOutlet var spacingConstraints: [NSLayoutConstraint]!
    
    @IBOutlet var labelHeightConstraints: [NSLayoutConstraint]!
    
    var viewModel: ViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = ViewModel()
        ktoTextField.becomeFirstResponder()
        
        blzTextField.rx_text.subscribe(viewModel.BLZ)
        ktoTextField.rx_text.subscribe(viewModel.accountNumber)
        
        ibanLabel.rx_subscribeTextTo(viewModel.IBAN)        
        bicLabel.rx_subscribeTextTo(viewModel.BIC)

        bankNameLabel.rx_subscribeTextTo(viewModel.bankName)
        cityLabel.rx_subscribeTextTo(viewModel.city)
        
        updateUIForSmallDevices()
    }
    
    private func updateUIForSmallDevices() {
        
        let height = CGRectGetHeight(UIScreen.mainScreen().bounds)
        if height > 480 {
            return
        }
        
        for constraint in spacingConstraints {
            constraint.constant = 4
        }
        
        for constraint in labelHeightConstraints {
            constraint.constant = 25
        }
        
        var labelFont = ibanLabel.font;
        labelFont = UIFont(name: labelFont.fontName, size: 26)
        
        ibanLabel.font = labelFont
        bicLabel.font = labelFont
        bankNameLabel.font = labelFont
        cityLabel.font = labelFont
    }

    @IBAction func labelLongPressed(sender: UILongPressGestureRecognizer) {
        sender.view?.becomeFirstResponder()
        let menuController = UIMenuController.sharedMenuController()
        menuController.setTargetRect(sender.view!.frame, inView: sender.view!.superview!)
        menuController.setMenuVisible(true, animated: true)
    }
    
    
    
}

