//
//  ContentView.swift
//  TwitterLongPress
//
//  Created by Josh Nelson on 6/1/22.
//

import SwiftUI

// Set up haptics

class HapticManager {
    static let instance = HapticManager()
    
    func notif(type: UINotificationFeedbackGenerator.FeedbackType) {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(type)
    }
    
    func impact(style: UIImpactFeedbackGenerator.FeedbackStyle) {
        let generator = UIImpactFeedbackGenerator(style: style)
        generator.impactOccurred()
    }
}


struct ContentView: View {
    
    @State var isSuccess = false
    
    @GestureState var press = false
    
    var body: some View {
        
        // Creating ZStack to align Button
        
        ZStack(alignment: .bottomTrailing) {
            
            // Made a rectangle so the button would align lol
            
            VStack {
                Rectangle()
                .foregroundColor(.white)
                
            }
            
            // Stacking the three actions below the primary button
            
            Image(systemName: "pencil")
                .rotationEffect(Angle(degrees: isSuccess ? 0 : -90))
                .font(.title2)
                .foregroundColor(.white)
                .frame(width: 52, height: 52)
                .background(Color.blue)
                .clipShape(Circle())
                .scaleEffect(isSuccess ? 1 : 0.5)
                .shadow(color: .black.opacity(0.2), radius: 4.0)
                .offset(x: isSuccess ? -12 : 0, y: isSuccess ? -120 : 0)
                .animation(Animation.spring(response: 0.25, dampingFraction: 0.65), value: isSuccess)
            
            Image(systemName: "photo.fill")
                .rotationEffect(Angle(degrees: isSuccess ? 0 : -90))
                .font(.title2)
                .foregroundColor(.white)
                .frame(width: 52, height: 52)
                .background(Color.blue)
                .clipShape(Circle())
                .scaleEffect(isSuccess ? 1 : 0.5)
                .shadow(color: .black.opacity(0.2), radius: 4.0)
                .offset(x: isSuccess ? -80 : 0, y: isSuccess ? -80 : 0)
                .animation(Animation.spring(response: 0.25, dampingFraction: 0.65), value: isSuccess)
            
            Image(systemName: "mic.fill")
                .rotationEffect(Angle(degrees: isSuccess ? 0 : -90))
                .font(.title2)
                .foregroundColor(.white)
                .frame(width: 52, height: 52)
                .background(Color.purple)
                .clipShape(Circle())
                .scaleEffect(isSuccess ? 1 : 0.5)
                .shadow(color: .black.opacity(0.2), radius: 4.0)
                .offset(x: isSuccess ? -120 : 0, y: isSuccess ? -12 : 0)
                .animation(Animation.spring(response: 0.25, dampingFraction: 0.65), value: isSuccess)
            
            // Plus icons
            
            Image(systemName: "plus")
                .opacity(isSuccess ? 0 : 1)
                .rotationEffect(Angle(degrees: isSuccess ? 45 : 0))
                .font(.title2)
                .foregroundColor(isSuccess ? .blue : .white)
                .frame(width: 56, height: 56)
                .background(isSuccess ? Color.white : Color.blue)
                .clipShape(Circle())
                .scaleEffect(press || isSuccess ? 0.8 : 1)
                .shadow(color: .black.opacity(0.2), radius: 4.0)
                .gesture(
                    LongPressGesture(minimumDuration: 1.0)
                        .updating($press) { currentState, gestureState, transaction in
                                gestureState = currentState
                        }
                        .onEnded { value in
                            isSuccess.toggle()
                            HapticManager.instance.notif(type: .success)
                        }
                
                )
                .animation(Animation.easeInOut(duration: 0.3), value: isSuccess)
                .animation(Animation.easeInOut(duration: 0.3), value: press)
            
            // Created a second plus icon that overtakes the primary one so that I could 'tap' instead of long pressing to reset the button (there's definitely a better way to do this lol)
            
            Image(systemName: "plus")
                .rotationEffect(Angle(degrees: 45))
                .font(.title2)
                .frame(width: 56, height: 56)
                .foregroundColor(Color.blue)
                .background(.white)
                .clipShape(Circle())
                .scaleEffect(0.8)
                .shadow(color: .black.opacity(0.2), radius: 4.0)
                .opacity(isSuccess ? 1 : 0)
                .animation(Animation.easeInOut(duration: 0.3), value: isSuccess)
                .onTapGesture {
                    isSuccess = false
                    
                }
                
        }
        .padding(24)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
