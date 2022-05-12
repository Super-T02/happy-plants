enum Sizes { extraSmall, small, medium, large, extraLarge }

class SizeHelper {
  static Sizes? getSizeFromString(String? text) {
    switch (text) {
      case 'xs':
        return Sizes.extraSmall;
      case 's':
        return Sizes.small;
      case 'm':
        return Sizes.medium;
      case 'l':
        return Sizes.large;
      case 'xl':
        return Sizes.extraLarge;
      default:
        return null;
    }
  }

  static String? getStringFromSize(Sizes? size) {
    switch (size) {
      case Sizes.extraSmall:
        return 'xs';
      case Sizes.small:
        return 's';
      case Sizes.medium:
        return 'm';
      case Sizes.large:
        return 'l';
      case Sizes.extraLarge:
        return 'xl';
      default:
        return null;
    }
  }

  static String? getFullNameFromSize(Sizes? size) {
    switch (size) {
      case Sizes.extraSmall:
        return 'extra small';
      case Sizes.small:
        return 'small';
      case Sizes.medium:
        return 'medium';
      case Sizes.large:
        return 'large';
      case Sizes.extraLarge:
        return 'extra large';
      default:
        return null;
    }
  }
}
