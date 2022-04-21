import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../services/plant.dart';
import '../../../../../shared/models/garden.dart';
import '../../../../../shared/models/plant.dart';
import '../../../../../shared/models/user.dart';
import '../../../../../shared/widgets/util/custom_cupertino_context_menu.dart';
import '../../../../../shared/widgets/util/image_card.dart';

class PlantSingle extends StatefulWidget {
  const PlantSingle({Key? key, required this.plant, required this.garden}) : super(key: key);

  final Plant plant;
  final Garden garden;

  @override
  State<PlantSingle> createState() => _PlantSingleState();
}

class _PlantSingleState extends State<PlantSingle> {
  /// Opens the garden
  void openPlant(Plant plant, CustomUser user){
    //todo
  }

  /// Opens a form to edit the garden
  void editPlant(String plantId, CustomUser user){
    //Todo
  }

  /// Delete the garden
  void deletePlant(String plantId, String gardenID, CustomUser user) async {
    Navigator.of(context).pop();
    await PlantService.deletePlant(plantId, gardenID, user);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Deleted')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CustomUser?>(context);
    final ThemeData theme = Theme.of(context);

    widget.plant.icon ??= 'grass_outlined';
    String stringOfImageName = 'assets/images/garden_backgrounds/one.jpg';
    AssetImage imageAsWidget = AssetImage(stringOfImageName);

    //check if string of filename is known, if yes paste it in path
    if(Plant.checkItemName(widget.plant.icon)) {
      stringOfImageName = 'assets/images/plant_backgrounds/${widget.plant.icon}.jpg'; // Selected picture

      try {//try to access picture in path created
        imageAsWidget = AssetImage(stringOfImageName);
      } catch (e) {
        imageAsWidget = const AssetImage('assets/images/plant_backgrounds/cactus.jpg'); // One
      }
    }
    else{
      imageAsWidget = const AssetImage('assets/images/plant_backgrounds/bonsai.jpg'); // One
    }

    return CustomCupertinoContextMenu(

      // Handles gestures
      child: GestureDetector(
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(widget.plant.name + ' was popup Modified!')));
        },

        // Initial Card definition
        child: Card(
            semanticContainer: true,
            margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0)
            ),
            child: Container(
              height: 200,
              width: 200,

              // Image for the background of the card
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  image: DecorationImage(
                      image: imageAsWidget,
                      fit: BoxFit.cover
                ),
              ),

              // Text on displayed on the card
              child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 0, 16),
                  child: FittedBox(
                    fit: BoxFit.none,
                    alignment: Alignment.bottomLeft,
                    clipBehavior: Clip.hardEdge,
                    child: Card(
                      color: Colors.black45,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: Text(
                        widget.plant.name,
                        overflow: TextOverflow.ellipsis,
                        softWrap: true,
                        maxLines: 1,
                        style: Theme.of(context).textTheme.headline5!.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )
              ),
            )
        ),
      ),


      // Actions to perform on long press
      actionItems: <CustomCupertinoContextMenuAction>[
        CustomCupertinoContextMenuAction(
          text: "Open",
          color: Colors.black,
          icon: Icons.open_in_new_outlined,
          onPressed: (){
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(widget.plant.name + ' was popup Opened!')));
          },
        ),
        CustomCupertinoContextMenuAction(
          text: "Edit",
          color: Colors.black,
          icon: Icons.edit_outlined,
          onPressed: (){
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(widget.plant.name + ' was popup Modified!')));
          },
        ),
        CustomCupertinoContextMenuAction(
          text: "Delete",
          color: theme.errorColor,
          icon: Icons.delete_outlined,
          onPressed: (){
            deletePlant(widget.plant.id, widget.garden.id, user!);
          }
        ),
      ],
    );
  }
}