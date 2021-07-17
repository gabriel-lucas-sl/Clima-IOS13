//
//  ViewController.swift
//  BuildingASpinner
//
//  Created by Gabriel Silva on 17/07/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        spinner.hidesWhenStopped = true
        spinner.startAnimating()
    }


    @IBAction func stopSpinningPressed(_ sender: UIButton) {
        spinner.stopAnimating()
    }
}

