//
//  Login.swift
//  PointSystem
//
//  Created by dongruixuan on 2017/10/4.
//  Copyright © 2017年 dongruixuan. All rights reserved.
//

import Foundation

class GetDataFromServer {
func LoginWithUsernameandPassword(Username:String!,Password:String!) -> String {
    print(Username)
    print(Password)
    let url = URL(string: "https://pointsystem.starcatmeow.top/login.php")
    var request = URLRequest(url:url!)
    let postData = "username=\(Username!)&password=\(Password!)".data(using: String.Encoding.utf8)
    
    
    request.timeoutInterval = 30
    
    var response:URLResponse?
    
    do{
        try NSURLConnection.sendSynchronousRequest(request, returning: &response)
        request.httpMethod = "POST"
        request.httpBody = postData
        let received:Data? = try NSURLConnection.sendSynchronousRequest(request, returning: &response)
        let datastring = String(data:received!, encoding: String.Encoding.utf8)!
        print(datastring)
        return datastring
    }catch let error as NSError{
        print(error.code)
        print(error.description)
        return "NetworkError"
    }
}
    func getpointsLog(id:String!,password:String!)->Array<pointlog>{
        var pointlogs:Array = [pointlog]()
        return pointlogs
    }
}
