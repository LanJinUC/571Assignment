//
//  DbFireStore.swift
//  touristLocation
//
//  Created by Lan Jin on 2020-11-15.
//

import Foundation
import FirebaseFirestore
import Alamofire
import SwiftyJSON

class DbFireStore:ObservableObject{
    @Published var hotels = [Hotels]()
    @Published var sorted_hotels_by_rate = [Hotels]()
    @Published var sorted_hotels_by_price = [Hotels]()
    
    let ParisFiler = ["24-hour front desk", "24-hour security", "English", "Face maskes for guests available", "Wheelchair accessible", "Kitchen", "Cleaning products", "Dry cleaning"]
    let RomeFilter = ["24-hour front desk", "Air conditioning", "Airport pick up", "Pet bowls", "Free! WiFi is available in all areas and is free of charge.", "On-site coffe house", "Non-smoking throughout", "Luggage storage"]
    let OrlandoFilter = ["24-hour front desk", "Open all year", "Restaurant", "Free! WiFi is available in all areas and is free of charge.", "Coffee machine", "Kitchen", "Cleaning products", "Toilet"]
    let CancunFilter = ["Free! WiFi is available in all areas and is free of charge.", "Laundry", "24-hour front desk", "Free! WiFi is available in all areas and is free of charge.", "Alarm clock", "Garden", "24-hour security", "Kid's club"]
    let VancouverFilter = ["24-hour front desk", "Accessible Parking", "Free! WiFi is available in all areas and is free of charge.", "Private bathroom", "Refrigerator", "Kitchen", "Express check-in/check-out", "Karaoke"]
    
    
    
    func findMatch(indexList: [Int], city: String){
        
        hotels = [Hotels]()
        AF.request("https://touristlocation-66169.firebaseio.com/\(city).json").responseJSON{ response in
            switch response.result{
            case.success(let value):
                let json = JSON(value)
                
                
                //var hotels = [Hotels]()
                var hotelsDetail = [HotelsDetail]()
                
                for (_,subJson):(String, JSON) in json {
                    
                    let name = subJson["name"].stringValue
                    let price = subJson["price"].stringValue
                    let score = subJson["score"].string
                    let thumbnail_image = subJson["thumbnail_image"].stringValue
                    let link = "https://www.booking.com" + subJson["link"].stringValue
                    let latitude = subJson["details"]["latitude"].stringValue
                    let longitude = subJson["details"]["longitude"].stringValue
                    let eachHotelfacilities = subJson["details"]["important_facilities"].arrayValue.map {
                        $0.stringValue}
                    
                  // 2 var eachhotelServicesOffered = [HotelsServicesOffered]()
                  
                    var eachhotelServicesOffered = [""]
                    for (_,subJson):(String, JSON) in subJson["details"]["services_offered"] {
                        
                        //convert single hotelsServicesOffered into
                        let type = subJson["type"].stringValue
                        let value = subJson["value"].arrayValue.map {
                            $0.stringValue
                            
                        }
                        let eachServiceOffered = HotelsServicesOffered(type: type, value: value)
                       //3 eachhotelServicesOffered.append(eachServiceOffered)
                       
                        let services =  eachServiceOffered.value
                     
                        //print(services, terminator: "")
                        for ele in services{
                            eachhotelServicesOffered.append(ele)
                        }
                        
                    }
                    
                   // print(eachhotelServicesOffered)
                    
                   
                    
                 //4   let eachHotelDetails = HotelsDetail(importantFacilities: eachHotelfacilities, latitude: latitude, longitude: longitude, neighborhoodStructures: [], servicesOffered: eachhotelServicesOffered)
                    let eachHotelDetails = HotelsDetail(importantFacilities: eachHotelfacilities, latitude: latitude, longitude: longitude, neighborhoodStructures: [], servicesOffered: eachhotelServicesOffered)
                    hotelsDetail.append(eachHotelDetails)
                    
                    let eachHotel = Hotels(details: eachHotelDetails, link: link, name: name, price: price, score: score ?? "1.0", thumbnailImage: thumbnail_image)
                    
                    self.hotels.append(eachHotel)
                }
                
                
                
                
                
//                //let listSet = Set(hotels[0].details.importantFacilities)
//                let findList = Set(["Free WiFi","24-hour front desk"])
//                for hotel in self.hotels{
//
//                    let listSet = Set(hotel.details.importantFacilities)
//                    let allElemsContained = findList.isSubset(of: listSet)
//
//                    if(allElemsContained){
//                       // print(hotel.name)
//                    }
//
//                }
                
                
                
                //let allElemsContained = findList.isSubset(of: listSet)
                
               // print(allElemsContained)
                
                var scoreList = [Float]()
                var nameList = [String]()
                var priceList = [String]()
                
                for hotel in self.hotels{
                    let score = Float(hotel.score) ?? 0.0
                    let name = hotel.name
                    let price = hotel.price
                    
                    
                    scoreList.append(score)
                    nameList.append(name)
                    priceList.append(price)
                }
                
                let dictionary = Dictionary(uniqueKeysWithValues: zip(nameList, self.hotels))
                let scoreDictionary = Dictionary(uniqueKeysWithValues: zip(nameList, scoreList))
                let priceDictionary = Dictionary(uniqueKeysWithValues: zip(nameList, priceList))
                
                
                let sortedScoreDictionary = scoreDictionary.sorted( by: { $0.1 > $1.1 })
                let sortedPriceDictionary = priceDictionary.sorted(by: { $0.1 < $1.1 })
                
                for (k,_) in sortedScoreDictionary{
                    self.sorted_hotels_by_rate.append(dictionary[k]!)
                    
                }
                
                for (k,v) in sortedPriceDictionary{
                    self.sorted_hotels_by_price.append(dictionary[k]!)
          
                }
                
                var filter : [String]
                switch city{
                case "Paris":
                    filter = self.ParisFiler
                case "Rome":
                    filter = self.RomeFilter
                case "Orlando":
                    filter = self.OrlandoFilter
                case "Cancun":
                    filter = self.CancunFilter
                case "Vancouver":
                    filter = self.VancouverFilter
                default:
                    filter = self.ParisFiler
                }
                var filtedList = [""]
                for i in 0...7{
                    if indexList[i] == 1{
                        filtedList.append(filter[i])
                    }
                }
                filtedList.remove(at: 0)
                
                
                
                
                let findList = Set(filtedList)
                var newHotel = [Hotels]()
                for hotel in self.hotels{

                    let listSet = Set(hotel.details.servicesOffered)
                    let allElemsContained = findList.isSubset(of: listSet)
                    
                    if(allElemsContained){
                        //print(hotel)
                        newHotel.append(hotel)
                    }

                }
                
                self.hotels = newHotel
               // print(self.hotels)
            
            case.failure(let error):
                print(error)
            }
        }

        
       
        
        
        
    }
    
    func fetchDB(city: String){
        
        hotels = [Hotels]()
        AF.request("https://touristlocation-66169.firebaseio.com/\(city).json").responseJSON{ response in
            switch response.result{
            case.success(let value):
                let json = JSON(value)
                
                
                //var hotels = [Hotels]()
                var hotelsDetail = [HotelsDetail]()
                
                for (_,subJson):(String, JSON) in json {
                    
                    let name = subJson["name"].stringValue
                    let price = subJson["price"].stringValue
                    let score = subJson["score"].string
                    let thumbnail_image = subJson["thumbnail_image"].stringValue
                    let link = "https://www.booking.com" + subJson["link"].stringValue
                    let latitude = subJson["details"]["latitude"].stringValue
                    let longitude = subJson["details"]["longitude"].stringValue
                    let eachHotelfacilities = subJson["details"]["important_facilities"].arrayValue.map {
                        $0.stringValue}
                    
                  // 2 var eachhotelServicesOffered = [HotelsServicesOffered]()
                  
                    var eachhotelServicesOffered = [""]
                    for (_,subJson):(String, JSON) in subJson["details"]["services_offered"] {
                        
                        //convert single hotelsServicesOffered into
                        let type = subJson["type"].stringValue
                        let value = subJson["value"].arrayValue.map {
                            $0.stringValue
                            
                        }
                        let eachServiceOffered = HotelsServicesOffered(type: type, value: value)
                       //3 eachhotelServicesOffered.append(eachServiceOffered)
                       
                        let services =  eachServiceOffered.value
                     
                        //print(services, terminator: "")
                        for ele in services{
                            eachhotelServicesOffered.append(ele)
                        }
                        
                    }
                    
                   // print(eachhotelServicesOffered)
                    
                   
                    
                 //4   let eachHotelDetails = HotelsDetail(importantFacilities: eachHotelfacilities, latitude: latitude, longitude: longitude, neighborhoodStructures: [], servicesOffered: eachhotelServicesOffered)
                    let eachHotelDetails = HotelsDetail(importantFacilities: eachHotelfacilities, latitude: latitude, longitude: longitude, neighborhoodStructures: [], servicesOffered: eachhotelServicesOffered)
                    hotelsDetail.append(eachHotelDetails)
                    
                    let eachHotel = Hotels(details: eachHotelDetails, link: link, name: name, price: price, score: score ?? "1.0", thumbnailImage: thumbnail_image)
                    
                    self.hotels.append(eachHotel)
                }
                
                
                
                
                
//                //let listSet = Set(hotels[0].details.importantFacilities)
//                let findList = Set(["Free WiFi","24-hour front desk"])
//                for hotel in self.hotels{
//
//                    let listSet = Set(hotel.details.importantFacilities)
//                    let allElemsContained = findList.isSubset(of: listSet)
//
//                    if(allElemsContained){
//                       // print(hotel.name)
//                    }
//
//                }
                
                
                
                //let allElemsContained = findList.isSubset(of: listSet)
                
               // print(allElemsContained)
                
                var scoreList = [Float]()
                var nameList = [String]()
                var priceList = [String]()
                
                for hotel in self.hotels{
                    let score = Float(hotel.score) ?? 0.0
                    let name = hotel.name
                    let price = hotel.price
                    
                    
                    scoreList.append(score)
                    nameList.append(name)
                    priceList.append(price)
                }
                
                let dictionary = Dictionary(uniqueKeysWithValues: zip(nameList, self.hotels))
                let scoreDictionary = Dictionary(uniqueKeysWithValues: zip(nameList, scoreList))
                let priceDictionary = Dictionary(uniqueKeysWithValues: zip(nameList, priceList))
                
                
                let sortedScoreDictionary = scoreDictionary.sorted( by: { $0.1 > $1.1 })
                let sortedPriceDictionary = priceDictionary.sorted(by: { $0.1 < $1.1 })
                
                for (k,_) in sortedScoreDictionary{
                    self.sorted_hotels_by_rate.append(dictionary[k]!)
                    
                }
                
                for (k,v) in sortedPriceDictionary{
                    self.sorted_hotels_by_price.append(dictionary[k]!)
          
                }
            
            case.failure(let error):
                print(error)
            }
        }
    }
    
//    func orderByRates(city: String){
//        //fetchDB(city: "London")
//        var dictionary_score : [Int: Hotels] = [:]
//        //var dictionary_price : [String: Int] = [:]
//        //var dictionary : [String: Hotels] = [:]
//
//        for hotel in hotels{
//            dictionary_score[Int(hotel.score)!] = hotel
//            let score = hotel.score
//            print(score)
//        }
//        print(hotels)
//
//        let sorted_dictionary = dictionary_score.sorted(by: { $0.0 < $1.0 })
//        print(sorted_dictionary)
//        print("hey")
//
//        for (key, hotel) in sorted_dictionary{
//            //ordered_hotels.append(hotel)
//            print(hotel)
//        }
//
//    }
//

}
