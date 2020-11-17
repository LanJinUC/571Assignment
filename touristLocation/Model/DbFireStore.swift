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
    
    func fetchDB(city: String){
        

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
                    
                    var eachhotelServicesOffered = [HotelsServicesOffered]()
                    for (_,subJson):(String, JSON) in subJson["details"]["services_offered"] {
                        
                        //convert single hotelsServicesOffered into
                        let type = subJson["type"].stringValue
                        let value = subJson["value"].arrayValue.map {
                            $0.stringValue}
                        let eachServiceOffered = HotelsServicesOffered(type: type, value: value)
                        eachhotelServicesOffered.append(eachServiceOffered)
                        
                    }
                    
                    let eachHotelDetails = HotelsDetail(importantFacilities: eachHotelfacilities, latitude: latitude, longitude: longitude, neighborhoodStructures: [], servicesOffered: eachhotelServicesOffered)
                    
                    hotelsDetail.append(eachHotelDetails)
                    
                    let eachHotel = Hotels(details: eachHotelDetails, link: link, name: name, price: price, score: score ?? "1.0", thumbnailImage: thumbnail_image)
                    
                    self.hotels.append(eachHotel)
                }
                
                
                
                //let listSet = Set(hotels[0].details.importantFacilities)
                let findList = Set(["Free WiFi","24-hour front desk"])
                for hotel in self.hotels{
                    
                    let listSet = Set(hotel.details.importantFacilities)
                    let allElemsContained = findList.isSubset(of: listSet)
                    
                    if(allElemsContained){
                       // print(hotel.name)
                    }
                    
                }
                
                
                
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
                
                
                //print(self.sorted_hotels)
                
                
                
            
            
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
