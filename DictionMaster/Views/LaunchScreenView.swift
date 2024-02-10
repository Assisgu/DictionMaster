//
//  LaunchScreenView.swift
//  DictionMaster
//
//  Created by Gustavo Assis on 09/02/24.
//

import SwiftUI

struct LaunchScreenView: View {
    @State private var isActive = false
    @State private var size = 0.8
    @State private var opacity = 0.5
    
    var body: some View {
        if isActive {
            ContentView()
                .preferredColorScheme(.light) 
        } else {
            
            VStack {
                GeometryReader{ geometry in
                    VStack{
                        VStack(spacing: -20){
                            Image("icon")
                            Image("title")
                        }.frame(height: geometry.size.height * 0.6, alignment: .bottom)
                            .scaleEffect(size)
                            .opacity(opacity)
                            .onAppear{
                                withAnimation(.easeIn(duration: 1.2)) {
                                    self.size = 0.9
                                    self.opacity = 1.0
                                }
                            }
                        
                        VStack{
                            Text("By Gustavo Assis")
                                .font(.system(size: 22, weight: .regular, design: .rounded))
                                .foregroundColor(Color("strongBlueColor"))
                        }.frame(height: geometry.size.height * 0.4, alignment: .bottom)
                        
                        
                    }.frame(width: geometry.size.width, height: geometry.size.height, alignment: .center)
                    
                        .onAppear{
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5){
                                self.isActive = true
                            }
                        }
                }
                
                
            }
        }
    }
}

#Preview {
    LaunchScreenView()
}
