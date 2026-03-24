//
//  AlertViewController.swift
//  MiAppNasa
//
//  Created by Cinthia Villegas on 23/03/26.
//

import UIKit

class AlertViewController: UIViewController {

    @IBOutlet weak var lblTitleAlert: UILabel!
    
    @IBOutlet weak var lblMessageAlert: UILabel!
    
    @IBOutlet weak var btnRetry: UIButton!
    
    public var onRetry: (() -> Void)?
    
    public var textFrom : String = ""
    public var msgFrom : String = ""
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupUI()
    }

    func setupUI() {
        if textFrom != "", msgFrom != ""{
            lblTitleAlert.text = textFrom
            lblMessageAlert.text = msgFrom
        }
        lblTitleAlert.text = ""
        lblMessageAlert.text = ""
       
        
    }

    @IBAction func onClickedRetry(_ sender: Any) {
        dismiss(animated: true, completion: onRetry)
    }
}
