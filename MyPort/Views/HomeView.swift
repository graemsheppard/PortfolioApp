//
//  HomeView.swift
//  MyPort
//
//  Created by Graem Sheppard on 2021-02-10.
//

import SwiftUI


struct HomeView: View {
    
    @StateObject var viewModel: ViewModel = ViewModel()
    
    var body: some View {
        VStack (spacing: 15) {
            Text("this is a graph")
                .frame(maxWidth: .infinity, minHeight: 240)
                .background(Color("tertiary"))
                .padding([.leading, .trailing])
            HStack {
                Spacer()
                NavigationLink(
                    destination: LotsView(),
                    label: {
                        Text("View Lots")
                            .bold()
                            .padding([.leading, .trailing])
                            
                    })
            }

            List(viewModel.stockList){ stock in
                HStack{
                    Text(stock.symbol).font(.headline)
                    Text(stock.name).font(.subheadline)
                    Spacer()
                    Text("\(String(format:"%.2f", stock.percentageGain)) %")
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        .frame(width: 100)
                        .padding([.top, .bottom], 5)
                        .background(stock.percentageGain > 0 ? Color.green : (stock.percentageGain < 0 ? Color.red : Color("tertiary")))
                    
                }
                
            }.listStyle(PlainListStyle.init())

            
            Spacer()
            
        }.navigationTitle("My Portfolio")
    }
}
