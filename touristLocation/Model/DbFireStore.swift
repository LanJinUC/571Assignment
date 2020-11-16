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
                    let score = subJson["score"].stringValue
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
                    
                    let eachHotel = Hotels(details: eachHotelDetails, link: link, name: name, price: price, score: score, thumbnailImage: thumbnail_image)
                    
                    self.hotels.append(eachHotel)
                }
                
                
                
                //let listSet = Set(hotels[0].details.importantFacilities)
                let findList = Set(["Free WiFi","24-hour front desk"])
                for hotel in self.hotels{
                    
                    let listSet = Set(hotel.details.importantFacilities)
                    let allElemsContained = findList.isSubset(of: listSet)
                    
                    if(allElemsContained){
                        print(hotel.name)
                    }
                    
                }
                
                //let allElemsContained = findList.isSubset(of: listSet)
                
               // print(allElemsContained)
            
            case.failure(let error):
                print(error)
            }
        }
    }
    
    
    

}
