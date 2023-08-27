//
//  SingleListItemView.swift
//  ToDoApp
//
//  Created by Himanshu Karamchandani on 26/08/23.
//

import SwiftUI

struct SingleListItemView: View {
    @ObservedObject var viewModel: ToDoItemViewModel
    var toDoModel: ToDoModel
    var body: some View {
        HStack {
            VStack(alignment: .leading,spacing: 5) {
                Text("\(toDoModel.toDoText)")
                    .font(.headline)
                    .strikethrough(toDoModel.isCompleted)
                    .fontWeight(.bold)
                HStack {
                    Text("Due On: ")
                        .foregroundColor(.gray)
                        .fontWeight(.light)
                        .font(.callout)
                        .strikethrough(toDoModel.isCompleted)
                    Text("\(toDoModel.toDoDuedate, format: Date.FormatStyle().year().month().day() )")
                        .fontWeight(.light)
                        .font(.callout)
                        .strikethrough(toDoModel.isCompleted)
                        
                }
            }
            Spacer()
            Button {
                viewModel.updateCompletionState(item: toDoModel)
            } label: {
                if toDoModel.isCompleted {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(.accentColor)
                        
                } else {
                    Image(systemName: "circle")
                        .foregroundColor(.accentColor)
                        
                }
            }

        }
        .swipeActions(
            edge: .leading,
            allowsFullSwipe: true,
            content: {
                Button {
                    viewModel.updateCompletionState(item: toDoModel)
                } label: {
                    if toDoModel.isCompleted {
                        Text("Mark as Not Done")
                    } else {
                        Text("Mark as Done")
                    }

                }
                .tint(.accentColor)

        })
    }
    
    
}

struct SingleListItemView_Previews: PreviewProvider {
    
    static var previews: some View {
        SingleListItemView(viewModel: ToDoItemViewModel(), toDoModel: ToDoModel(toDoText: "Texr", toDoPriority: "TOP", toDoDuedate: Date(), isCompleted: true, createdOn: Date()))
    }
}
