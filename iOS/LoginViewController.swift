//
//  LoginViewController.swift
//  Characters
//
//  Created by Syd Polk on 7/29/16.
//
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet var fullName: UITextField!
    @IBOutlet var emailAddress: UITextField!
    @IBOutlet var doneButton: UIButton!
    @IBOutlet var pleaseBanner: UILabel!
    @IBOutlet var welcomeBanner: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        let defaults = UserDefaults.standard
        
        var fullyInitialized = true
        var storedFullName = ""
        
        if let storedFullNameObject = defaults.object(forKey: "fullName") {
            storedFullName = storedFullNameObject as! String
            fullName.text = storedFullName
            fullyInitialized = fullyInitialized && (storedFullName != "")
        } else {
            fullyInitialized = false
        }
        
        if let storedEmailAddressObject = defaults.object(forKey: "emailAddress") {
            let storedEmailAddress = storedEmailAddressObject as! String
            emailAddress.text = storedEmailAddress
            fullyInitialized = fullyInitialized && (storedEmailAddress != "")
        } else {
            fullyInitialized = false
        }

        if fullyInitialized {
            welcomeBanner.text = String(format: "Welcome back, %@!", storedFullName)
            welcomeBanner.isHidden = false
            _ = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(LoginViewController.respondToTimer), userInfo: nil, repeats: false)
            Thread.sleep(forTimeInterval: 1.0)
        } else {
            fullName.isHidden = false
            emailAddress.isHidden = false
            pleaseBanner.isHidden = false
            pleaseBanner.isHidden = false
            doneButton.isHidden = false
            doneButton.isEnabled = true
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func checkData() -> Bool {
        if let name = fullName.text {
            if name == "" {
                return false
            }
        } else {
            return false
        }
        
        if let email = emailAddress.text {
            if email == "" {
                return false
            }
        } else {
            return false
        }
        return true
    }
    
    func save() {
        let defaults = UserDefaults.standard
        defaults.set(fullName.text!, forKey: "fullName")
        defaults.set(emailAddress.text!, forKey: "emailAddress")
        defaults.synchronize()
    }

    func respondToTimer() {
        self.performSegue(withIdentifier: "SplitViewSegue", sender: self)
    }
    
    // MARK: - Navigation

    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        return self.checkData()
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        self.save()
    }


}
