//
//  test_sheet.swift
//  My_Third_iOS_homework
//
//  Created by User16 on 2020/4/18.
//  Copyright © 2020 User16. All rights reserved.
//

import Foundation

struct ContentView: View {
 @State private var showSecondPage = false
 var body: some View {
 Button("show second page") {
 self.showSecondPage = true
 }
 .sheet(isPresented: self.$showSecondPage) {
 SecondView(showSecondPage: self.
$showSecondPage)
 }
 }
}

struct SecondView: View {

 @Binding var showSecondPage: Bool

 var body: some View {
 Button("close") {
 self.showSecondPage = false
 }
 }
}
struct SecondView_Previews: PreviewProvider {
 static var previews: some View {
 SecondView(showSecondPage: .constant(true))
 }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
