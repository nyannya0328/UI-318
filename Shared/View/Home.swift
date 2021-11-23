//
//  Home.swift
//  UI-318 (iOS)
//
//  Created by nyannyan0328 on 2021/09/30.
//

import SwiftUI

struct Home: View {
    @State var currentData : Date = Date()
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            
            VStack(spacing:15){
                
                CustomDatePiker(currentDate: $currentData)
                
                
                
            }
            .padding(.vertical)
            
            
        }
        .safeAreaInset(edge: .bottom) {
            
            HStack{
                
                
                Button {
                    
                } label: {
                    
                    Text("Add to Task")
                        .font(.title3.bold())
                        .padding(.vertical)
                        .frame(maxWidth: .infinity)
                        .background(Color("Purple"),in: Capsule())
                }
                
                
                
                Button {
                    
                } label: {
                    
                    Text("Add Reminder")
                        .font(.title3.bold())
                        .padding(.vertical)
                        .frame(maxWidth: .infinity)
                        .background(Color("Purple"),in: Capsule())
                }
                
                

            }
            .padding(.horizontal)
            .padding(.top,15)
            .foregroundColor(.white)
            .background(.ultraThickMaterial)
            .cornerRadius(20)
            
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
