enum Sizes{
  extraSmall,
  small,
  medium,
  large,
  extraLarge
}

class SizeHelper{
  static Sizes? getSizeFromString(String text){
    switch(text) {
      case 'xs': return Sizes.extraSmall;
      case 's': return Sizes.small;
      case 'm': return Sizes.medium;
      case 'l': return Sizes.large;
      case 'xl': return Sizes.extraLarge;
      default: return null;
    }
  }
}