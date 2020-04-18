//
//  ContentView.swift
//  My_Third_iOS_homework
//
//  Created by User16 on 2020/4/18.
//  Copyright © 2020 User16. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var scale: CGFloat = 1
    @State private var brightnessAmount: Double = 0
    var body: some View {
        VStack {
            GeometryReader { geometry in
                VStack {
                    Image("D4DJ")
                    .resizable()
                    .scaledToFill()
                    .frame(width: geometry.size.width,height: geometry.size.width / 4 * 3)
                    .clipped()
                    .brightness(self.brightnessAmount)
                    Form {
                        BrightnessSlider(brightnessAmount:self.$brightnessAmount)
                        DayPickerView()
                        BuyTicketView()
                        RoleChoiceView()
                        BlendChoiceView()
                        TypeNameView()
                        GoConcertView()
                        GoSecondView()
                    }
                }
            }
        }
    }
}
//---------------練習用slider做縮放功能------------
          /*Image("D4DJ")
             .resizable()
             .frame(width: 420, height: 200)
             .scaleEffect(scale)
           Slider(value: $scale, in: 0...1, step: 0.1)
           .accentColor(.orange)
          Text("\(scale, specifier: "%.2f")")*/

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}



struct BrightnessSlider: View {
    @Binding var brightnessAmount: Double
    var body: some View {
        HStack {
            Text("亮度")
            Slider(value: self.$brightnessAmount, in: 0...1,
                   minimumValueLabel: Image(systemName:
                    "sun.max.fill").imageScale(.small), maximumValueLabel:
            Image(systemName: "sun.max.fill").imageScale(.large)) {
                Text("")
            }
        }
    }
}

extension BlendMode {
 var name: String {
 return "\(self)"
 }
}

struct GoConcertView: View {
    @State private var showAlert = false
    var body: some View {
        VStack{
            Button(action: {
                self.showAlert = true
            }) {
                VStack {
                    Image("rinku")
                        .renderingMode(.original)
                    Text("我有機會去演唱會嗎")
                }
            }.alert(isPresented: self.$showAlert) { () -> Alert in
                let answer = ["有", "沒有"].randomElement()!
                return Alert(title: Text(answer), message: Text("這是真的"), primaryButton: .default(Text("不敢相信"), action: {
                    print("不敢相信")
                }), secondaryButton: .default(Text("你騙我吧"), action: {
                    print("你騙我吧")
                }))
            }
        }
    }
}

struct SecondView: View {

 @Binding var showSecondPage: Bool

 var body: some View {
 Button("回到第一頁") {
 self.showSecondPage = false
 }
 }
}

/*struct SecondView_Previews: PreviewProvider {
 static var previews: some View {
 SecondView(showSecondPage: .constant(true))
 }
}*/

struct GoSecondView: View {
    @State private var showSecondPage = false
    var body: some View {
        VStack{
            Button("點我看第二頁") {
                self.showSecondPage = true
            }
            .sheet(isPresented: self.$showSecondPage) {
                SecondView(showSecondPage: self.$showSecondPage)
            }
            
        }
    }
}

struct RoleChoiceView: View {
    @State private var selectRole = false
    @State private var selectedName = "Happy Around!"
    var roles = ["Happy Around!", "Peaky P-key", "Photon Maiden", "merm4id","燐舞曲"]
    var body: some View {
        VStack {
            Toggle("我要選角色", isOn: self.$selectRole)
            if self.selectRole {
                Picker(selection: self.$selectedName, label: Text("選擇角色")) {
                    ForEach(self.roles, id: \.self) { (role) in
                        Text(role)
                    }
                }
                .pickerStyle(WheelPickerStyle())
                //.pickerStyle(SegmentedPickerStyle())
                Text("我最愛的組合是\(self.selectedName)")
            }
        }
    }
}

struct BuyTicketView: View {
    @State private var number = 0
    var body: some View {
        VStack {
            Text("買 \(self.number) 張 演唱會門票")
            Stepper("買 門票", value: self.$number)
                .labelsHidden()
        }
    }
}

struct DayPickerView: View {
    @State private var concertTime = Date()
    let dateFormatter: DateFormatter = {
       let dateFormatter = DateFormatter()
       dateFormatter.dateStyle = .medium
       dateFormatter.timeStyle = .medium
       return dateFormatter
    }()
    var body: some View {
        VStack{
            DatePicker("選擇演唱會時間", selection: self.$concertTime, in: Date()..., displayedComponents: .date)
            Text(self.dateFormatter.string(from: self.concertTime))
        }
    }
}

struct BlendChoiceView: View {
    @State private var selectBlend = BlendMode.screen
    let blendModes: [BlendMode] =  [.screen, .colorDodge, .colorBurn]
    var body: some View {
        VStack{
            ZStack {
                Image("D4DJ")
                    .resizable()
                    .opacity(0.5)
                Image("star")
                    .resizable()
                    .blendMode(self.selectBlend)
                //.blendMode(.screen)
                //.blendMode(.colorBurn)
                //.blendMode(.colorDodge)
            }
            Picker("選擇 blend", selection: self.$selectBlend) {
                ForEach(self.blendModes, id: \.self) { (blendMode)
                    in
                    Text(blendMode.name)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
        }
    }
}

struct TypeNameView: View {
    @State private var yourName = ""
    var body: some View {
        VStack{
            TextField("你的名字", text: self.$yourName)
                .padding()
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.black, lineWidth: 3))
                .padding()
        }
    }
}
