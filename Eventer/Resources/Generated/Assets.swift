// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

#if os(macOS)
  import AppKit
#elseif os(iOS)
  import UIKit
#elseif os(tvOS) || os(watchOS)
  import UIKit
#endif

// Deprecated typealiases
@available(*, deprecated, renamed: "ColorAsset.Color", message: "This typealias will be removed in SwiftGen 7.0")
internal typealias AssetColorTypeAlias = ColorAsset.Color
@available(*, deprecated, renamed: "ImageAsset.Image", message: "This typealias will be removed in SwiftGen 7.0")
internal typealias AssetImageTypeAlias = ImageAsset.Image

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Asset Catalogs

// swiftlint:disable identifier_name line_length nesting type_body_length type_name
internal enum Asset {
  internal enum Colors {
    internal static let black = ColorAsset(name: "Black")
    internal static let darkViolet = ColorAsset(name: "DarkViolet")
    internal static let gray = ColorAsset(name: "Gray")
    internal static let lightLavender = ColorAsset(name: "LightLavender")
    internal static let shadow = ColorAsset(name: "Shadow")
    internal static let white = ColorAsset(name: "White")
  }
  internal static let crown = ImageAsset(name: "Crown")
  internal static let eventDefault = ImageAsset(name: "EventDefault")
  internal static let profileDefault = ImageAsset(name: "ProfileDefault")
  internal static let sadSmile = ImageAsset(name: "SadSmile")
  internal enum SelectedTabBars {
    internal static let selectedCreateEvent = ImageAsset(name: "SelectedCreateEvent")
    internal static let selectedFavourites = ImageAsset(name: "SelectedFavourites")
    internal static let selectedFeeds = ImageAsset(name: "SelectedFeeds")
    internal static let selectedMap = ImageAsset(name: "SelectedMap")
    internal static let selectedProfile = ImageAsset(name: "SelectedProfile")
  }
  internal enum TabBars {
    internal static let createEvent = ImageAsset(name: "CreateEvent")
    internal static let favourites = ImageAsset(name: "Favourites")
    internal static let feeds = ImageAsset(name: "Feeds")
    internal static let map = ImageAsset(name: "Map")
    internal static let profile = ImageAsset(name: "Profile")
  }
  internal enum UIKit {
    internal enum Event {
      internal static let calendar = ImageAsset(name: "calendar")
      internal static let compass = ImageAsset(name: "compass")
      internal static let ticket = ImageAsset(name: "ticket")
    }
    internal enum LikeButton {
      internal static let likeButton = ImageAsset(name: "LikeButton")
      internal static let selectedLikeButton = ImageAsset(name: "SelectedLikeButton")
    }
    internal enum SelectedTagsImages {
      internal static let selectedArt = ImageAsset(name: "SelectedArt")
      internal static let selectedCinema = ImageAsset(name: "SelectedCinema")
      internal static let selectedEducation = ImageAsset(name: "SelectedEducation")
      internal static let selectedFood = ImageAsset(name: "SelectedFood")
      internal static let selectedMusic = ImageAsset(name: "SelectedMusic")
      internal static let selectedPrivate = ImageAsset(name: "SelectedPrivate")
      internal static let selectedPublic = ImageAsset(name: "SelectedPublic")
      internal static let selectedSociety = ImageAsset(name: "SelectedSociety")
      internal static let selectedSport = ImageAsset(name: "SelectedSport")
    }
    internal enum TagsImages {
      internal static let art = ImageAsset(name: "Art")
      internal static let cinema = ImageAsset(name: "Cinema")
      internal static let education = ImageAsset(name: "Education")
      internal static let food = ImageAsset(name: "Food")
      internal static let music = ImageAsset(name: "Music")
      internal static let society = ImageAsset(name: "Society")
      internal static let sport = ImageAsset(name: "Sport")
      internal static let unselPrivate = ImageAsset(name: "UnselPrivate")
      internal static let unselPublic = ImageAsset(name: "UnselPublic")
    }
    internal static let filter = ImageAsset(name: "filter")
    internal static let searchGlass = ImageAsset(name: "search_glass")
    internal static let share = ImageAsset(name: "share")
    internal static let star = ImageAsset(name: "star")
  }
}
// swiftlint:enable identifier_name line_length nesting type_body_length type_name

// MARK: - Implementation Details

internal final class ColorAsset {
  internal fileprivate(set) var name: String

  #if os(macOS)
  internal typealias Color = NSColor
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  internal typealias Color = UIColor
  #endif

  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, *)
  internal private(set) lazy var color: Color = {
    guard let color = Color(asset: self) else {
      fatalError("Unable to load color asset named \(name).")
    }
    return color
  }()

  fileprivate init(name: String) {
    self.name = name
  }
}

internal extension ColorAsset.Color {
  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, *)
  convenience init?(asset: ColorAsset) {
    let bundle = BundleToken.bundle
    #if os(iOS) || os(tvOS)
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    self.init(named: NSColor.Name(asset.name), bundle: bundle)
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

internal struct ImageAsset {
  internal fileprivate(set) var name: String

  #if os(macOS)
  internal typealias Image = NSImage
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  internal typealias Image = UIImage
  #endif

  internal var image: Image {
    let bundle = BundleToken.bundle
    #if os(iOS) || os(tvOS)
    let image = Image(named: name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    let name = NSImage.Name(self.name)
    let image = (bundle == .main) ? NSImage(named: name) : bundle.image(forResource: name)
    #elseif os(watchOS)
    let image = Image(named: name)
    #endif
    guard let result = image else {
      fatalError("Unable to load image asset named \(name).")
    }
    return result
  }
}

internal extension ImageAsset.Image {
  @available(macOS, deprecated,
    message: "This initializer is unsafe on macOS, please use the ImageAsset.image property")
  convenience init?(asset: ImageAsset) {
    #if os(iOS) || os(tvOS)
    let bundle = BundleToken.bundle
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    self.init(named: NSImage.Name(asset.name))
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
