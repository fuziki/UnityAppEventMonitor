//
//  ContentView.swift
//  NativeExample
//
//  Created by fuziki on 2022/07/17.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel = ContentViewModel.shared
    var body: some View {
        VStack {
            Text("AppEventMonitorExample")
            Button {
                viewModel.start()
            } label: {
                Text("Start")
            }
            Button {
                viewModel.stop()
            } label: {
                Text("Stop")
            }
            Text("\(viewModel.event)")
        }
        .padding(120)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
