//
//  QuizViewController.swift
//  quiz 1stAttempt
//
//  Created by 渡辺唯都 on 2017/06/11.
//  Copyright © 2017年 渡辺唯都. All rights reserved.
//

import UIKit
import Firebase

class QuizViewController: UIViewController, UITextFieldDelegate {
    
    let ref = Database.database().reference()
    
    @IBOutlet var sentencequizmake: UITextField!
    @IBOutlet var mulitpleFquizmake: UITextField!
    //@IBOutlet var mulitpleSquizmake: UITextField!
    //@IBOutlet var mulitpleTquizmake: UITextField!
    
    
    var savedata : UserDefaults = UserDefaults.standard
    
    var makequizarray: [[String]]?
    
    @IBAction func savequiz() {
        // makequizArray.appendをする
        // [sentencequizmake.text, multipleFquiz.text]
        // savedata.set(makequizarray, forKey: hogehoge)
        makequizarray?.append([sentencequizmake.text!,mulitpleFquizmake.text!])
        
        savedata.set(makequizarray, forKey: "Job")
        
        savedata.set(sentencequizmake.text, forKey: "SentenceQuiz") //問題作成の質問セーブ
        savedata.set(mulitpleFquizmake.text, forKey: "FirstQuiz") //問題作成の答えセーブ
        //savedata.set(mulitpleSquizmake.text, forKey: "SecondQuiz")
        //savedata.set(mulitpleTquizmake.text, forKey: "ThirdQuiz")
        savedata.synchronize()
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sentencequizmake.delegate = self //デリゲートをセット
        mulitpleFquizmake.delegate = self //デリゲートをセット
        // もしmakequizarrayがnilなら空の配列にする
        // var makequizArray: [[String]]?
        

        // Do any additional setup after loading the view.
    }
    //Returnキーを押すと、キーボードを隠す
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //投稿ボタン
    @IBAction func post(sender: UIButton) {
        //投稿のためのメソッド
        create()
        
    }
    //データの送信のメソッド
    func create() {
        //textFieldになにも書かれてない場合は、その後の処理をしない
        guard let text = sentencequizmake.text else { return }
        guard let textt = mulitpleFquizmake.text else { return }
        //ロートからログインしているユーザーのIDをchildにしてデータを作成
        //childByAutoId()でユーザーIDの下に、IDを自動生成してその中にデータを入れる
        //setValueでデータを送信する。第一引数に送信したいデータを辞書型で入れる
        //今回は記入内容と一緒にユーザーIDと時間を入れる
        //FIRServerValue.timestamp()で現在時間を取る
        self.ref.child((Auth.auth().currentUser?.uid)!).childByAutoId().setValue(["user": (Auth.auth().currentUser?.uid)!,"sentenceSAVE": text, "date": ServerValue.timestamp(),"answerSAVE": textt] as [String : Any])
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
