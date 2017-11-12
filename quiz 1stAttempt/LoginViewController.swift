//
//  LoginViewController.swift
//  quiz 1stAttempt
//
//  Created by 渡辺唯都 on 2017/08/06.
//  Copyright © 2017年 渡辺唯都. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var emailtext: UITextField!
    @IBOutlet var passwordtext: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailtext.delegate = self //デリゲートをセット
        passwordtext.delegate = self //デリゲートをセット
        passwordtext.isSecureTextEntry  = true // 文字を非表示に
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

        // Do any additional setup after loading the view.
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func didRegisterUser() {
    //ログインのためのメソッド
        login()
    }
    //Returnキーを押すと、キーボードを隠す
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    //ログイン完了後に、ListViewControllerへの遷移のためのメソッド
    func transitionToView()  {
        self.performSegue(withIdentifier: "toVC", sender: self)
    }
    
    //ログインのためのメソッド
    func login() {
        //EmailとPasswordのTextFieldに文字がなければ、その後の処理をしない
        guard let email = emailtext.text else { return }
        guard let password = passwordtext.text else { return }
        
        //signInWithEmailでログイン
        //第一引数にEmail、第二引数にパスワードを取ります
        Auth.auth().signIn(withEmail: email, password: password, completion: { (user, error) in
            //エラーがないことを確認
            if error == nil {
                if let loginUser = user {
                    // バリデーションが完了しているか確認。完了ならそのままログイン
                    if self.checkUserValidate(user: loginUser) {
                        // 完了済みなら、ListViewControllerに遷移
                        print(Auth.auth().currentUser)
                        self.transitionToView()
                    }else {
                        // 完了していない場合は、アラートを表示
                        self.presentValidateAlert()
                    }
                }
            }else {
                print("error...\(error?.localizedDescription)")
            }
        })
    }
    
    // ログインした際に、バリデーションが完了しているか返す
    func checkUserValidate(user: User)  -> Bool {
        return user.isEmailVerified
    }
    // メールのバリデーションが完了していない場合のアラートを表示
    func presentValidateAlert() {
        let alert = UIAlertController(title: "メール認証", message: "メール認証を行ってください", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

}


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

