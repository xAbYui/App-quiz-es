//
//  ListViewController.swift
//  quiz 1stAttempt
//
//  Created by 渡辺唯都 on 2017/08/06.
//  Copyright © 2017年 渡辺唯都. All rights reserved.
//

import UIKit
import Firebase

class ListViewController: UIViewController, UITableViewDelegate {//, UITableViewDataSource {
    
    @IBOutlet weak var table: UITableView!
    
    var contentArray: [DataSnapshot] = [] //Fetchしたデータを入れておく配列、この配列をTableViewで表示
    
    var snap: DataSnapshot! //FetchしたSnapshotsを格納する変数
    
    let ref = Database.database().reference() //Firebaseのルートを宣言しておく
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.read()
        
        //TableViewCellをNib登録、カスタムクラスを作成
 //       table.register(UINib(nibName: "ListTableViewCell", bundle: nil), forCellReuseIdentifier: "ListCell")
        
//        table.delegate = self //デリゲートをセット
//        table.dataSource = self //デリゲートをセット

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //Cellの高さを調節
        table.estimatedRowHeight = 56
        table.rowHeight = UITableViewAutomaticDimension
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        //画面が消えたときに、Firebaseのデータ読み取りのObserverを削除しておく
        ref.removeAllObservers()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //ViewControllerへの遷移のボタン
    @IBAction func didSelectAdd() {
        self.transition()
    }
    
    //ViewControllerへの遷移
    func transition() {
        self.performSegue(withIdentifier: "toView", sender: self)
    }
    
    //セルの数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contentArray.count
    }
    
    
    
    
    
    //func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //xibとカスタムクラスで作成したCellのインスタンスを作成
    //    let cell = table.dequeueReusableCell(withIdentifier: "ListCell") as! ListTableViewCell
        
        //配列の該当のデータをitemという定数に代入
   //     let item = contentArray[indexPath.row]
        //itemの中身を辞書型に変換
   //     let sentenceSAVE = item.value as! Dictionary<String, AnyObject>
        //contentという添字で保存していた投稿内容を表示
  //      cell.contentLabel.text = String(describing: sentenceSAVE["sentenceSAVE"]!)
        //dateという添字で保存していた投稿時間をtimeという定数に代入
  //      let time = sentenceSAVE["date"] as! TimeInterval
        //getDate関数を使って、時間をtimestampから年月日に変換して表示
  //      cell.postDateLabel.text = self.getDate(number: time/1000)
        
  //      return cell
  //  }
    
    
    
    
    
    
    
    
    
    func read()  {
        //FIRDataEventTypeを.Valueにすることにより、なにかしらの変化があった時に、実行
        //今回は、childでユーザーIDを指定することで、ユーザーが投稿したデータの一つ上のchildまで指定することになる
        ref.child((Auth.auth().currentUser?.uid)!).observe(.value, with: {(snapShots) in
            if snapShots.children.allObjects is [DataSnapshot] {
                print("snapShots.children...\(snapShots.childrenCount)") //いくつのデータがあるかプリント
                
                print("snapShot...\(snapShots)") //読み込んだデータをプリント
                
                self.snap = snapShots
                
            }
            self.reload(snap: self.snap)
        })
    }
    
    //読み込んだデータは最初すべてのデータが一つにまとまっているので、それらを分割して、配列に入れる
    func reload(snap: DataSnapshot) {
        if snap.exists() {
            print(snap)
            //FIRDataSnapshotが存在するか確認
            contentArray.removeAll()
            //1つになっているFIRDataSnapshotを分割し、配列に入れる
            for item in snap.children {
                contentArray.append(item as! DataSnapshot)
            }
            // ローカルのデータベースを更新
            ref.child((Auth.auth().currentUser?.uid)!).keepSynced(true)
            //テーブルビューをリロード
            table.reloadData()
        }
    }
    func getDate(number: TimeInterval) -> String {
        let date = Date(timeIntervalSince1970: number)
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm"
        return formatter.string(from: date)
    }
    
    //変更したいデータのための変数、CellがタップされるselectedSnapに値が代入される
    var selectedSnap: DataSnapshot!
    //選択されたCellの番号を引数に取り、contentArrayからその番号の値を取り出し、selectedSnapに代入
    //その後遷移
    func didSelectRow(selectedIndexPath indexPath: IndexPath) {
        //ルートからのchildをユーザーのIDに指定
        //ユーザーIDからのchildを選択されたCellのデータのIDに指定
        self.selectedSnap = contentArray[indexPath.row]
        self.transition()
    }
    //Cellがタップされると呼ばれる
    //上記のdidSelectedRowにタップされたCellのIndexPathを渡す
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.didSelectRow(selectedIndexPath: indexPath)
    }
    //遷移するときに呼ばれる
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "toView" {
//            let view = segue.destination as! ViewController
//            if let snap = self.selectedSnap {
//                view.selectedSnap = snap
//            }
//        }
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
