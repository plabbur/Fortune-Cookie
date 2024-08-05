//
//  FortuneCookieModel.swift
//  Fortune Cookie
//
//  Created by Cole Abrams on 8/1/24.
//

import Foundation
import SwiftUI

class FortuneCookieModel: ObservableObject {
    @Published var stagedWidget: WidgetModel = WidgetModel(size: WidgetModel.sizeMode.MEDIUM, color: Color.red)
    var allWidgets: [WidgetModel] = [
        WidgetModel.init(size: WidgetModel.sizeMode.MEDIUM, color: Color.darkBlue),
        WidgetModel.init(size: WidgetModel.sizeMode.MEDIUM, color: Color.yellow),
        WidgetModel.init(size: WidgetModel.sizeMode.MEDIUM, color: Color.red),
        WidgetModel.init(size: WidgetModel.sizeMode.MEDIUM, color: Color.gray),
        WidgetModel.init(size: WidgetModel.sizeMode.SMALL, color: Color.black),
        WidgetModel.init(size: WidgetModel.sizeMode.SMALL, color: Color.green),
        WidgetModel.init(size: WidgetModel.sizeMode.SMALL, color: Color.lightPink),
    ]
    
    init(stagedWidget: WidgetModel) {
        self.stagedWidget = allWidgets[0]
    }
    
    private let currentFortune: String = "Fortune will soon find you, just wait"
    
    func getFortune() -> String {
        return currentFortune
    }
    
    func newFortune() {
        
    }
    
    func getWidgets(size: WidgetModel.sizeMode) -> [WidgetModel] {
        
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
}
