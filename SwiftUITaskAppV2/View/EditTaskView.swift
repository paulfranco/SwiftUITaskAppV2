//
//  NewDataView.swift
//  SwiftUITaskAppV2
//
//  Created by Paul Franco on 3/21/21.
//

import SwiftUI

struct EditTaskView: View {
    
    // MARK: - PROPERTIES
    @ObservedObject var homeData: HomeViewModel
    @Environment(\.managedObjectContext) var context
    @Environment(\.presentationMode) var presentation
    
    // MARK: - BODY
    var body: some View {
        // MARK: - VSTACK
        VStack {
            
            Text("\(homeData.updateItem == nil ? "Add New" : "Update") Task")
                .font(.system(size: 65))
                .fontWeight(.heavy)
                .foregroundColor(.black)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
            
            // MARK: - TEXT EDITOR
            TextEditor(text: $homeData.content)
                .padding()
            
            // MARK: - DIVIDER
            Divider()
                .padding(.horizontal)
            
            
            Text("When:")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.black)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
            
            // MARK: - HSTACK - Date Options
            HStack(spacing: 10) {
                // MARK: - TODAY BUTTON
                Button(action: {
                    homeData.updateDate(to: .today)
                }, label: {
                    Text("Today")
                        .fontWeight(.bold)
                })
                .buttonStyle(GradientButtonStyle(isSelected: homeData.isDateEqual(to: .today)))
    
                // MARK: - TOMORROW BUTTON
                Button(action: {
                    homeData.updateDate(to: .tomorrow)
                    
                }, label: {
                    Text("Tomorrow")
                        .fontWeight(.bold)
                })
                .buttonStyle(GradientButtonStyle(isSelected: homeData.isDateEqual(to: .tomorrow)))
                
                // MARK: - DATE PICKER
                DatePicker("", selection: $homeData.date, in: Date()... , displayedComponents: .date)
                    .labelsHidden()
                    
            }
            .padding()
            
            
            // MARK: - ADD TASK BUTTON
            Button(action: {
                homeData.writeData(context: context)
                presentation.wrappedValue.dismiss()
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
                .frame(maxWidth: .infinity, alignment: .center)
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
        .onDisappear {
            self.homeData.reset()
        }
    }//: BODY
}


struct NewDataView_Previews: PreviewProvider {
    static var previews: some View {
        EditTaskView(homeData: HomeViewModel())
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}


