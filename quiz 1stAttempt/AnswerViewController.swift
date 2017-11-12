//
//  AnswerViewController.swift
//  quiz 1stAttempt
//
//  Created by 渡辺唯都 on 2017/06/11.
//  Copyright © 2017年 渡辺唯都. All rights reserved.
//

import UIKit

class AnswerViewController: UIViewController {
    
    
    
    @IBOutlet var quetionsheet: UITextView!
    @IBOutlet var answerguess: UITextField!
   
    //@IBOutlet var choisetwo: UITextField!
    //@IBOutlet var choisethree: UITextField!
    
    
    var savedata : UserDefaults = UserDefaults.standard
    
    var makequizarray2: [[String]]?
    
    @IBAction func Guessanswersave() {
        savedata.set(answerguess.text, forKey: "GuessQShow") //GUESSした答えのセーブ
        }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        makequizarray2?.append([quetionsheet.text!,answerguess.text!])
        
        savedata.set(makequizarray2, forKey: "Job2")
        
        quetionsheet.text = savedata.object(forKey: "SentenceQuiz") as? String//質問表示
        
        savedata.synchronize()
        
        //choiseone.text = savedata.object(forKey: "FirstQuiz") as? String
        //choisetwo.text = savedata.object(forKey: "SecondQuiz") as? String
        //choisethree.text = savedata.object(forKey: "ThirdQuiz") as? String
       

        // Do any additional setup after loading the view.
    }
    //Returnキーを押すと、キーボードを隠す
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
