//
//  GroupFinderViewController.swift
//  quiz 1stAttempt
//
//  Created by 渡辺唯都 on 2017/08/05.
//  Copyright © 2017年 渡辺唯都. All rights reserved.
//

import UIKit

class GroupFinderViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet var table: UITableView!
    
    let imageForGroup = ["english.jpeg", "kanji.png", "sekai.jpeg", "mame.jpeg"]
    
    let groupSubejects = ["英単語", "漢字", "世界史", "豆知識"]
    
    let imageSentence = ["英単語とは", "漢字とは", "世界史とは", "豆知識とは"]
    
    var GroupNameArray = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        table.dataSource = self
        
        table.delegate = self
        
        //GroupNameArray = ["英単語", "漢字", "世界史", "豆知識"]
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return imageSentence.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! Customcell1TableViewCell
        
        // セルに値を設定
        cell.ImageView.image = UIImage(named: imageForGroup[indexPath.row])
        cell.TitleLabel.text = groupSubejects[indexPath.row]
        cell.DescriptionLabel.text = imageForGroup[indexPath.row]
        
        // いらなくなったかもcell?.textLabel?.text = GroupNameArray [indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\(GroupNameArray[indexPath.row])が選ばれました")
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
