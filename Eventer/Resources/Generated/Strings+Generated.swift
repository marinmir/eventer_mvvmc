// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {

  internal enum Event {
    /// About
    internal static let about = L10n.tr("Localizable", "event.about")
    /// Free
    internal static let free = L10n.tr("Localizable", "event.free")
    /// %i going
    internal static func going(_ p1: Int) -> String {
      return L10n.tr("Localizable", "event.going", p1)
    }
    /// No visitors
    internal static let noVisitors = L10n.tr("Localizable", "event.noVisitors")
    internal enum Details {
      /// Organizer
      internal static let organizer = L10n.tr("Localizable", "event.details.organizer")
    }
  }

  internal enum Feeds {
    /// Getting new events...
    internal static let refreshTitle = L10n.tr("Localizable", "feeds.refresh_title")
    internal enum Sections {
      /// Popular
      internal static let popular = L10n.tr("Localizable", "feeds.sections.popular")
      /// Promoted
      internal static let promoted = L10n.tr("Localizable", "feeds.sections.promoted")
      /// This weekend
      internal static let thisWeekend = L10n.tr("Localizable", "feeds.sections.thisWeekend")
    }
  }

  internal enum Search {
    /// Search for...
    internal static let placeholder = L10n.tr("Localizable", "search.placeholder")
  }

  internal enum Tags {
    /// Art
    internal static let art = L10n.tr("Localizable", "tags.art")
    /// Cinema
    internal static let cinema = L10n.tr("Localizable", "tags.cinema")
    /// Food
    internal static let food = L10n.tr("Localizable", "tags.food")
    /// Music
    internal static let music = L10n.tr("Localizable", "tags.music")
    /// Society
    internal static let society = L10n.tr("Localizable", "tags.society")
    /// Sport
    internal static let sport = L10n.tr("Localizable", "tags.sport")
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: nil, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
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
