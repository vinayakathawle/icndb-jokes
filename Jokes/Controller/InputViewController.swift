//
//  InputViewController.swift
//  Jokes
//
//  Created by Vinayak Kakade on 5/6/18.
//  Copyright © 2018 Vinayak Kakade. All rights reserved.
//

import UIKit

class InputViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var firstNMTextField: UITextField!
    @IBOutlet weak var lastNMTextField: UITextField!
    @IBOutlet weak var continueBtn: UIButton!
    
    @IBOutlet weak var countLbl: UILabel!
    @IBOutlet weak var titleLbl: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLbl.applyAmbossEffect()
        
        bgView.shapeView()
        
        // appling shape to textfield
        firstNMTextField.shapeTextField()
        lastNMTextField.shapeTextField()
        
        // appling shape to button
        continueBtn.shapeButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.navigationController?.navigationBar.isHidden = true
    }
    @IBAction func generateJoke(_ sender: Any) {
        guard let fNM = firstNMTextField.text, !fNM.isEmpty else { // validation check for firstname empty or not
            ApplicationUtility.showToast(message: FNAME_VALIDATOIN_MSG)
            return
        }
        guard let lNM = lastNMTextField.text, !lNM.isEmpty else { // validation check for lastname empty or not
            ApplicationUtility.showToast(message: LNAME_VALIDATOIN_MSG)
            return
        }
        
        if Reachability.isReachable() {            
            // perform segue to navigate on JokeViewController
            self.performSegue(withIdentifier: JOKE_VIEW_SEGUE, sender: sender)
        } else {
            ApplicationUtility.showToast(message: NO_INTERNET_MSG)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == JOKE_VIEW_SEGUE {
            if let jokeGeneratorVC = segue.destination as? JokeViewController{
                jokeGeneratorVC.fName = firstNMTextField.text // pass firstname to JokeViewContoller
                jokeGeneratorVC.lName = lastNMTextField.text // pass lastname to JokeViewContoller
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if textField == firstNMTextField { // Switch focus to other text field
            lastNMTextField.becomeFirstResponder()
        }
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

