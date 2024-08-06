//
//  CreateWidgetView.swift
//  Fortune Cookie
//
//  Created by Cole Abrams on 8/5/24.
//

import SwiftUI

struct CreateWidgetView: View {
    @EnvironmentObject var dataModel: FortuneCookieModel
    @State var selectedSize: WidgetModel.SizeMode = WidgetModel.SizeMode.MEDIUM
    @State var selectedColor: Color = .darkBlue
    @State var selectedGradient: LinearGradient = Constants.darkBlueGradient
    @State var selectedFont: String = "Times New Roman"
    
    @State private var opacityVal: Double = 100

    @State var showWidgetError: Bool = false
    @State var chooseFont: Bool = false
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                RoundedRectangle(cornerRadius: 40)
                    .fill(.overlayBG)
                    .frame(height: 690)
                    .overlay {
                        VStack {
                            ZStack {
                                Text("Create Widget")
                                    .foregroundColor(.offWhite)
                                    .font(.system(size: 20))
                                    .fontWeight(.semibold)
                                
                                Button(action: { dataModel.createWidget = false }) {
                                    Image("Exit Icon") 
                                }
                                .frame(width: geometry.size.width, alignment: .trailing)
                                .padding(.trailing, 80)
                            }
                            .padding(.bottom, 25)
                            
                            WidgetView(expandable: false, staged: true, size: selectedSize, color: selectedColor, font: selectedFont)
                                .padding(.bottom, 25)
                            
                            HStack {
                                Text("Size")
                                    .padding(.leading, 43)
                                    .foregroundColor(.subtextGray)
                                    .font(.system(size: 18))
                                    .fontWeight(.medium)
                                
                                Spacer()
                                
                                RoundedRectangle(cornerRadius: 30)
                                    .fill(.grayButtonBG)
                                    .frame(width: 194, height: 44)
                                    .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 4)
                                    .overlay {
                                        RoundedRectangle(cornerRadius: 30)
                                            .fill(.mainGray)
                                            .frame(width: 100, height: 42)
                                            .frame(width: 192, alignment: selectedSize == .SMALL ? .leading : .trailing)
                                            .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 0)
                                    }
                                    .overlay {
                                        ZStack {
                                            Text("Small")
                                                .font(.system(size: 16))
                                                .foregroundColor(selectedSize == .SMALL ? .offWhite : .textGray)
                                                .frame(width: 100, height: 42)
                                                .frame(width: 192, alignment: .leading)
                                                .onTapGesture {
                                                    selectedSize = .SMALL
                                                }
                                            
                                            Text("Medium")
                                                .font(.system(size: 16))
                                                .foregroundColor(selectedSize == .MEDIUM ? .offWhite : .textGray)
                                                .frame(width: 100, height: 42)
                                                .frame(width: 192, alignment: .trailing)
                                                .onTapGesture {
                                                    selectedSize = .MEDIUM
                                                }
                                        }
                                        .frame(width: 194)
                                    }
                                    .padding(.trailing, 38)
                               
                            }
                            .padding(.bottom, 10)
                            
                            
                            HStack {
                                Text("Font")
                                    .padding(.leading, 43)
                                    .foregroundColor(.subtextGray)
                                    .font(.system(size: 18))
                                    .fontWeight(.medium)
                                
                                Spacer()
                                
                                Button(action: { chooseFont = true }) {
                                    RoundedRectangle(cornerRadius: 30)
                                        .fill(.grayButtonBG)
                                        .frame(width: 194, height: 44)
                                        .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 1)
                                        .overlay {
                                            ZStack {
                                                Text(selectedFont)
                                                    .font(.custom(selectedFont, size: 18))
                                                    .foregroundColor(.offWhite)
                                                
    //                                            Image("Down Arrow Icon")
    //                                                .frame(width: 194, alignment: .trailing)
    //                                                .padding(.trailing, 30)
                                            }
                                            .frame(width: 194, height: 44)
                                            
                                        }
                                }
                                .padding(.trailing, 38)
                                
                               
                            }
                            .padding(.bottom, 10)
                            
                            HStack {
                                Text("Color")
                                    .padding(.leading, 43)
                                    .foregroundColor(.subtextGray)
                                    .font(.system(size: 18))
                                    .fontWeight(.medium)
                                
                                Spacer()
                                
                                Circle()
                                    .fill(selectedGradient)
                                    .frame(width: 44, height: 44)
                                    .padding(.trailing, 38)
                                    .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 1)
                                    .overlay {
                                        Circle()
                                            .frame(width: 37, height: 37)
                                            .foregroundColor(selectedColor)
                                            .padding(.trailing, 38)
                                    }
                            }
                            .padding(.bottom, 50)
                            
                            Button(action: {
                                if (dataModel.widgetExists(widget: WidgetModel(size: selectedSize, color: selectedColor, font: selectedFont))) {
                                    showWidgetError = true
                                } else {
                                    dataModel.addWidget(widget: WidgetModel(size: selectedSize, color: selectedColor, font: selectedFont))
                                    dataModel.createWidget = false
                                }
                            }) {
                                RoundedRectangle(cornerRadius: 25)
                                    .fill(.blueButtonBG)
                                    .frame(width: 258, height: 53)
                                    .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 1)
                                    .overlay {
                                        Text("Create widget")
                                            .font(.system(size: 18))
                                            .fontWeight(.medium)
                                            .foregroundColor(.offWhite)
                                    }
                                    .padding(.bottom, 20)
                            }
                            
                            Button(action: { dataModel.createWidget = false }) {
                                Text("Cancel")
                                    .foregroundColor(.cancelRed)
                                    .font(.system(size: 18))
                                    .fontWeight(.semibold)
                            }
                        }
                    }
            }
            .overlay {
                if (showWidgetError) {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(.mainGray)
                        .frame(width: 200, height: 50)
                        .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 1)
                        .overlay {
                            Text("Widget already exists")
                                .foregroundColor(.offWhite)
                                .fontWeight(.bold)
                                
                        }
                        .opacity(opacityVal)
                        .transition(.opacity)
                        .position(x: geometry.size.width / 2, y: -50)
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.75) {
                                withAnimation(.easeOut(duration: 0.5)) {
                                    opacityVal = 0
                                }
                            }
                        }
                }
            }
            .frame(height: geometry.size.height + 400)
            .background(.black.opacity(0.25))
            .ignoresSafeArea()
            .position(x: geometry.size.width / 2, y: geometry.size.height - (geometry.size.height - 550))
            .overlay {
                
                if (chooseFont) {
                    RoundedRectangle(cornerRadius: 40)
                        .fill(.subOverlayGray)
                        .frame(height: 370)
                        .overlay {
                            VStack {
                                HStack {
                                    Text("Font")
                                        .foregroundColor(.offWhite)
                                        .font(.system(size: 22))
                                        .fontWeight(.medium)
                                        .padding(.leading, 40)
                                    
                                    Spacer()
                                    
                                    Button(action: { chooseFont = false }) {
                                        Image("Exit Icon")
                                    }
                                    .padding(.trailing, 40)
                                    
                                }
                                .padding(.top, 50)
                                .padding(.bottom, 20)
                                
                                
                                List {
                                    ForEach(Constants.fonts, id: \.self) { font in
                                        Button(action: { selectedFont = font }) {
                                            Text(font)
                                                .foregroundColor(.offWhite)
                                                .font(.custom(font, size: 22))
                                        }
                                        .frame(width: geometry.size.width, alignment: .center)
                                        
                                        Rectangle()
                                            .foregroundColor(.clear)
                                            .frame(width: 341, height: 1)
                                            .background(.dividerGray)
                                            .frame(width: geometry.size.width, alignment: .center)
                                    }
                                    .listRowBackground(Color.clear)
                                }
                                .listStyle(PlainListStyle())
                                .frame(height: 300)
                                .scrollContentBackground(.hidden)
                                .scrollIndicators(.hidden)
                            }
                            
                            
                        }
                        .position(x: geometry.size.width / 2, y: geometry.size.height - 240)
                }
            }
            
        }
    }
}

#Preview {
    CreateWidgetView()
        .environmentObject(FortuneCookieModel())
}
