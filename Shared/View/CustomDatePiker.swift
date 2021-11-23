//
//  CustomDatePiker.swift
//  UI-318 (iOS)
//
//  Created by nyannyan0328 on 2021/09/30.
//

import SwiftUI

struct CustomDatePiker: View {
    @Binding var currentDate : Date
    @State var currentMonth : Int = 0
    var body: some View {
        VStack(spacing:30){
            
            let days : [String] = [
                "SUN","Mon","Tue","WED","Thu","FRI","SAT"
            
            
            ]
            
            
            HStack{
                
                
                VStack(alignment: .leading, spacing: 15) {
                    
                    
                   
                
                        
                    Text(extraDate()[1])
                            .font(.title2.bold())
                 
                        
                    
                    Text(extraDate()[0])
                        .font(.title3.weight(.thin))
                    
                }
                    
                    
                    Spacer()
                    
                    
                    Button {
                        withAnimation{
                            currentMonth -= 1
                        }
                    } label: {
                        
                        Image(systemName: "chevron.left")
                            .font(.title2)
                        
                        
                        
                    }
                        
                        
                        Button {
                            
                            withAnimation{
                                
                                currentMonth += 1
                            }
                            
                        } label: {
                            
                            Image(systemName: "chevron.right")
                                .font(.title2)
                            
                            
                            
                        }
                        
                        
                        
                        
                        
                  

                    
                    
                    
                
                
            }
            .padding(.horizontal)
            
            HStack(spacing:0){
                
                
                ForEach(days,id:\.self){day in
                    
                    Text(day)
                        .fontWeight(.thin)
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity)
                    
                    
                }
            }
            
            
            let columns = Array(repeating: GridItem(.flexible()), count: 7)
            
            
            LazyVGrid(columns: columns, spacing: 10) {
                
                
                
                ForEach(extractDate()){value in
                    
                   
                    
                    cardView(value: value)
                        .background(
                        
                        Capsule()
                            .fill(Color("Pink"))
                            .padding(.horizontal,8)
                            .opacity(isSampleday(date1: value.date, date2: currentDate) ? 1 : 0)
                        
                        )
                        .onTapGesture {
                            
                            currentDate = value.date
                        }
                }
                
                
                
            }
            
            
            VStack(spacing:15){
                
                
                Text("Tasks")
                    .font(.title.bold())
                    .frame(maxWidth: .infinity,alignment: .leading)
                    .padding(.vertical,20)
                
                if let task = tasks.first(where: { task in
                    
                    return isSampleday(date1: task.taskDate, date2: currentDate)
                    
                }){
                    
                    
                    ForEach(task.task){task in
                        
                        
                        VStack(alignment: .trailing, spacing: 15) {
                            
                            Text(task.time.addingTimeInterval(CGFloat.random(in: 0...5000)),style: .time)
                            
                            Text(task.title)
                                .font(.title2.bold())
                            
                            
                        }
                        .padding(.vertical,10)
                        .padding(.horizontal)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .background(
                        
                            Color("Purple").opacity(0.5)
                                .cornerRadius(15)
                        
                        
                        )
                        
                        
                        
                    }
                    
                    
                    
                }
                else{
                    
                    
                    Text("No Task")
                        .font(.largeTitle.bold())
                        .foregroundColor(.red)
                }
                
                
                
            }
            .padding()
            
            
            
            
        }
        .onChange(of: currentMonth) { newValue in
            
            currentDate = getCurrentMonth()
        }
    }
    
    
    @ViewBuilder
    func cardView(value : DateValue)->some View{
        
        
        VStack{
            
            if value.day != -1{
                
              
                
                if let task = tasks.first(where: { task in
                    
                    
                    return isSampleday(date1: task.taskDate, date2: value.date)
                    
                }){
                    
                    Text("\(value.day)")
                        .font(.title2.bold())
                        .foregroundColor(isSampleday(date1: task.taskDate, date2: currentDate) ? .white : .primary)
                        .frame(maxWidth: .infinity)
                    
                    
                    Spacer()
                    
                    
                    Circle()
                        .fill(isSampleday(date1: task.taskDate, date2: currentDate) ? .white : Color("Pink"))
                        .frame(width: 8, height: 8)
                    
                    
                }
                
                else{
                    
                    Text("\(value.day)")
                        .font(.title2.bold())
                        .foregroundColor(isSampleday(date1: value.date, date2: currentDate) ? .white : .primary)
                        .frame(maxWidth: .infinity)
                    
                    Spacer()
                    
                    
                }
                
                
                
                
            }
            
           
            
            
            
        }
        .padding(.vertical,8)
        .frame(height: 60,alignment: .top)
        
        
    }
    
    func isSampleday(date1 : Date,date2 : Date)->Bool{
        
        let calender = Calendar.current
        
        return calender.isDate(date1, inSameDayAs: date2)
        
    }
    
    func getCurrentMonth()->Date{
        
        let calender = Calendar.current
        
        guard let currentMonth = calender.date(byAdding: .month, value: self.currentMonth, to: Date())else {
            
            return Date()
        }
        
        
        return currentMonth
        
        
        
        
    }
    
    func extraDate()->[String]{
        
        let calender = Calendar.current
        let month = calender.component(.month, from: currentDate) - 1
        let year = calender.component(.year, from: currentDate)
        
        return ["\(year)",calender.monthSymbols[month]]
        
        
    }
    
    func extractDate()->[DateValue]{
        
        let calender = Calendar.current
        
       let currentMonth = getCurrentMonth()
        
        var days = currentMonth.getAllDates().compactMap { date -> DateValue in
            
            
            let day = calender.component(.day, from: date)
            
            return DateValue(day: day, date: date)
            
            
            
            
        }
        
        let firstWeek = calender.component(.weekday, from: days.first!.date)
        
        for _ in  0..<firstWeek - 1{
            
            days.insert(DateValue(day: -1, date: Date()), at: 0)
            
            
        }
        
        
        return days
        
    }
    
   
}

struct CustomDatePiker_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension Date{
    
    
    func getAllDates()->[Date]{
        
        let calender = Calendar.current
        
        let startDate = calender.date(from: Calendar.current.dateComponents([.year,.month], from: self))!
        
        let range = calender.range(of: .day, in: .month, for: startDate)!
        
        return range.compactMap({ day ->Date in
            return calender.date(byAdding: .day, value: day - 1, to: startDate)!
            
            
        })
        
        
    }
    
    
    
}
