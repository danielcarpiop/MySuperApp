import UIKit

extension UIButton {
    func animate() {
        let originalPosition = self.center
        let offset: CGFloat = 5
        
        UIView.animateKeyframes(withDuration: 0.3, delay: 0, options: [], animations: {
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.05) {
                self.center = CGPoint(x: originalPosition.x - offset, y: originalPosition.y)
            }
            UIView.addKeyframe(withRelativeStartTime: 0.05, relativeDuration: 0.05) {
                self.center = CGPoint(x: originalPosition.x + offset, y: originalPosition.y)
            }
            UIView.addKeyframe(withRelativeStartTime: 0.1, relativeDuration: 0.05) {
                self.center = CGPoint(x: originalPosition.x - offset, y: originalPosition.y)
            }
            UIView.addKeyframe(withRelativeStartTime: 0.15, relativeDuration: 0.05) {
                self.center = CGPoint(x: originalPosition.x + offset, y: originalPosition.y)
            }
            UIView.addKeyframe(withRelativeStartTime: 0.2, relativeDuration: 0.05) {
                self.center = CGPoint(x: originalPosition.x - offset, y: originalPosition.y)
            }
            UIView.addKeyframe(withRelativeStartTime: 0.25, relativeDuration: 0.05) {
                self.center = originalPosition
            }
        }, completion: { _ in
            self.center = originalPosition
        })
    }
    
    func addAnimation() {
        self.addTarget(self, action: #selector(performClickAnimation), for: .touchUpInside)
    }
    
    @objc private func performClickAnimation() {
        self.animate()
    }
}
