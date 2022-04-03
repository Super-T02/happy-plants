
///Model for a garden
class Garden{
  static final List<String> allFiles = ['one','two','three','four','five','six','seven','eight','nine','ten','eleven','twelve'];

  String name;
  String id;
  String? icon;

  Garden({required this.name, required this.id, this.icon});

  static checkItemName(iconName){
    if(allFiles.contains(iconName)){
      return true;
    }
    else{
      return false;
    }
  }
}

class AddGarden{
  String name;
  String? icon;

  AddGarden({required this.name, this.icon});
}