//
//  CategoryTitle.swift
//  Bush Digital Production Rental
//
//  Created by Naveed ur Rehman on 29/08/2019.
//  Copyright © 2019 Naveed ur Rehman. All rights reserved.
//

import UIKit

class CategoryTitle: NSObject, NSCoding{
    
    
    var categoriesTitles : [String]!
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        categoriesTitles = dictionary["categories_titles"] as? [String]
    }
    
    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if categoriesTitles != nil{
            dictionary["categories_titles"] = categoriesTitles
        }
        return dictionary
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        categoriesTitles = aDecoder.decodeObject(forKey: "categories_titles") as? [String]
        
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if categoriesTitles != nil{
            aCoder.encode(categoriesTitles, forKey: "categories_titles")
        }
        
    }
    
}
