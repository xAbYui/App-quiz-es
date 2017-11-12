//
//  ResultViewController.swift
//  quiz 1stAttempt
//
//  Created by 渡辺唯都 on 2017/06/11.
//  Copyright © 2017年 渡辺唯都. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {
    
    @IBOutlet var choiseone: UITextField! // 作成した問題の答えを表示する場所の指定
    @IBOutlet var GuessShownow: UITextView! //作成したGUESS答えの表示場所指定
    
    var savedata : UserDefaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        
        choiseone.text = savedata.object(forKey: "FirstQuiz") as? String //作成した問題の答えの表示
        
        GuessShownow.text = savedata.object(forKey: "GuessQShow") as? String ?? "空"
        //作成したGUESS答えの表示

        // Do any additional setup after loading the view.
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
