//
//  ZoomTransitioningDelegate.swift
//  VK_Nikita
//
//  Created by Никита Троян on 12.10.2021.
//

import UIKit
//протокол, которому должны соответствовать наши контроллеры
protocol ZoomingViewController
{
    func zoomingImageView (for translition: ZoomTransitioningDelegate) -> UIImageView?
    func zoomingBackgroundView (for translition: ZoomTransitioningDelegate) -> UIView?
}

//у каждой анимации существуют два состояния, начальная и результат
enum TransitionState
{
    case initial
    case final
}
// класс в котом описаны состояния анимации, размеры и прозрачность основой imageView и её дупликата
class ZoomTransitioningDelegate: NSObject
{
    var transitionDuration = 0.5
    // три состояния navigationController push, pop, none
    var controller: UINavigationController.Operation = .none
    // насколько увеличется наша фотка
    private let zoomScale = CGFloat(15)
    // насколько уменьшится в переходе задняя view(которая была superView)
    private let backgroundScale = CGFloat(0.5)
    
    // создали тип данных для наших View
    typealias ZoomingViews = (otherView: UIView, imageView: UIView)
    
    func configureView(for state:TransitionState, containerView:UIView, viewInBackground: ZoomingViews, viewInForeground: ZoomingViews, backgroundViewController: UIViewController, viewSnapshot:ZoomingViews)
    {
        
        switch state {
        case .initial:
            //начальное состояние, view на своём месте, непрозрачная
            backgroundViewController.view.transform = CGAffineTransform.identity
            backgroundViewController.view.alpha = 1
            // мы должны создать дупликат нашей imageView, которую будет открывать поверх неё самой, затем спрятать нашу originalView, вывести на передний план дупликат
            
            //здесь мы создаём дупликат, он перенимает frame от viewInBackground
            viewSnapshot.imageView.frame = containerView.convert(viewInBackground.imageView.frame, from: viewInBackground.imageView.superview)
            
            
       
        case .final:
            //к итогу анимации view контроллера увеличивается
            backgroundViewController.view.transform = CGAffineTransform(scaleX: zoomScale, y: zoomScale)
            // потом прорадает
            backgroundViewController.view.alpha = 0
            // а дупликат становится размером с imageView, которая находится на view и ждёт своей инициализации
            viewSnapshot.imageView.frame = containerView.convert(viewInForeground.imageView.frame, from: viewInForeground.imageView.superview)
        }
    }
    
}

extension ZoomTransitioningDelegate: UIViewControllerAnimatedTransitioning
{
    // важный метод, к котором описывается анимация для перехода
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        // MARK: - Описали контроллеры
        let duration = transitionDuration(using: transitionContext)
        // это коллекция фото пользователя
        let fromViewController = transitionContext.viewController(forKey: .from)!
        // это та единственная фото, которая будет во весь экран
        let toViewController = transitionContext.viewController(forKey: .to)!
        // это там superView, которая хранит в себе все данные для отображения
        let containerView = transitionContext.containerView
        
        var backgroundViewController = fromViewController
        var foregroundViewController = toViewController
        
        // MARK: - Описали действие при возвращении
        
        if self.controller == .pop {
            //если мы отыгрываем сценарий, когда обратно возвращаемся на кнопку назад, то экран перед нами это тот с которого мы уходим
            backgroundViewController = toViewController
            //а экран изначальный становится нашим финишом
            foregroundViewController = fromViewController
        }
        
        // MARK: - Описали ImageView которые будут отображаться
        let maybeBackgroundImageView = (backgroundViewController as? ZoomingViewController)?.zoomingImageView(for: self)
        let maybeForegroundImageView = (foregroundViewController as? ZoomingViewController)?.zoomingImageView(for: self)
        
        // если выражение не nil, то всё ок, если нет, то показываем сообщение
        assert(maybeBackgroundImageView != nil, "Cannot find imageView in backgroundVC")
        assert(maybeForegroundImageView != nil, "Cannot find imageView in foreroundVC")
        
        let backgroundImageView = maybeBackgroundImageView!
        let foregroundImageView = maybeForegroundImageView!
        
        let imageViewSnapshot = UIImageView(image: backgroundImageView.image)
        imageViewSnapshot.contentMode = .scaleAspectFill
        imageViewSnapshot.layer.masksToBounds = true
        
        // MARK: - Описали действие начале анимации
        backgroundImageView.isHidden = true
        foregroundImageView.isHidden = true
        
        let foregroundBackgroundColor = foregroundViewController.view.backgroundColor
        foregroundViewController.view.backgroundColor = .clear
        containerView.backgroundColor = .white
        // MARK: - Добавили view в container
        containerView.addSubview(backgroundViewController.view)
        containerView.addSubview(foregroundViewController.view)
        containerView.addSubview(imageViewSnapshot)
        
        var preTransitionalState = TransitionState.initial
        var postTransitionalState = TransitionState.final
        
        if self.controller == .pop {
            preTransitionalState = .final
            postTransitionalState = .initial
        }
        
        configureView(for: preTransitionalState, containerView: containerView, viewInBackground: (backgroundImageView, backgroundImageView), viewInForeground: (foregroundImageView, foregroundImageView), backgroundViewController: backgroundViewController, viewSnapshot: (imageViewSnapshot,imageViewSnapshot))
        
        //если пользователь крутил device нам нужно убедиться, что все constraint на месте, поэтому обновляем autolayout
        foregroundViewController.view.layoutIfNeeded()
        // пишем анимацию, тип пружинный
        UIView.animate(withDuration: duration,
                       delay: 0,
                       usingSpringWithDamping: 1.0,
                       initialSpringVelocity: 0,
                       options: []) {
            //занаво конфигурируем показ view
            self.configureView(for: postTransitionalState, containerView: containerView, viewInBackground: (backgroundImageView, backgroundImageView), viewInForeground: (foregroundImageView, foregroundImageView), backgroundViewController: backgroundViewController, viewSnapshot: (imageViewSnapshot,imageViewSnapshot))
        //возвращаем view в изначальное состояние и удаляем дупликат, показываем нашу увеличившуюся view
        } completion: { (finished) in
            backgroundViewController.view.transform = .identity
            imageViewSnapshot.removeFromSuperview()
            backgroundImageView.isHidden = false
            foregroundImageView.isHidden = false
            foregroundViewController.view.backgroundColor = foregroundBackgroundColor
            
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            
        }

        
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return transitionDuration
    }
    
    
}

extension ZoomTransitioningDelegate: UINavigationControllerDelegate
{
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if fromVC is ZoomingViewController && toVC is ZoomingViewController {
            self.controller = operation
            return self
        } else {
            return nil
        }
    }
    
}
