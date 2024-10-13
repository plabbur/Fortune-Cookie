//
//  EditWidgetView.swift
//  Fortune Cookie
//
//  Created by Cole Abrams on 8/5/24.
//

import SwiftUI


struct EditWidgetView: View {
    @EnvironmentObject var dataModel: FortuneCookieModel
    
    var widget: WidgetModel

    var body: some View {
        
        OverlayTemplateView(content: EditWidgetContentView(widget: widget), overlay: .EDIT_WIDGET, height: 690, title: "Edit widget", customHeader: true)
    }
}

struct EditWidgetContentView: View {
    @State var yOffset: Double = 900
    @State var opacityOffset: Double = 0
    @State var widgetErrorOpacity = 0.0
    
    @EnvironmentObject var dataModel: FortuneCookieModel
    @State var selectedSize: WidgetModel.SizeMode
    @State var selectedColor: WidgetColor
    @State var selectedFont: String
    
    @State var showWidgetError: Bool = false
    @State var chooseFont: Bool = false
    
    var widget: WidgetModel
    
    init(widget: WidgetModel) {
        self.widget = widget
        self._selectedSize = State(initialValue: widget.size)
        self._selectedColor = State(initialValue: widget.color)
        self._selectedFont = State(initialValue: widget.font)
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                
                ZStack {
                    
                    Text("Edit widget")
                        .foregroundColor(.offWhite)
                        .font(.system(size: 20))
                        .fontWeight(.semibold)
                    
                    Button(action: {
                        
                        if (dataModel.widgetExists(widget: WidgetModel(size: selectedSize, color: selectedColor, font: selectedFont))) {
                            withAnimation(.easeInOut(duration: 0.25)) {
                                widgetErrorOpacity = 1.0
                            }
                            showWidgetError = true
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {

                                withAnimation(.easeInOut(duration: 0.5)) {
                                    widgetErrorOpacity = 0.0
                                }
                            }
                        } else {
                            widget.editWidget(widget: WidgetModel(size: selectedSize, color: selectedColor, font: selectedFont))
                            dataModel.updateDefaults()
//                                dataModel.addWidget(widget: WidgetModel(size: selectedSize, color: selectedColor, font: selectedFont))
                            dataModel.currentOverlay = .NONE
                        }
                        
                    }) {
                        
                        Text("Save")
                            .fontWeight(.bold)
                            .foregroundColor(dataModel.widgetExists(widget: WidgetModel(size: selectedSize, color: selectedColor, font: selectedFont)) ? .gray : .saveYellow)
                            .frame(width: geometry.size.width - 80, alignment: .trailing)
                    }
                    
                }
                .padding(.bottom, 30)


                
                WidgetView(shareable: false, expandable: false, staged: true, size: selectedSize, color: selectedColor, font: selectedFont)
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
                        .fill(selectedColor.getGradient())
                        .frame(width: 44, height: 44)
                        .padding(.trailing, 38)
                        .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 1)
//                        .overlay {
//                            Circle()
//                                .frame(width: 37, height: 37)
//                                .foregroundColor(selectedColor)
//                                .padding(.trailing, 38)
//                        }
                }
                .padding(.bottom, 50)

                
                Button(action: { 
                    dataModel.currentOverlay = .VIEW_WIDGET
                }) {
                    Text("Cancel")
                        .foregroundColor(.cancelRed)
                        .font(.system(size: 18))
                        .fontWeight(.semibold)
                        .padding(.top, 80)
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
                        .position(x: geometry.size.width / 2, y: -40)
                        .opacity(widgetErrorOpacity)
                        
                }
            }
            .ignoresSafeArea()
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
                                        Button(action: {
                                            selectedFont = font
                                            chooseFont = false
                                        }) {
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
                        .position(x: geometry.size.width / 2, y: geometry.size.height - 225)
                }
            }
        }
    }
}
//
//struct saveButtonView: View {
//    @EnvironmentObject var dataModel: FortuneCookieModel
//    
//    @State var selectedSize: WidgetModel.SizeMode
//    @State var selectedColor: WidgetColor
//    @State var selectedFont: String
//    
//    @State var showWidgetError: Bool = false
//    
//    var widget: WidgetModel
//
//    
//    var body: some View {
//        Button(action: {
//            if (dataModel.widgetExists(widget: WidgetModel(size: selectedSize, color: selectedColor, font: selectedFont))) {
//                showWidgetError = true
//            } else {
//                widget.editWidget(widget: WidgetModel(size: selectedSize, color: selectedColor, font: selectedFont))
////                dataModel.editWidget = false
//            }
//        }) {
//            Text("Save")
//                .fontWeight(.bold)
//                .foregroundColor(.saveYellow)
//        }
//    }
//}

#Preview {
    EditWidgetView(widget: WidgetModel(size: WidgetModel.SizeMode.MEDIUM, color: Constants.originalColors[2], font: "New York Times"))
        .environmentObject(FortuneCookieModel())
}
