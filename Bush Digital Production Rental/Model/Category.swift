//
//  Category.swift
//  Bush Digital Production Rental
//
//  Created by Naveed ur Rehman on 29/08/2019.
//  Copyright © 2019 Naveed ur Rehman. All rights reserved.
//

import UIKit

class CategoryRoot: NSObject, NSCoding{
    
    var categories : [Category]!
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        categories = [Category]()
        if let categoriesArray = dictionary["categories"] as? [[String:Any]]{
            for dic in categoriesArray{
                let value = Category(fromDictionary: dic)
                categories.append(value)
            }
        }
    }
    
    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if categories != nil{
            var dictionaryElements = [[String:Any]]()
            for categoriesElement in categories {
                dictionaryElements.append(categoriesElement.toDictionary())
            }
            dictionary["categories"] = dictionaryElements
        }
        return dictionary
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        categories = aDecoder.decodeObject(forKey :"categories") as? [Category]
        
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if categories != nil{
            aCoder.encode(categories, forKey: "categories")
        }
        
    }
    
}

class Category: NSObject, NSCoding{
    
    var category : String!
    var descriptionField : String!
    var id : String!
    var image : String!
    var pOne : String!
    var pThree : String!
    var pTwo : String!
    var title : String!
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        category = dictionary["category"] as? String
        descriptionField = dictionary["description"] as? String
        id = dictionary["id"] as? String
        image = dictionary["image"] as? String
        pOne = dictionary["p_one"] as? String
        pThree = dictionary["p_three"] as? String
        pTwo = dictionary["p_two"] as? String
        title = dictionary["title"] as? String
    }
    
    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if category != nil{
            dictionary["category"] = category
        }
        if descriptionField != nil{
            dictionary["description"] = descriptionField
        }
        if id != nil{
            dictionary["id"] = id
        }
        if image != nil{
            dictionary["image"] = image
        }
        if pOne != nil{
            dictionary["p_one"] = pOne
        }
        if pThree != nil{
            dictionary["p_three"] = pThree
        }
        if pTwo != nil{
            dictionary["p_two"] = pTwo
        }
        if title != nil{
            dictionary["title"] = title
        }
        return dictionary
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        category = aDecoder.decodeObject(forKey: "category") as? String
        descriptionField = aDecoder.decodeObject(forKey: "description") as? String
        id = aDecoder.decodeObject(forKey: "id") as? String
        image = aDecoder.decodeObject(forKey: "image") as? String
        pOne = aDecoder.decodeObject(forKey: "p_one") as? String
        pThree = aDecoder.decodeObject(forKey: "p_three") as? String
        pTwo = aDecoder.decodeObject(forKey: "p_two") as? String
        title = aDecoder.decodeObject(forKey: "title") as? String
        
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if category != nil{
            aCoder.encode(category, forKey: "category")
        }
        if descriptionField != nil{
            aCoder.encode(descriptionField, forKey: "description")
        }
        if id != nil{
            aCoder.encode(id, forKey: "id")
        }
        if image != nil{
            aCoder.encode(image, forKey: "image")
        }
        if pOne != nil{
            aCoder.encode(pOne, forKey: "p_one")
        }
        if pThree != nil{
            aCoder.encode(pThree, forKey: "p_three")
        }
        if pTwo != nil{
            aCoder.encode(pTwo, forKey: "p_two")
        }
        if title != nil{
            aCoder.encode(title, forKey: "title")
        }
        
    }
    
}
