//
//  VideoBackgroundView.swift
//  TimeCapsule
//
//  Created by Даниил Иваньков on 18.07.2025.
//
import SwiftUI
import AVFoundation

struct VideoBackgroundView: UIViewControllerRepresentable {
    let videoName: String
    let videoType: String
    var action: () -> Void
    
    func makeUIViewController(context: Context) -> UIViewController {
        let controller = UIViewController()
        let player = AVPlayer(url: Bundle.main.url(forResource: videoName, withExtension: videoType)!)
        
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.videoGravity = .resizeAspectFill // Чтобы видео заполняло экран без черных полос
        
        // Настройки слоя чистого
        playerLayer.frame = UIScreen.main.bounds
        playerLayer.backgroundColor = UIColor.clear.cgColor
        
        // Добавляем слой на контроллер
        controller.view.layer.addSublayer(playerLayer)
        
        // Запускаем видео и звук
        player.play()
        
        // Отслеживаем завершение
        NotificationCenter.default.addObserver(
            forName: .AVPlayerItemDidPlayToEndTime,
            object: player.currentItem,
            queue: .main
        ) { _ in
            action()
        }

        return controller
    }
    
    
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}
