//
//  ListItemView.swift
//  ToDoApp
//
//  Created by Himanshu Karamchandani on 21/08/23.
//

import SwiftUI

struct ListItemView: View {
    @ObservedObject var viewModel: ToDoItemViewModel
    
//    @State var priorities: [String] = ["TOP","MEDIUM","LOW"]

    var body: some View {
        List {
            if !viewModel.topPriorityData.isEmpty {
                Section {
                    ForEach(viewModel.topPriorityData) { data in
                        SingleListItemView(viewModel: viewModel, toDoModel: data )
                    }
                    .onDelete { IndexSet in
                        viewModel.deleteItems(IndexSet: IndexSet, priority: "TOP")
                    }
                    .onMove { IndexSet, Int in
                        viewModel.moveItems(IndexSet: IndexSet, Int: Int, priority: "TOP")
                    }


                } header: {
                    Text("TOP")
                        .foregroundColor(.accentColor)
                }
            }
            if !viewModel.mediumPriorityData.isEmpty {
                Section {
                    ForEach(viewModel.mediumPriorityData) { data in
                        SingleListItemView(viewModel: viewModel, toDoModel: data)

                            
                    }
                    .onDelete { IndexSet in
                        viewModel.deleteItems(IndexSet: IndexSet, priority: "MEDIUM")
                    }
                    .onMove { IndexSet, Int in
                        viewModel.moveItems(IndexSet: IndexSet, Int: Int, priority: "MEDIUM")
                    }


                } header: {
                    Text("MEDIUM")
                        .foregroundColor(.accentColor)
                }
            }
            
            if !viewModel.lowPriorityData.isEmpty {
                Section {
                    ForEach(viewModel.lowPriorityData) { data in
                        SingleListItemView(viewModel: viewModel, toDoModel: data)

                            
                    }
                    .onDelete { IndexSet in
                        viewModel.deleteItems(IndexSet: IndexSet, priority: "LOW")
                    }
                    .onMove { IndexSet, Int in
                        viewModel.moveItems(IndexSet: IndexSet, Int: Int, priority: "LOW")
                    }


                } header: {
                    Text("LOW")
                        .foregroundColor(.accentColor)
                }
            }
            
        }
        .listStyle(SidebarListStyle())
    }
    
    
}


struct ListItemView_Previews: PreviewProvider {
    static var previews: some View {
        ListItemView(viewModel: ToDoItemViewModel())
    }
}
