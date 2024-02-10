//
//  DefinitionView.swift
//  DictionMaster
//
//  Created by Gustavo Assis on 06/02/24.
//

import SwiftUI

struct DefinitionView: View {
    
    @EnvironmentObject var viewModel: DictionaryViewModel
    @Environment(\.dismiss) var dismiss
    
    private var audioURL: URL? = nil
    private let cacheManager = CacheManager.shared
    
    var body: some View {
        NavigationView{
            if viewModel.showSaleView {
                SaleView()
                    .preferredColorScheme(.light)
            } else {
                
                if viewModel.isLoading {
                    ProgressView()
                        .preferredColorScheme(.light) 
                } else if let definition = viewModel.definition {
                    
                    GeometryReader { geometry in
                        VStack {
                            Spacer()
                            ScrollView{
                                //MARK: - Header
                                HeaderDefinitionView(geometry, definition: definition)
                                
                                //MARK: - Definitions
                                DefinitionsContentView(geometry)
                                
                                //MARK: - Divider
                                Divider()
                                    .padding(.vertical)
                                
                                //MARK: - Footer
                                FooterDefinitionView(geometry, definition: definition)
                                
                                
                            }
                            
                        }
                        .frame(width: geometry.size.width, height: geometry.size.height, alignment: .center)
                    }
                    
                    .onChange(of: viewModel.definition != nil) {
                        viewModel.getpartOfSpeech()
                        viewModel.updateAudioAvailability()
                    }
                    .onAppear{
                        viewModel.updateAudioAvailability()
                        print("Esse tem audio: \(viewModel.audioAvailable)")
                    }
                } 
                else if let errorMessage = viewModel.errorMessage {
                    VStack{
                        Text(errorMessage)
                        Button("Try another"){
                            dismiss()
                        }
                        
                    }
                }
            }
            
        }
        .navigationBarBackButtonHidden(true)
        
    }
    
}


extension DefinitionView {
    
    private func HeaderDefinitionView(_ geometry: GeometryProxy, definition: WordElement) -> some View {
        VStack(alignment: .leading, spacing: 10){
            Text(definition.word.capitalizedSentence)
                .font(.system(size: 45, weight: .bold, design: .rounded))
                .foregroundColor(Color("strongBlueColor"))
            
            
            HStack{
                Button(action: {
                    if viewModel.audioAvailable {
                        viewModel.playSound(viewModel.getFirstAudioURL()!)
                    }
                }, label: {
                    Circle()
                        .frame(width: 46, height: 46)
                        .foregroundColor( viewModel.audioAvailable ? Color("blueButtonColor") : .gray)
                        .overlay {
                            
                            if viewModel.audioAvailable {
                                Image("speaker")
                            } else {
                                Image(systemName: "speaker.slash.fill")
                                    .font(.title2)
                                    .foregroundStyle(.white)
                            }
                            
                            
                        }
                })
                .disabled(!viewModel.audioAvailable)
                Text(definition.phonetic ?? "")
                    .font(.system(size: 22, weight: .bold, design: .rounded))
                    .foregroundColor(Color("strongBlueColor"))
                    .opacity(0.4)
                
            }
            
        }
        .frame(width: geometry.size.width * 0.9, height: geometry.size.height * 0.2, alignment: .leading)
    }
    
    private func DefinitionsContentView(_ geometry: GeometryProxy) -> some View {
        VStack(alignment: .leading){
            ForEach(viewModel.wordDataFormatted, id: \.partOfSpeech){ partOfSpeechData in
                
                Text(partOfSpeechData.partOfSpeech.capitalizedSentence)
                    .font(.system(size: 20, weight: .semibold, design: .rounded))
                    .foregroundColor(Color("lightBlueColor"))
                    .padding(.bottom)
                
                ForEach(partOfSpeechData.deifinitions, id: \.definition) { defition in
                    
                    VStack(spacing: 0){
                        Text(defition.definition!)
                            .font(.system(size: 16, weight: .bold, design: .rounded))
                            .foregroundColor(Color("strongBlueColor"))
                            .frame(maxWidth: geometry.size.width * 0.9, alignment: .topLeading)
                            .fixedSize(horizontal: false, vertical: true)
                        
                        
                        if let example = defition.example, !example.isEmpty{
                            Text("• \(defition.example ?? "")")
                                .font(.system(size: 16, weight: .regular, design: .rounded))
                                .foregroundColor(Color("strongBlueColor"))
                                .frame(maxWidth: geometry.size.width * 0.9, alignment: .topLeading)
                                .fixedSize(horizontal: false, vertical: true)
                        }
                        
                    }
                    .padding(.bottom, 5)
                    
                    
                    
                    
                    
                }
                
            }
        }
        .frame(width: geometry.size.width * 0.9, alignment: .topLeading)
    }
    
    private func FooterDefinitionView(_ geometry: GeometryProxy, definition: WordElement) -> some View {
        VStack{
            VStack(alignment: .leading){
                Text("That's it for \"\(definition.word)\"!")
                    .font(.system(size: 24, weight:.bold, design: .rounded))
                    .foregroundColor(Color("strongBlueColor"))
                
                Text("Try another search now!")
                    .font(.system(size: 16, weight:.regular, design: .rounded))
                    .foregroundColor(Color("strongBlueColor"))
                
            }
            .frame(width: geometry.size.width * 0.9, alignment: .leading)
            .padding(.bottom)
            
            
            Button {
                print("Aqui")
                dismiss()
            } label: {
                ButtonLabelComponent(title: "New Search")
                    .frame(height: 64)
            }
            
        }
    }
}
