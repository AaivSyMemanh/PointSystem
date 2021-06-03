//
//  Login.swift
//  PointSystem
//
//  Created by dongruixuan on 2017/10/4.
//  Copyright © 2017年 dongruixuan. All rights reserved.
//

import Foundation

class GetDataFromServer {
    let loginurl = URL(string: "https://pointsystem.starcatmeow.top/login.php")
    let pointslogurl = URL(string: "https://pointsystem.starcatmeow.top/xx_point_list.php")
    func LoginWithUsernameandPassword(Username:String!,Password:String!) -> String {
        var request = URLRequest(url:loginurl!)
        let postData = "username=\(Username!)&password=\(Password!)".data(using: String.Encoding.utf8)
        request.timeoutInterval = 30
        var response:URLResponse?
        do{
            try NSURLConnection.sendSynchronousRequest(request, returning: &response)
            request.httpMethod = "POST"
            request.httpBody = postData
            let received:Data? = try NSURLConnection.sendSynchronousRequest(request, returning: &response)
            let datastring = String(data:received!, encoding: String.Encoding.utf8)!
            return datastring
        }catch let error as NSError{
            print(error.code)
            print(error.description)
            return "NetworkError"
        }
    }
    func getpointsLog(id:Int16!,password:String!)->pointlogsresult{
        var result = pointlogsresult(status: 0, info: "", data: Array<pointlog>())
        var request = URLRequest(url:pointslogurl!)
        let postData = "id=\(String(id))&password=\(password!)".data(using: String.Encoding.utf8)
        request.timeoutInterval = 30
        var response:URLResponse?
        var dataString = ""
        do{
            try NSURLConnection.sendSynchronousRequest(request, returning: &response)
            request.httpMethod = "POST"
            request.httpBody = postData
            let received:Data? = try NSURLConnection.sendSynchronousRequest(request, returning: &response)
            dataString = String(data:received!, encoding: String.Encoding.utf8)!
        }catch let error as NSError{
            print(error.code)
            print(error.description)
            result.status = 0
            result.info = "NetworkError"
            return result
        }
        do{
            let decoder = JSONDecoder()
            result = try! decoder.decode(pointlogsresult.self, from: dataString.data(using: String.Encoding.utf8)!)
            return result
        }catch let error as NSError{
            print(error.code)
            print(error.description)
            result.status = 0
            result.info = "UnpackageError"
            return result
        }
    }
}
