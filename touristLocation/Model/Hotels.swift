//  touristLocation
//
//  Created by Lan Jin on 2020-11-15.
//

import Foundation

//MARK: - Hotels
public struct Hotels: Identifiable {
        public var id: String {
            return name
        }
        public var details : HotelsDetail
        public var link : String
        public var name : String
        public var price : String
        public var score : String
        public var thumbnailImage : String
        
}
