//
//  ViewController.swift
//  ELProgressHUD-swift
//
//  Created by 李涌辉 on 16/9/18.
//  Copyright © 2016年 Evil Lee. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    let cellID : String = "cellId"
    lazy var tableView : UITableView = {
      let tableView = UITableView.init(frame: self.view.bounds, style: .grouped)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 44
        return tableView
    }()
    let dataSource : [String] = ["ELProgressHudTypeIndicator", "ELProgressHudTypeText", "ELProgressHudTypeProgress", "ELProgressHudTypeProgressWithCancel", "ELProgressHudTypeIndicatorAndText", "ELProgressHudTypeProgressAndText", "ELProgressHudTypeGif", "ELProgressHudTypeDrawCircle"]
    
    static var float: CGFloat = 0.0
    
    // MARK: life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationItem.title = "ELProgressHud"
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(self.tableView)
        
    }

    // MARK: 隐藏hud
    @objc private func hide() {
        ELProgressHud.hideHudAtView(aView: self.view)
    }
    
    // MARK: tableView dataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: cellID)
        if cell == nil {
            cell = UITableViewCell.init(style: UITableViewCellStyle.default, reuseIdentifier: cellID)
        }
        cell?.backgroundColor = UIColor.lightGray
        cell?.textLabel?.text = self.dataSource[indexPath.section]
        return cell!
    }
    
    // MARK: tableView delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.section {
        case ELProgressHud.ELProgressHudType.ELProgressHudTypeIndicator.hashValue:
            ELProgressHud.showHudAtView(aView: self.view)
            self.perform(#selector(hide), with: nil, afterDelay: 1.5)
            break
        case ELProgressHud.ELProgressHudType.ELProgressHudTypeText.hashValue:
            let hud : ELProgressHud = ELProgressHud.init(hudType: .ELProgressHudTypeText)
            hud.textLabel.text = "单纯的文本框~"
            hud.delay = 1.5
            hud.showHudAtView(aView: self.view)
          break
        case ELProgressHud.ELProgressHudType.ELProgressHudTypeProgress.hashValue:
            let hud: ELProgressHud = ELProgressHud.init(hudType: .ELProgressHudTypeProgress)
            hud.el_progress = 0.3
            hud.delay = 2.0
            hud.showHudAtView(aView: self.view)
            break
        case ELProgressHud.ELProgressHudType.ELProgressHudTypeProgressWithCancel.hashValue:
            let hud: ELProgressHud = ELProgressHud.init(hudType: .ELProgressHudTypeProgressWithCancel)
            hud.el_progress = 0.6
            hud.delay = 2.0
            hud.elCompletion = { ()->Void in
               NSLog("草拟吗的swift 真麻烦╮(╯▽╰)╭")
            }
            hud.showHudAtView(aView: self.view)
            break
        case ELProgressHud.ELProgressHudType.ELProgressHudTypeIndicatorAndText.hashValue:
            let hud : ELProgressHud = ELProgressHud.init(hudType: .ELProgressHudTypeIndicatorAndText)
            hud.textLabel.text = "哈萨克之火葬魔咒"
            hud.delay = 2.0
            hud.showHudAtView(aView: self.view)
            break
        case ELProgressHud.ELProgressHudType.ELProgressHudTypeProgressAndText.hashValue:
            let hud: ELProgressHud = ELProgressHud.init(hudType: .ELProgressHudTypeProgressAndText)
            hud.textLabel.text = "我打你哦~"
            hud.el_progress = 0.4
            hud.delay = 2.0
            hud.showHudAtView(aView: self.view)
            break
        case ELProgressHud.ELProgressHudType.ELProgressHudTypeGif.hashValue:
            let hud: ELProgressHud = ELProgressHud.init(hudType: .ELProgressHudTypeGif)
            hud.el_images = ["11.png", "12.png", "13.png", "14.png"]
            hud.delay = 2.0
            hud.showHudAtView(aView: self.view)
            break
        case ELProgressHud.ELProgressHudType.ELProgressHudTypeDrawCircle.hashValue:
            let hud: ELProgressHud = ELProgressHud.init(hudType: .ELProgressHudTypeDrawCircle)
            hud.el_strokeStart = 0.3
            hud.delay = 2.0
            hud.showHudAtView(aView: self.view)
            break
        default:
          break
        }
    }
    
    // MARK:
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


