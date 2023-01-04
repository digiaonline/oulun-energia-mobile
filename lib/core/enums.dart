enum UsageInterval { hour, day, month, year }

enum UsageType { electric, districtHeating, missing }

enum StatusCode { missing, measured, approximated }

enum UsageViews { home, usage, interruptions, contact }

enum MyUsageViews { main, info, settings }

enum LoggedInStatus {
  notInitialized,
  failed,
  loggedIn,
  loggedOut,
  visitor,
}
