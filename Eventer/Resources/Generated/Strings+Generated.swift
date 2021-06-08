// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {

  internal enum CreateEvent {
    /// Cost, ₽
    internal static let cost = L10n.tr("Localizable", "createEvent.cost")
    /// Create
    internal static let create = L10n.tr("Localizable", "createEvent.create")
    /// Date & Time
    internal static let date = L10n.tr("Localizable", "createEvent.date")
    /// Title image
    internal static let image = L10n.tr("Localizable", "createEvent.image")
    /// Location
    internal static let location = L10n.tr("Localizable", "createEvent.location")
    /// Create event
    internal static let screenTitle = L10n.tr("Localizable", "createEvent.screenTitle")
    /// Title
    internal static let title = L10n.tr("Localizable", "createEvent.title")
    internal enum Success {
      /// You've successfully created event.
      internal static let description = L10n.tr("Localizable", "createEvent.success.description")
      /// Wohoo!
      internal static let title = L10n.tr("Localizable", "createEvent.success.title")
    }
  }

  internal enum Event {
    /// About
    internal static let about = L10n.tr("Localizable", "event.about")
    /// Free
    internal static let free = L10n.tr("Localizable", "event.free")
    /// %i going
    internal static func going(_ p1: Int) -> String {
      return L10n.tr("Localizable", "event.going", p1)
    }
    /// Not going
    internal static let notParticipate = L10n.tr("Localizable", "event.notParticipate")
    /// No visitors
    internal static let noVisitors = L10n.tr("Localizable", "event.noVisitors")
    /// I participate!
    internal static let participate = L10n.tr("Localizable", "event.participate")
    /// Tell your friends about %@ event!
    internal static func share(_ p1: Any) -> String {
      return L10n.tr("Localizable", "event.share", String(describing: p1))
    }
    internal enum Details {
      /// Organizer
      internal static let organizer = L10n.tr("Localizable", "event.details.organizer")
    }
  }

  internal enum EventsList {
    /// Organized
    internal static let organized = L10n.tr("Localizable", "eventsList.organized")
    /// Participate in
    internal static let participateIn = L10n.tr("Localizable", "eventsList.participateIn")
    /// Recommended
    internal static let recommended = L10n.tr("Localizable", "eventsList.recommended")
  }

  internal enum Favorites {
    /// Favorites
    internal static let title = L10n.tr("Localizable", "favorites.title")
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

  internal enum Filter {
    /// Apply
    internal static let apply = L10n.tr("Localizable", "filter.apply")
    /// Reset
    internal static let reset = L10n.tr("Localizable", "filter.reset")
    /// Filters
    internal static let title = L10n.tr("Localizable", "filter.title")
    internal enum Date {
      /// Pick a date
      internal static let choose = L10n.tr("Localizable", "filter.date.choose")
      /// This week
      internal static let thisWeek = L10n.tr("Localizable", "filter.date.thisWeek")
      /// Date
      internal static let title = L10n.tr("Localizable", "filter.date.title")
      /// Today
      internal static let today = L10n.tr("Localizable", "filter.date.today")
      /// Tomorrow
      internal static let tomorrow = L10n.tr("Localizable", "filter.date.tomorrow")
    }
    internal enum Location {
      /// Current location
      internal static let current = L10n.tr("Localizable", "filter.location.current")
      /// Other
      internal static let other = L10n.tr("Localizable", "filter.location.other")
      /// Location
      internal static let title = L10n.tr("Localizable", "filter.location.title")
    }
    internal enum Price {
      /// From
      internal static let from = L10n.tr("Localizable", "filter.price.from")
      /// Price
      internal static let title = L10n.tr("Localizable", "filter.price.title")
      /// To
      internal static let to = L10n.tr("Localizable", "filter.price.to")
    }
    internal enum TimeOfDay {
      /// Day
      internal static let day = L10n.tr("Localizable", "filter.timeOfDay.day")
      /// Evening
      internal static let evening = L10n.tr("Localizable", "filter.timeOfDay.evening")
      /// Morning
      internal static let morning = L10n.tr("Localizable", "filter.timeOfDay.morning")
      /// Night
      internal static let night = L10n.tr("Localizable", "filter.timeOfDay.night")
      /// Time of day
      internal static let title = L10n.tr("Localizable", "filter.timeOfDay.title")
    }
  }

  internal enum General {
    /// Cancel
    internal static let cancel = L10n.tr("Localizable", "general.cancel")
    /// OK
    internal static let ok = L10n.tr("Localizable", "general.ok")
  }

  internal enum PickLocation {
    /// Accept
    internal static let accept = L10n.tr("Localizable", "pickLocation.accept")
    /// Cancel
    internal static let cancel = L10n.tr("Localizable", "pickLocation.cancel")
    /// Pick location
    internal static let title = L10n.tr("Localizable", "pickLocation.title")
  }

  internal enum Profile {
    /// Sign Out
    internal static let logout = L10n.tr("Localizable", "profile.logout")
    internal enum Avatar {
      /// Name
      internal static let name = L10n.tr("Localizable", "profile.avatar.name")
      /// Rating
      internal static let rating = L10n.tr("Localizable", "profile.avatar.rating")
      internal enum Name {
        /// No name
        internal static let `default` = L10n.tr("Localizable", "profile.avatar.name.default")
      }
      internal enum Rating {
        /// %.2f stars
        internal static func stars(_ p1: Float) -> String {
          return L10n.tr("Localizable", "profile.avatar.rating.stars", p1)
        }
      }
    }
    internal enum Events {
      /// Organized
      internal static let organized = L10n.tr("Localizable", "profile.events.organized")
      /// Participate in
      internal static let participate = L10n.tr("Localizable", "profile.events.participate")
      /// Recommendations
      internal static let recommendations = L10n.tr("Localizable", "profile.events.recommendations")
    }
    internal enum Info {
      /// About
      internal static let about = L10n.tr("Localizable", "profile.info.about")
      /// Terms of Use
      internal static let termsOfUse = L10n.tr("Localizable", "profile.info.termsOfUse")
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
