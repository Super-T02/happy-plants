import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../shared/models/plant.dart';
import '../../../../../shared/models/user.dart';
import '../../../../../shared/widgets/util/custom_cupertino_context_menu.dart';

class PlantSingle extends StatefulWidget {
  const PlantSingle({Key? key, required this.plant}) : super(key: key);

  final Plant plant;

  @override
  State<PlantSingle> createState() => _PlantSingleState();
}

class _PlantSingleState extends State<PlantSingle> {

  /// Opens the garden
  void openGarden(Plant plant, CustomUser user){
    //todo
  }

  /// Opens a form to edit the garden
  void editPlant(String plantId, CustomUser user){
    //Todo
  }

  /// Delete the garden
  void deletePlant(String plantId, CustomUser user) async {
    //todo
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CustomUser?>(context);
    final ThemeData theme = Theme.of(context);

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
                        widget.plant.name,
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
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(widget.plant.name + ' was popup deleted!')));
          }
        ),
      ],
    );



  }
}