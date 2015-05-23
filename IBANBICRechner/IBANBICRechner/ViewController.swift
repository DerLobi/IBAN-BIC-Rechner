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
    
    var viewModel: ViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = ViewModel()
        blzTextField.becomeFirstResponder()
        
        blzTextField.rx_text().subscribe(viewModel.BLZ)
        ktoTextField.rx_text().subscribe(viewModel.accountNumber)
        
        ibanLabel.rx_subscribeTextTo(viewModel.IBAN)        
        bicLabel.rx_subscribeTextTo(viewModel.BIC)

        bankNameLabel.rx_subscribeTextTo(viewModel.bankName)
        cityLabel.rx_subscribeTextTo(viewModel.city)

    }
}

