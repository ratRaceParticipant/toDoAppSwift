//
//  NoItemsView.swift
//  ToDoApp
//
//  Created by Himanshu Karamchandani on 21/08/23.
//

import SwiftUI

struct NoItemsView: View {
    @ObservedObject var viewModel: ToDoItemViewModel
    @State var isAnimate: Bool = false
    @State var showSheet: Bool = false
    var body: some View {
        VStack(spacing: 30) {
            topHeadings
            Button {
                showSheet.toggle()
            } label: {
                    addItemButtonLabel
            }
            .sheet(isPresented: $showSheet) {
                AddItemView(viewModel: viewModel)
            }

            Spacer()
        }
        .onAppear {
            isAnimate = true
        }
    }
    var topHeadings: some View {
        VStack(spacing: 30) {
            Text("There Are No Items!")
                .font(.title)
                .fontWeight(.semibold)
                .padding(.top,50)
            Text("Are you a Productive Person? Start Adding your To Do Items and manage your work.")
                .padding(.horizontal,30)
                .multilineTextAlignment(.center)
        }
    }
    var addItemButtonLabel: some View {
        Text("Start Adding Your Items")
            .foregroundColor(.white)
            .background(
                Color.green
                    .cornerRadius(10)
                    .frame(
                        width:isAnimate ? 300 : 280,
                        height:isAnimate ? 80 : 60
                    )
//                        .background(Color.green)
                    .shadow(
                        color: Color.green.opacity(0.5),
                        radius: 10,
                        x: 0,y: isAnimate ? 15 : 10
                    )
                    .animation(
                        Animation.linear(duration: 1.5).repeatForever(),
                        value: isAnimate
                    )
            )
            .padding(.vertical,30)
    }
}

struct NoItemsView_Previews: PreviewProvider {
    static var previews: some View {
        NoItemsView(viewModel: ToDoItemViewModel())
    }
}
