class FlavorConfig {
  static late final FlavorEnum _flavor;

  static FlavorEnum get flavor => _flavor;

  static void setFlavor(FlavorEnum f) => _flavor = f;
}

enum FlavorEnum { dev, prod }
