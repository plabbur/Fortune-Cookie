//
//  FortuneCookieModel.swift
//  Fortune Cookie
//
//  Created by Cole Abrams on 8/1/24.
//

import Foundation
import SwiftUI

class FortuneCookieModel: ObservableObject {
    @Published var stagedWidget: WidgetModel = WidgetModel(size: WidgetModel.SizeMode.MEDIUM, color: Color.red)
    @Published var allWidgets: [WidgetModel] = [
        WidgetModel.init(size: WidgetModel.SizeMode.MEDIUM, color: Color.darkBlue),
        WidgetModel.init(size: WidgetModel.SizeMode.MEDIUM, color: Color.yellow),
        WidgetModel.init(size: WidgetModel.SizeMode.MEDIUM, color: Color.red),
        WidgetModel.init(size: WidgetModel.SizeMode.MEDIUM, color: Color.gray),
        WidgetModel.init(size: WidgetModel.SizeMode.SMALL, color: Color.black),
        WidgetModel.init(size: WidgetModel.SizeMode.SMALL, color: Color.green),
        WidgetModel.init(size: WidgetModel.SizeMode.SMALL, color: Color.lightPink)
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
    }
}
