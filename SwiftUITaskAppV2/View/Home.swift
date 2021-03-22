//
//  Home.swift
//  SwiftUITaskAppV2
//
//  Created by Paul Franco on 3/21/21.
//

import SwiftUI
import CoreData

struct Home: View {
    // MARK: - PROPERTIES
    @StateObject var homeData = HomeViewModel()
    @FetchRequest(entity: Task.entity(), sortDescriptors: [NSSortDescriptor(key: "date", ascending: true)], animation: .spring()) var results : FetchedResults<Task>
    @Environment(\.managedObjectContext) var context
    @State private var editorIsShown: Bool = false
    
    // MARK: - BODY
    var body: some View {
        // Mark: - VSTACK
        ZStack(alignment: Alignment(horizontal: .trailing, vertical: .bottom), content: {
            // MARK: - VSTACK
            VStack(spacing: 0) {
    
                    Text("Tasks")
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity, alignment: .leading)
             
                .padding()
                        .background(Color.white.edgesIgnoringSafeArea(.top))
                
                if results.isEmpty {
                    
                    Text("No Tasks!!!!")
                        .font(.title)
                        .foregroundColor(.gray)
                        .fontWeight(.heavy)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                    
                    
                } else {
                    // MARK: - SCROLLVIEW
                    ScrollView(.vertical, showsIndicators: false, content: {
                        // MARK: - LAZYVSTACK
                        LazyVStack(alignment: .leading, spacing: 20){
                            // MARK: - FOREACH
                            ForEach(results) { task in
                                // MARK: - VSTACK
                                VStack(alignment: .leading, spacing: 5, content: {
                                    Text(task.content ?? "")
                                        .font(.title)
                                        .fontWeight(.bold)
                                    Text(task.date ?? Date(), style: .date)
                                        .fontWeight(.bold)
                                })
                                .foregroundColor(.black)
                                .contextMenu {
                                    Button(action: {
                                            homeData.editItem(item: task)
                                        editorIsShown.toggle()
                                    }, label: {
                                        Text("Edit")
                                    })
                                    
                                    Button(action: {
                                        context.delete(task)
                                        try! context.save()
                                    }, label: {
                                        Text("Delete")
                                    })
                                }
                            }//: FOREACH
                        }//: LAZYVSTACK
                        .padding()
                    })//: SCROLLVIEW
                    
                }
            }//: VSTACK
            Button(action: { self.editorIsShown.toggle() }, label: {
                Image(systemName: "plus")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .padding(20)
                    .background(
                        AngularGradient(gradient: .init(colors: [Color("Orange"),Color("Red")]), center: .center)
                    )
                    .clipShape(Circle())
            })
            .padding()
        }) //: ZSTASCK
        
        .background(Color.black.opacity(0.06).ignoresSafeArea(.all, edges: .all))
        .sheet(isPresented: $editorIsShown, content: {
            EditTaskView(homeData: homeData)
        })
    }
}

// MARK: - PREVIEW
struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
