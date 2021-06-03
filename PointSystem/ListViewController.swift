//
//  ListViewController.swift
//  PointSystem
//
//  Created by jpg on 2017/10/10.
//  Copyright © 2017年 dongruixuan. All rights reserved.
//

import UIKit
import Foundation
class ListViewController:UIViewController,UITableViewDelegate,UITableViewDataSource{
    var account:Account?
    var pointlogsresult:pointlogsresult?
    @IBOutlet weak var welcomeText: UILabel!
    @IBOutlet weak var pointText: UILabel!
    @IBOutlet weak var weekpointText: UILabel!
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        welcomeText.text = "欢迎，"+account!.chinesename
        pointText.text = "你的操行分："+account!.points
        tableView.dataSource = self
        tableView.delegate = self
        var queue = DispatchQueue(label: "top.starcatmeow.pointsystem.getpointlogs")
        queue.async {
            self.pointlogsresult = GetDataFromServer().getpointsLog(id: Int16(self.account!.id)!, password: self.account!.password)
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pointlogsresult!.data.count;
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        cell.textLabel?.text = pointlogsresult?.data[indexPath.row]?.cause
        cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
        var dateformatter = DateFormatter()
        dateformatter.dateFormat = "yyyy年mm月dd日 HH:mm"
     //   cell.detailTextLabel?.text = dateformatter.string(from: Date(timeIntervalSince1970: TimeInterval(Int(pointlogsresult!.data[indexPath.row]!.time)!)))
        cell.detailTextLabel?.text = pointlogsresult?.data[indexPath.row]?.pointchange
        return cell
    }
}
