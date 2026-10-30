import UIKit
import Flutter

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
  var window: UIWindow?

  func scene(
    _ scene: UIScene,
    willConnectTo session: UISceneSession,
    options connectionOptions: UIScene.ConnectionOptions
  ) {
    guard
      let windowScene = scene as? UIWindowScene,
      let window = window,
      let flutterViewController = window.rootViewController as? FlutterViewController,
      let appDelegate = UIApplication.shared.delegate as? AppDelegate
    else {
      return
    }

    window.windowScene = windowScene
    appDelegate.window = window
    GeneratedPluginRegistrant.register(with: flutterViewController)

    if !connectionOptions.urlContexts.isEmpty {
      forward(connectionOptions.urlContexts, to: appDelegate)
    }
    for userActivity in connectionOptions.userActivities {
      forward(userActivity, to: appDelegate)
    }
  }

  func sceneDidBecomeActive(_ scene: UIScene) {
    appDelegate?.applicationDidBecomeActive(UIApplication.shared)
  }

  func sceneWillResignActive(_ scene: UIScene) {
    appDelegate?.applicationWillResignActive(UIApplication.shared)
  }

  func sceneWillEnterForeground(_ scene: UIScene) {
    appDelegate?.applicationWillEnterForeground(UIApplication.shared)
  }

  func sceneDidEnterBackground(_ scene: UIScene) {
    appDelegate?.applicationDidEnterBackground(UIApplication.shared)
  }

  func scene(
    _ scene: UIScene,
    openURLContexts URLContexts: Set<UIOpenURLContext>
  ) {
    guard let appDelegate = appDelegate else {
      return
    }

    forward(URLContexts, to: appDelegate)
  }

  func scene(_ scene: UIScene, continue userActivity: NSUserActivity) {
    guard let appDelegate = appDelegate else {
      return
    }

    forward(userActivity, to: appDelegate)
  }

  private func forward(
    _ URLContexts: Set<UIOpenURLContext>,
    to appDelegate: AppDelegate
  ) {
    for context in URLContexts {
      var options: [UIApplication.OpenURLOptionsKey: Any] = [:]
      options[.openInPlace] = context.options.openInPlace
      if let sourceApplication = context.options.sourceApplication {
        options[.sourceApplication] = sourceApplication
      }
      if let annotation = context.options.annotation {
        options[.annotation] = annotation
      }
      _ = appDelegate.application(
        UIApplication.shared,
        open: context.url,
        options: options
      )
    }
  }

  private func forward(_ userActivity: NSUserActivity, to appDelegate: AppDelegate) {
    _ = appDelegate.application(
      UIApplication.shared,
      continue: userActivity,
      restorationHandler: { _ in }
    )
  }

  private var appDelegate: AppDelegate? {
    UIApplication.shared.delegate as? AppDelegate
  }
}
