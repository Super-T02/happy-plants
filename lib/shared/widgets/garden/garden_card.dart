import 'package:flutter/material.dart';
import 'package:happy_plants/services/garden.dart';
import 'package:happy_plants/shared/models/garden.dart';
import 'package:provider/provider.dart';
import '../../models/user.dart';
import '../util/custom_cupertino_context_menu.dart';

class GardenSingle extends StatefulWidget {
  const GardenSingle({Key? key, required this.garden}) : super(key: key);

  final Garden garden;

  @override
  State<GardenSingle> createState() => _GardenSingleState();
}

class _GardenSingleState extends State<GardenSingle> {

  /// Opens the garden
  void openGarden(String gardenId, CustomUser user){
    //Todo
  }

  /// Opens a form to edit the garden
  void editGarden(String gardenId, CustomUser user){
    //Todo
  }

  /// Delete the garden
  void deleteGarden(String gardenId, CustomUser user) async {

    Navigator.pop(context);
    await GardenService.deleteGarden(gardenId, user);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Deleted')), // TODO: refresh
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CustomUser?>(context);
    final ThemeData theme = Theme.of(context);

    String stringOfImageName = 'assets/images/garden_backgrounds/one.jpg';
    AssetImage imageAsWidget = AssetImage(stringOfImageName);

    //check if string of filename is known, if yes paste it in path
    if(Garden.checkItemName(widget.garden.icon)) {
      stringOfImageName = 'assets/images/garden_backgrounds/${widget.garden.icon}.jpg'; // Selected picture

      try {//try to access picture in path created
        imageAsWidget = AssetImage(stringOfImageName);
      } catch (e) {
        imageAsWidget = const AssetImage('assets/images/garden_backgrounds/one.jpg'); // One
      }
    }
    else{
      imageAsWidget = const AssetImage('assets/images/garden_backgrounds/one.jpg'); // One
    }

    return CustomCupertinoContextMenu(

      // Handles gestures
      child: GestureDetector(
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(widget.garden.name + ' was clicked!')),
          );
        },

        // Initial Card definition
        child: Card(
          semanticContainer: true,
          margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
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
                )
            ),

            // Text on displayed on the card
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 0, 16),
              child: FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.bottomLeft,
              child: Card(
                color: Colors.black45,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: Text(
                  widget.garden.name,
                  softWrap: true,
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
              SnackBar(content: Text(widget.garden.id + ' was popup Opened!')));
        },
      ),
      CustomCupertinoContextMenuAction(
        text: "Edit",
        color: Colors.black,
        icon: Icons.edit_outlined,
        onPressed: (){
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(widget.garden.id + ' was popup Modified!')));
        },
      ),
      CustomCupertinoContextMenuAction(
        text: "Delete",
        color: theme.errorColor,
        icon: Icons.delete_outlined,
        onPressed: () => deleteGarden(widget.garden.id, user!), // TODO: Error handling
      ),
    ],
  );



  }
}

