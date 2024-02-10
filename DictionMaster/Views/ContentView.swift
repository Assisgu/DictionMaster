//
//  ContentView.swift
//  DictionMaster
//
//  Created by Gustavo Assis on 05/02/24.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var viewModel = DictionaryViewModel()
    
    @State private var searchQuery: String = ""
    @FocusState private var isTextFieldFocused: Bool
        
    var body: some View {
        NavigationView {
            GeometryReader{ geometry in
                VStack(spacing: 0){
                    
                    HeaderContentView(geometry)
                    SearchContentView(geometry)
                    ButtonSearchView(geometry)
                }
                .frame(width: geometry.size.width, height: geometry.size.height, alignment: .center)
                
                .onAppear{
                    
                    self.isTextFieldFocused = true
                    searchQuery = ""
                    print(isTextFieldFocused)
                }
                
                .onDisappear{
                    viewModel.searchWord(searchQuery.lowercased())
                }
                
            }
            
        }
        
    }
    
}

extension ContentView {
    
    private func HeaderContentView(_ geometry: GeometryProxy) -> some View{
        VStack{
            HStack{
                Image("english-icon")
                Text("English")
                    .textCase(.uppercase)
                    .font(.system(size: 18, weight: .regular, design: .rounded))
                    .foregroundColor(Color("strongBlueColor"))
            }
            .frame(width: 137, height: 40)
            .background(Color("lightBlueColor").opacity(0.1))
            .cornerRadius(20)
        }
        .frame(width: geometry.size.width, height: geometry.size.height * 0.2)
    }
    
    private func SearchContentView(_ geometry: GeometryProxy) -> some View {
        VStack{
            TextField("", text: $searchQuery,
                            prompt: Text("Type a word...")
                                    .font(.system(size: 32, weight: .regular, design: .rounded))
                                    .foregroundColor(Color("lightBlueColor"))
            )
            .keyboardType(.alphabet)
            .padding()
                .font(.system(size: 32, weight: .bold, design: .rounded))
                .foregroundColor(Color("strongBlueColor"))
                .multilineTextAlignment(.center)
                .disableAutocorrection(true)
                .focused($isTextFieldFocused)

        }
        .frame(width: geometry.size.width, height: geometry.size.height * 0.4, alignment: .bottom)
    }
    
    private func ButtonSearchView(_ geometry: GeometryProxy) -> some View {
        VStack{
            if searchQuery != "" {
                NavigationLink {
                    DefinitionView().environmentObject(viewModel)
                        .preferredColorScheme(.light)
                } label: {
                    ButtonLabelComponent(title: "Search")
                    .padding(.bottom)
                }

            }
        }
            .frame(width: geometry.size.width, height: geometry.size.height * 0.4, alignment: .bottom)
    }
    
}

#Preview {
    ContentView()
}
