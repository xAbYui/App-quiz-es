//
//  SignUpViewController.swift
//  quiz 1stAttempt
//
//  Created by 渡辺唯都 on 2017/08/06.
//  Copyright © 2017年 渡辺唯都. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class SignUpViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var emailtext: UITextField!
    @IBOutlet var passwordtext: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailtext.delegate = self //デリゲートをセット
        passwordtext.delegate = self //デリゲートをセット
        passwordtext.isSecureTextEntry = true // 文字を非表示に
        
        self.layoutFacebookButton()

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //ログインしていれば、遷移
        //FIRAuthがユーザー認証のためのフレーム
        //checkUserVerifyでチェックして、ログイン済みなら画面遷移
        if self.checkUserVerify() {
            self.transitionToView()
        }
    }
    func checkUserVerify()  -> Bool {
        guard let user = Auth.auth().currentUser else { return false }
        return user.isEmailVerified
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func Signup() {
        signup()
    }
    
    @IBAction func willTransitionToLogin() {
        transitionToLogin()
    }
    @IBAction func willLoginWithFacebook() {
        self.loginWithFacebook()
    }
    
    func loginWithFacebook() {}
    func layoutFacebookButton() {}
    
    func transitionToLogin() {
        self.performSegue(withIdentifier: "toLogin", sender: self)
    }
    func transitionToView() {
        self.performSegue(withIdentifier: "toView", sender: self)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    //Signupのためのメソッド
    func signup() {
        //emailTextFieldとpasswordTextFieldに文字がなければ、その後の処理をしない
        guard let email = emailtext.text else  { return }
        guard let password = passwordtext.text else { return }
        //FIRAuth.auth()?.createUserWithEmailでサインアップ
        //第一引数にEmail、第二引数にパスワード
        Auth.auth().createUser(withEmail: email, password: password, completion: { (user, error) in
            //エラーなしなら、認証完了
            if error == nil{
                // メールのバリデーションを行う
                user?.sendEmailVerification(completion: { (error) in
                    if error == nil {
                        // エラーがない場合にはそのままログイン画面に飛び、ログインしてもらう
                        self.transitionToLogin()
                    }else {
                        print("\(error?.localizedDescription)")
                    }
                })
            }else {
                
                print("\(error?.localizedDescription)")
            }
        })
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
