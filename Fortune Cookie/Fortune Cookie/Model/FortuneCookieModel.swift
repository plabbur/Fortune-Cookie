//
//  FortuneCookieModel.swift
//  Fortune Cookie
//
//  Created by Cole Abrams on 8/1/24.
//

import Foundation
import SwiftUI

class FortuneCookieModel: ObservableObject {
    
    @Published var createWidget: Bool = false
    @Published var viewWidget: Bool = false
    @Published var editWidget: Bool = false
    @Published var editingStagedWidget: Bool = true
    @Published var widgetToView: WidgetModel = WidgetModel(size: WidgetModel.SizeMode.MEDIUM, color: .darkBlue, font: "New York Times")
    
    @Published var stagedWidget: WidgetModel = WidgetModel(size: WidgetModel.SizeMode.MEDIUM, color: Color.red, font: "Times New Roman")
    @Published var allWidgets: [WidgetModel] = [
        WidgetModel.init(size: WidgetModel.SizeMode.MEDIUM, color: Color.darkBlue, font: "Times New Roman"),
        WidgetModel.init(size: WidgetModel.SizeMode.MEDIUM, color: Color.yellow, font: "Helvetica"),
        WidgetModel.init(size: WidgetModel.SizeMode.MEDIUM, color: Color.red, font: "Times New Roman"),
        WidgetModel.init(size: WidgetModel.SizeMode.MEDIUM, color: Color.gray, font: "Georgia"),
        WidgetModel.init(size: WidgetModel.SizeMode.SMALL, color: Color.black, font: "Times New Roman"),
        WidgetModel.init(size: WidgetModel.SizeMode.SMALL, color: Color.green, font: "Georgia"),
        WidgetModel.init(size: WidgetModel.SizeMode.SMALL, color: Color.lightPink, font: "Helvetica")
    ]
    
    init() {
        self.stagedWidget = allWidgets[0]
    }
    
    private let currentFortune: String = "Fortune will soon find you, just wait"
    
    func getFortune() -> String {
        return currentFortune
    }
    
    func newFortune() {
        
    }
    
    func getWidgets(size: WidgetModel.SizeMode) -> [WidgetModel] {
        var widgets = [WidgetModel]()
        
        allWidgets.forEach { widget in
            if (widget.getSize() == size) {
                widgets.append(widget)
            }
        }
        
        return widgets
    }
    
    func stageWidget(widget: WidgetModel) {
        let fromIndex: Int = allWidgets.firstIndex(of: widget) ?? 0
        allWidgets.remove(at: fromIndex)
        allWidgets.insert(widget, at: 0)
        
        stagedWidget = widget
    }
    
    func addWidget(widget: WidgetModel) {
        allWidgets.append(widget)
        stageWidget(widget: widget)
    }
    
    func widgetExists(widget: WidgetModel) -> Bool {
        return allWidgets.contains(widget)
    }
}
