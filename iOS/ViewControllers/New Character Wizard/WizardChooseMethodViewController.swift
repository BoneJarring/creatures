//
//  WizardChooseMethodViewController.swift
//  iOS
//
//  Created by Syd Polk on 6/24/17.
//  Copyright © 2017 Bone Jarring Games and Software. All rights reserved.
//

import UIKit

private let chooseAbilityViewControllerNames : [String:String] = [
    "standard" : "WizardAbilities4d6",
    "transfer" : "WizardSetAbiltiesIPhone"
]

class WizardChooseMethodViewController: UIViewController {

    @IBOutlet weak var doneButton: UIBarButtonItem!
    
    @IBOutlet weak var standardButton: UIButton!
    @IBOutlet weak var classicButton: UIButton!
    @IBOutlet weak var heroicButton: UIButton!
    @IBOutlet weak var dicePoolButton: UIButton!
    @IBOutlet weak var purchaseButton: UIButton!
    @IBOutlet weak var transferButton: UIButton!
    
    var wizardViewController: WizardPageViewController? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        wizardViewController = self.parent as? WizardPageViewController

        standardButton.isHidden = false
        classicButton.isHidden = true
        heroicButton.isHidden = true
        dicePoolButton.isHidden = true
        purchaseButton.isHidden = true
        transferButton.isHidden = false
        
        setDoneButton()
        
        // Do any additional setup after loading the view.
    }

    func replaceChooseMethodControllerWithController(_ name: String) {
        let newController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: name)
        wizardViewController?.wizardViewControllers[2] = newController
        wizardViewController?.setViewControllers([newController], direction: .forward, animated: true, completion: nil)
    }
    
    @IBAction func standard(_ sender: Any) {
        replaceChooseMethodControllerWithController("WizardAbilities4d6")
    }
    
    @IBAction func classic(_ sender: Any) {
    }
    
    @IBAction func heroic(_ sender: Any) {
    }
    
    @IBAction func dicePool(_ sender: Any) {
    }
    
    @IBAction func purchase(_ sender: Any) {
    }
    
    @IBAction func transfer(_ sender: Any) {
        replaceChooseMethodControllerWithController("WizardSetAbiltiesIPhone")
    }
    
    func setDoneButton() {
        doneButton.isEnabled = (wizardViewController?.isCharacterReady())!
    }

    @IBAction func cancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        wizardViewController?.cancel()
    }
    
    @IBAction func done(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        wizardViewController?.done()
    }
}
