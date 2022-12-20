enum Flavor {
  PRODUCTION,
  STAGING,
}

class F {
  static Flavor? appFlavor;

  static String get name => appFlavor?.name ?? '';

  static String get title {
    switch (appFlavor) {
      case Flavor.PRODUCTION:
        return 'Oulun Energia';
      case Flavor.STAGING:
        return 'Oulun Energia -staging';
      default:
        return 'title';
    }
  }

}
