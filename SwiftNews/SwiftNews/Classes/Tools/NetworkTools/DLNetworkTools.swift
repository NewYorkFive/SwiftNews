//
//  DLNetworkTools.swift
//  Swift网络请求封装
//
//  Created by NowOrNever on 27/03/2017.
//  Copyright © 2017 Focus. All rights reserved.
//

import UIKit
import AFNetworking

//enum RequestType: Int{

enum RequestType {
    //枚举名需要小写
    case get
    case post
}

class DLNetworkTools: AFHTTPSessionManager {
    static let sharedTools: DLNetworkTools = {
//        let tools = DLNetworkTools.init(baseURL: "http://c.m.163.com/nc/article/list/", sessionConfiguration: <#T##URLSessionConfiguration?#>)
        let tools = DLNetworkTools(baseURL: URL.init(string: "http://c.m.163.com/nc/article/list/"))
        tools.responseSerializer.acceptableContentTypes?.insert("text/html")
        tools.responseSerializer.acceptableContentTypes?.insert("text/plain")
        return tools
    }()
    
    func request(type:RequestType,urlString:String,params:Any?,finishCallBack:@escaping (Any?,Error?)->()){
        if type == .post {
            post(urlString, parameters: params, progress: nil, success: { (_, response) -> () in
                finishCallBack(response,nil);
            }, failure: { (_, error) in
                finishCallBack(nil, error);
            })
        }else{
            get(urlString, parameters: params, progress: nil, success: { (_, response) in
                finishCallBack(response,nil);
            }, failure: { (_, error) in
                finishCallBack(nil, error);
            })
        }
    }
    
}


extension DLNetworkTools{
}


