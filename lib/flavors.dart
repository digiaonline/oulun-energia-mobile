enum Flavor {
  production,
  staging,
  dev,
}

class F {
  static Flavor? appFlavor;

  static String get name => appFlavor?.name ?? '';

  static String get title {
    switch (appFlavor) {
      case Flavor.production:
        return 'Oulun Energia';
      case Flavor.staging:
        return 'Oulun Energia -staging';
      case Flavor.dev:
        return 'Oulun Energia -dev';
      default:
        return 'title';
    }
  }

  static String get apiUsername {
    switch (appFlavor) {
      case Flavor.dev:
      case Flavor.staging:
      case Flavor.production:
      default:
        return 'oe_app';
    }
  }

  static String get apiPassword {
    switch (appFlavor) {
      case Flavor.dev:
      case Flavor.staging:
      case Flavor.production:
      default:
        return '9d1d5K8inM7774ji0m';
    }
  }

  static String get baseUrl {
    switch (appFlavor) {
      case Flavor.dev:
      case Flavor.staging:
      case Flavor.production:
      default:
        return 'https://app.oulunenergia.fi';
    }
  }
}
