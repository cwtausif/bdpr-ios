
//  WebService.swift
//  BrandsPK

//  Created by musharraf on 12/1/16.
//  Copyright © 2016 Stars Developer. All rights reserved.


import UIKit
import AFNetworking


//typealias SuccessBlock = (_ response: AnyObject) -> Void
//typealias FailureBlock = (_ response: AnyObject) -> Void

class AFNWebService: NSObject {

    
    static let sharedInstance = AFNWebService()

//    private override init() {
//
//    }
   
    private func urlString(subUrl: String) -> String {
        
         return "http://bdproductionrental.com/\(subUrl)"
        
       
    }

    func doGetData(parameters: Dictionary<String, AnyObject>, method: String, success:@escaping SuccessBlock, fail: @escaping FailureBlock) {

        self.getMethodWithParams(parameters: parameters, forMethod: self.urlString(subUrl: method), success: success, fail: fail)
    }

    func doPostData(parameters: Dictionary<String, AnyObject>, method: String, success:@escaping SuccessBlock, fail: @escaping FailureBlock) {

        self.postMethodWithParams(parameters: parameters, forMethod: self.urlString(subUrl: method), success: success, fail: fail)
    }
    
    func doPostDataWithImage(parameters: Dictionary<String, AnyObject>, method: String, image: UIImage?, success:@escaping SuccessBlock, fail: @escaping FailureBlock) {

        self.postMethodWithParamsAndImage(parameters: parameters, forMethod: self.urlString(subUrl: method), image: image, success: success, fail: fail)
    }
    
    private func postMethodWithParamsAndImage(parameters: Dictionary <String, AnyObject>, forMethod: String, image: UIImage?, success:@escaping SuccessBlock, fail:@escaping FailureBlock){

        let manager = AFHTTPSessionManager()
        manager.requestSerializer = AFJSONRequestSerializer()
        manager.responseSerializer = AFJSONResponseSerializer()

//        manager.requestSerializer.setValue("application/json", forHTTPHeaderField: "Accept")
//
//        manager.requestSerializer.setValue(AppDelegate.shared().accessToken, forHTTPHeaderField: "accessToken")
//        manager.requestSerializer.setValue("b63cocgu8m73wtskd3lvv5m9esn3b4ju", forHTTPHeaderField: "oauth_consumer_secret")
//        
//        
//        if Utilities.isLoggedIn(){
//            manager.requestSerializer.setValue(UserDefaults.standard.value(forKey: "oauth_token") as? String, forHTTPHeaderField: "oauth_token")
//            manager.requestSerializer.setValue(UserDefaults.standard.value(forKey: "oauth_secret") as? String, forHTTPHeaderField: "oauth_secret")
//        }


//        let imageData = UIImageJPEGRepresentation(image!, 0.5)
        manager.post(forMethod, parameters: parameters, success: { (task, formData) in
            
        if image != nil
        {
            var imgData = (image?.jpeg(.lowest))!
            
            print(imgData.count)
            
//            (formData as AnyObject).appendPart(withFileData:imgData, name: "image", fileName: "image.png", mimeType: "image/jpeg")
//            (formData as AnyObject).appendPart(withFileData: imageData!, name: "photo", fileName: "photo.jpg",mimeType: "image/jpeg")
            
            (formData as AnyObject).appendPart(withForm: "image".data(using: String.Encoding.utf8, allowLossyConversion: true)!, name: "image.jpg")
        }
            success(formData as AnyObject)
            
        }) { (task, error) in
            fail(error as AnyObject)
        }
    }
    
    private func postMethodWithParams(parameters: Dictionary <String, AnyObject>, forMethod: String, success:@escaping SuccessBlock, fail:@escaping FailureBlock){
//
        let manager = AFHTTPSessionManager()
        manager.requestSerializer = AFJSONRequestSerializer()
        manager.responseSerializer = AFJSONResponseSerializer()

//        manager.requestSerializer.setValue("application/json", forHTTPHeaderField: "Accept")
//        
//        manager.requestSerializer.setValue(AppDelegate.shared().accessToken, forHTTPHeaderField: "accessToken")
//        manager.requestSerializer.setValue("b63cocgu8m73wtskd3lvv5m9esn3b4ju", forHTTPHeaderField: "oauth_consumer_secret")
//        
//        
//        if Utilities.isLoggedIn(){
//            manager.requestSerializer.setValue(UserDefaults.standard.value(forKey: "oauth_token") as? String, forHTTPHeaderField: "oauth_token")
//            manager.requestSerializer.setValue(UserDefaults.standard.value(forKey: "oauth_secret") as? String, forHTTPHeaderField: "oauth_secret")
//        }

       
        manager.post(forMethod, parameters: parameters, success: { (task, formData) in
            
            success(formData as AnyObject)
        }) { (task, error) in
            fail(error as AnyObject)
        }
        
    }

    private func getMethodWithParams(parameters: Dictionary<String, AnyObject>, forMethod: String, success:@escaping SuccessBlock, fail:@escaping FailureBlock){

        let manager = AFHTTPSessionManager()
        manager.requestSerializer = AFJSONRequestSerializer()
        manager.responseSerializer = AFJSONResponseSerializer()

//        manager.requestSerializer.setValue("application/json", forHTTPHeaderField: "Accept")
//        manager.requestSerializer.setValue(AppDelegate.shared().accessToken, forHTTPHeaderField: "accessToken")
//        manager.requestSerializer.setValue("b63cocgu8m73wtskd3lvv5m9esn3b4ju", forHTTPHeaderField: "oauth_consumer_secret")
        
        
//        if Utilities.isLoggedIn(){
//            manager.requestSerializer.setValue(UserDefaults.standard.value(forKey: "oauth_token") as? String, forHTTPHeaderField: "oauth_token")
//            manager.requestSerializer.setValue(UserDefaults.standard.value(forKey: "oauth_secret") as? String, forHTTPHeaderField: "oauth_secret")
//        }

        manager.get(forMethod, parameters: parameters, success: { (task, formData) in
            success(formData as AnyObject)
        }) { (task, error) in
            fail(error as AnyObject)
        }
 
    }
    func doPostDataWithMedia(parameters: Dictionary<String, AnyObject>, method: String, media: URL?,name: String, success:@escaping SuccessBlock, fail: @escaping FailureBlock) {
        
        self.postMethodWithParamsAndMedia(parameters: parameters, forMethod: self.urlString(subUrl: method), media: media, name: name, success: success, fail: fail)
    }
    
    
    private func postMethodWithParamsAndMedia(parameters: Dictionary <String, AnyObject>, forMethod: String, media: URL?, name: String, success:@escaping SuccessBlock, fail:@escaping FailureBlock){
        
        let manager = AFHTTPSessionManager()
        manager.requestSerializer = AFJSONRequestSerializer()
        manager.responseSerializer = AFJSONResponseSerializer()
        
        manager.requestSerializer.setValue("application/json", forHTTPHeaderField: "Accept")
        
        print(media)
        manager.post(forMethod, parameters: parameters, constructingBodyWith: { (formData) in
            if media != nil {
                do {
                    try formData.appendPart(withFileURL: media!, name: name)
                } catch {
                    
                }
            }
        }, success: { (task, data) in
            success(data as AnyObject)
        }) { (task, err) in
            fail(err as AnyObject)
        }
    }

}
