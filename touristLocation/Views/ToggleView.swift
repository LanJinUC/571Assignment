//
//  ToggleView.swift
//  touristLocation
//
//  Created by Lan Jin on 2020-11-23.
//

import SwiftUI

struct ToggleView: View {
    @State var isChecked: Bool = false
    @State var index: Int = 0
    @Binding var city: String
    
    
    
    
    let ParisFiler = ["Free! WiFi is available in all areas and is free of charge."]
    let RomeFilter = ["Bidet", "Refrigerator", "Toilet paper", "Free! WiFi is available in all areas and is free of charge.", "Coffee machine", "Kitchen", "Cleaning products", "Toilet"]
    let OrlandoFilter = ["Free! WiFi is available in all areas and is free of charge."]
    let CancunFilter = ["Free! WiFi is available in all areas and is free of charge."]
    let VancouverFilter = ["Free! WiFi is available in all areas and is free of charge."]
    let checkedIndexList = [0,0,0,0,0,0,0,0,0]
    
    var body: some View {
        Toggle(isOn: self.$isChecked, label: {
            
            switch city{
            case "Paris":
                Text("  \(ParisFiler[index])")
            case "Rome":
                Text("  \(RomeFilter[index])")
            case "Orlando":
                Text("  \(OrlandoFilter[index])")
            case "Cancun":
                Text("  \(CancunFilter[index])")
            case "Vancouver":
                Text("  \(VancouverFilter[index])")
            default:
                Text("  \(ParisFiler[index])")
            }
            
            
            if(self.isChecked){
                Text("\(self.toggleAction(state: "Checked", index: index))")
            }else{
                Text("\(self.toggleAction(state: "Unchecked", index: index))")
            }
            
        })
    }
    
    func toggleAction(state: String, index: Int) -> String{
        print("The switch number is: \(index), state is:  \(state)")
        return ""
    }
    
}


