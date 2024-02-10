//
//  SaleView.swift
//  DictionMaster
//
//  Created by Gustavo Assis on 06/02/24.
//

import SwiftUI

struct SaleView: View {
    
    var body: some View {
    
        GeometryReader{ geometry in
            VStack(spacing: 0){
                VStack{
                    ZStack(alignment: .bottom){
                        Image("banner")
                            .ignoresSafeArea()
                        
                        Image("icon")
                            .frame(width: geometry.size.width, height: geometry.size.height * 0.6)
                            .offset(y: geometry.size.height * 0.3)
                    }
                    .frame(width: geometry.size.width, height: geometry.size.height * 0.6)
                    .padding(.bottom)
                    Image("title")
                }
                .frame(width: geometry.size.width, height: geometry.size.height * 0.6)
                
                
                VStack(spacing: 10){

                    Group{
                        Text("Subscribe now to get") .foregroundColor(Color("strongBlueColor")) +
                        Text(" unlimited").foregroundColor(Color("blueButtonColor")) +
                        Text(" searches and full access to") .foregroundColor(Color("strongBlueColor")) +
                        Text(" all features").foregroundColor(Color("blueButtonColor"))
                    }
                            .frame(width: geometry.size.width * 0.85)
                            .font(.system(size: 20, weight: .bold, design: .rounded))
                            .multilineTextAlignment(.center)
                            .padding(.bottom, 5)
                    
                        Text("**Try 7 Days Free**, then only **$19,99** per year. Cancel anytime.")
                            .font(.system(size: 16, weight: .regular, design: .rounded))
                            .multilineTextAlignment(.center)
                            .foregroundColor(Color("strongBlueColor"))
                            .padding(.bottom)


                    
                        Button(action: {}
                               , label: {
                            ButtonLabelComponent(title: "Subscribe")
                        })
                    
                }
                .frame(width: geometry.size.width, height: geometry.size.height * 0.4)
            }
            
            .frame(width: geometry.size.width, height: geometry.size.height, alignment: .center)
   
            }
           
        }
        
    }


#Preview {
    SaleView()
}
