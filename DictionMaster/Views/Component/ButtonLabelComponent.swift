//
//  ButtonComponent.swift
//  DictionMaster
//
//  Created by Gustavo Assis on 09/02/24.
//

import SwiftUI

struct ButtonLabelComponent: View {
    let title: String
    
    
    var body: some View {
        
            HStack{
                Text(title)
                    .textCase(.uppercase)
                    .font(.system(size: 18, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
                    
            } 
            .frame(maxWidth: .infinity, maxHeight: 64)
            .background(Color("blueButtonColor"))
            .cornerRadius(14)
            .padding(.horizontal)
        }
    }


#Preview {
    ButtonLabelComponent(title: "Subscribe")
}
