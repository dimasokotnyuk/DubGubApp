//
//  View+Ext.swift
//  DubDubGrub
//
//  Created by Дмитро Сокотнюк on 20.07.2025.
//

import SwiftUI

extension View {
    func dismissKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil,  from: nil, for: nil)
    }
    
    
    func embedInScrollView() -> some View {
        GeometryReader { geometry in
            ScrollView {
                self.frame(minHeight: geometry.size.height, maxHeight: .infinity)
            }
        }
    }
    
    
}
