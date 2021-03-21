//
//  NewDataView.swift
//  SwiftUITaskAppV2
//
//  Created by Paul Franco on 3/21/21.
//

import SwiftUI

struct NewDataView: View {
    
    // MARK: - PROPERTIES
    @ObservedObject var homeData: HomeViewModel
    @Environment(\.managedObjectContext) var context
    
    // MARK: - BODY
    var body: some View {
        // MARK: - VSTACK
        VStack {
            // MARK: - HSTACK
            HStack {
                Text("\(homeData.updateItem == nil ? "Add New" : "Update") Task")
                    .font(.system(size: 65))
                    .fontWeight(.heavy)
                    .foregroundColor(.black)
                
                Spacer(minLength: 0)
            }//: HSTACK
            .padding()
            
            // MARK: - TEXT EDITOR
            TextEditor(text: $homeData.content)
                .padding()
            
            // MARK: - DIVIDER
            Divider()
                .padding(.horizontal)
            
            // MARK: - HSTACK
            HStack {
                Text("When")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                
                Spacer(minLength: 0)
            }//: HSTACK
            .padding()
            
            // MARK: - HSTACK - Date Options
            HStack(spacing: 10) {
                DateButton(title: "Today", homeData: homeData)
                DateButton(title: "Tomorrow", homeData: homeData)
                
                // MARK: - DATE PICKER
                DatePicker("", selection: $homeData.date, displayedComponents: .date)
                    .labelsHidden()
            }
            .padding()
            
            
            // MARK: - ADD TASK BUTTON
            Button(action: {
                homeData.writeData(context: context)
            }, label: {
                Label(
                    title: { Text(homeData.updateItem == nil ? "Add Now" : "Update Now")
                        .font(.title2)
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                    },
                    icon: { Image(systemName: "plus")
                        .font(.title2)
                        .foregroundColor(.white)
                    }
                )
                .padding(.vertical)
                .frame(width: UIScreen.main.bounds.width - 30)
                .background(
                    LinearGradient(gradient: .init(colors: [Color("Orange"),Color("Red")]), startPoint: .leading, endPoint: .trailing)
                )
                .cornerRadius(8)
            })
            .padding()
            // disable button when no content
            .disabled(homeData.content == "" ? true : false)
            .opacity(homeData.content == "" ? 0.5 : 1)
        }//: VSTACK
        .background(Color.black.opacity(0.06))
        .ignoresSafeArea(.all, edges: .bottom)
    }//: BODY
}



