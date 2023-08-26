//
//  AddItemView.swift
//  ToDoApp
//
//  Created by Himanshu Karamchandani on 21/08/23.
//

import SwiftUI

struct AddItemView: View {
    @ObservedObject var viewModel: ToDoItemViewModel = ToDoItemViewModel()
    @State var toDoText: String = ""
    @State var priority: String = "MEDIUM"
    @State var dueDate: Date = Date()
    @State var startdate: Date = Date()
    @State var showAlert: Bool = false
    @FocusState var toDoTextFocus: Bool
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        ScrollView {
            VStack(spacing: 30) {
                crossLink
                headingText
                detailSection
                Spacer()
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                toDoTextFocus = true
            }
        }
        
        
    }
    var crossLink: some View {
        Button {
            presentationMode.wrappedValue.dismiss()
        } label: {
            Image(systemName: "xmark")
                .foregroundColor(.accentColor)
                .font(.system(size: 20))
                .frame(width: UIScreen.main.bounds.width * 0.9,alignment: .leading)
                .padding(.top,10)
        }

        
    }
    var headingText: some View {
        Text("Add New Item")
            .font(.title)
            .fontWeight(.medium)
    }
    var detailSection: some View {
        VStack(spacing: 30) {
            TextField("Type Here...", text: $toDoText)
                .focused($toDoTextFocus)
                .padding()
                .background(
                    Color.gray.opacity(0.3)
                        .cornerRadius(10)
                )
            Picker(selection: $priority) {
                Text("TOP").tag("TOP")
                Text("MEDIUM").tag("MEDIUM")
                Text("LOW").tag("LOW")
            } label: {
                
            }
            .pickerStyle(SegmentedPickerStyle())

            DatePicker("Select Due Date",
                       selection: $dueDate,
                       in: startdate...,
                       displayedComponents: .date
            )
                .datePickerStyle(GraphicalDatePickerStyle())
            
            Button {
                addItemButton()
            } label: {
                Text("Add To Do")
                    .foregroundColor(.white)
                    .padding()
                    .background(
                        Color.accentColor
                            .cornerRadius(10)
                    )
            }
            .alert("Empty To Do Text", isPresented: $showAlert) {
                Button("Ok") {
                    showAlert = false
                }
            } message: {
                Text("Please Enter Text In To Do Text")
            }

            
            

        }
        .padding(.horizontal,30)
    }
    
    func addItemButton() {
        if !validateTodoText(toDoText: toDoText) {
            showAlert = true
        } else {
            viewModel.addItem(toDoText: toDoText, priority: priority, dueDate: dueDate)
            presentationMode.wrappedValue.dismiss()
            viewModel.getItems()
        }
        
    }
    func validateTodoText(toDoText: String) -> Bool {
        guard !toDoText.isEmpty else {
            return false
        }
        return true
    }
}


struct AddItemView_Previews: PreviewProvider {
    static var previews: some View {
        AddItemView()
    }
}
