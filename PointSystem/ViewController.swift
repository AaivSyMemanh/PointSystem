//
//  ViewController.swift
//  PointSystem
//
//  Created by dongruixuan on 2017/10/3.
//  Copyright © 2017年 dongruixuan. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController,UITextFieldDelegate {

    var login = Login()
    @IBOutlet weak var uibutton: UIButton!
    @IBOutlet weak var activity: UIActivityIndicatorView!
    @IBOutlet weak var Username: UITextField!
    @IBOutlet weak var Password: UITextField!
    var account:Account?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.Username.returnKeyType = UIReturnKeyType.next
        self.Username.delegate = self
        self.Password.returnKeyType = UIReturnKeyType.done
        self.Password.delegate = self
        self.activity.hidesWhenStopped = true
        self.view.addSubview(self.activity)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
  //      var vc = segue.destination as! NavigationController
    //    vc.account = sender as! Account
    //}
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        //收起键盘
        if(textField.placeholder == "用户名"){
            self.Password.becomeFirstResponder()
        }else{
            textField.resignFirstResponder()
            LoginButtonPressed(uibutton)
        }
        return true;
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let listview = segue.destination as! ListViewController
        listview.account = self.account
    }
    @IBAction func LoginButtonPressed(_ sender: UIButton) {
        self.uibutton.isEnabled = false
        self.uibutton.setTitle("", for: .normal)
        self.activity.center = self.uibutton.center
        self.activity.startAnimating()
        let queue = DispatchQueue.init(label: "top.starcatmeow.pointsystem.login");
        queue.async {
        print(self.Username.text!)
            print(self.Password.text!)
        var last = self.login.LoginWithUsernameandPassword(Username: self.Username.text!, Password: self.Password.text!)
        print(last)
        if(last == "Failed"){
            self.activity.stopAnimating()
            self.uibutton.setTitle("登录", for: .normal)
            self.uibutton.isEnabled = true
            var alertController = UIAlertController(title: "警告", message: "用户名或密码错误", preferredStyle: UIAlertControllerStyle.alert)
            var okbtn = UIAlertAction(title: "好", style: UIAlertActionStyle.default, handler: nil)
            alertController.addAction(okbtn)
            self.present(alertController, animated: true, completion: nil)
        }else if(last == "NetworkError"){
            self.activity.stopAnimating()
            self.uibutton.setTitle("登录", for: .normal)
            self.uibutton.isEnabled = true
            var alertController = UIAlertController(title: "警告", message: "无法连接至服务器", preferredStyle: UIAlertControllerStyle.alert)
            var okbtn = UIAlertAction(title: "好", style: UIAlertActionStyle.default, handler: nil)
            alertController.addAction(okbtn)
            self.present(alertController, animated: true, completion: nil)
        }else{
            print(2)
            let decoder = JSONDecoder()
            let over = try! decoder.decode(Account.self,from: last.data(using: .utf8)!)
            self.account = over
            let permission = Int(over.permission)!
            if(permission>0){
                print(permission)
                self.performSegue(withIdentifier: "has",sender: self)
            }else{
                print(permission)
                self.performSegue(withIdentifier: "hasnot",sender: self)
            }
        }
        }
    }

}
struct Account : Codable{
    var id: String
    var username: String
    var password: String
    var chinesename: String
    var points: String
    var permission: String
}

