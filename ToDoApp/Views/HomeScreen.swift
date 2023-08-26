//
//  HomeScreen.swift
//  ToDoApp
//
//  Created by Himanshu Karamchandani on 21/08/23.
//

import SwiftUI

struct HomeScreen: View {
    @ObservedObject var viewModel: ToDoItemViewModel
    
    @State var showSheet: Bool = false
    
    
    var body: some View {
        NavigationStack {
            
            Group {
                if viewModel.toDoData.isEmpty {
                    NoItemsView(viewModel: viewModel)
                } else {
                    ListItemView(viewModel: viewModel)
                }
            }
            
                .navigationTitle("To Do List")
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        EditButton()
                            
                    }
                    ToolbarItem {
                        Button {
                            showSheet.toggle()
                        } label: {
                            Text("Add")
                        }
                        .sheet(isPresented: $showSheet) {
                            AddItemView(viewModel: viewModel)
                        }
                        

                    }
                }
               
            
        }
        
    }
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen(viewModel: ToDoItemViewModel())
            
    }
}
