
///Model for a garden
class Garden{
  String name;
  String? icon;
  String? id;

  Garden({required this.name, this.icon, this.id});

  checkItemName(){
    List<String> allFiles = ['one','two','three','four','five','six','seven','eight','nine','ten','eleven','twelve'];
    if(allFiles.contains(icon)){
      return true;
    }
    else{
      return false;
    }
  }
}