import 'package:flutter/material.dart';
import 'package:happy_plants/services/util_service.dart';
import 'package:happy_plants/screens/home/tabs/garden/plants/view_plant.dart';
import 'package:provider/provider.dart';
import '../../../../../config.dart';
import '../../../../../services/plant.dart';
import '../../../../../shared/models/garden.dart';
import '../../../../../shared/models/plant.dart';
import '../../../../../shared/models/user.dart';
import '../../../../../shared/widgets/util/custom_cupertino_context_menu.dart';
import '../../../../../shared/widgets/util/image_card.dart';
import 'edit_plant.dart';

class PlantSingle extends StatefulWidget {
  const PlantSingle({Key? key, required this.plant, required this.garden})
      : super(key: key);

  final Plant plant;
  final Garden garden;

  @override
  State<PlantSingle> createState() => _PlantSingleState();
}

class _PlantSingleState extends State<PlantSingle> {
  bool longPress = false;

  /// Opens the garden
  void openPlant(Plant plant, CustomUser user) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                ViewPlant(user: user, garden: widget.garden, plant: plant)));
  }

  /// Delete the garden
  void deletePlant(Plant plant, String gardenID, CustomUser user) async {
    Navigator.of(context).pop();
    await PlantService.deletePlant(plant.id, gardenID, user);

    UtilService.showSuccess('Deleted', '${plant.name} deleted successfully!');
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CustomUser?>(context);
    final ThemeData theme = Theme.of(context);

    widget.plant.icon ??= 'bonsai';
    String stringOfImageName = 'assets/images/plant_backgrounds/bonsai.jpg';
    AssetImage imageAsWidget = AssetImage(stringOfImageName);

    //check if string of filename is known, if yes paste it in path
    if (Plant.checkItemName(widget.plant.icon)) {
      stringOfImageName =
          'assets/images/plant_backgrounds/${widget.plant.icon}.jpg'; // Selected picture

      try {
        //try to access picture in path created
        imageAsWidget = AssetImage(stringOfImageName);
      } catch (e) {
        imageAsWidget = const AssetImage(
            'assets/images/plant_backgrounds/cactus.jpg'); // One
      }
    } else {
      imageAsWidget =
          const AssetImage('assets/images/plant_backgrounds/bonsai.jpg'); // One
    }

    return CustomCupertinoContextMenu(
      // Handles gestures
      child: GestureDetector(
        onTap: () {
          if (!longPress) {
            openPlant(widget.plant, user!);
          }
        },

        onLongPressStart: (details) {
          longPress = true;
          Future.delayed(const Duration(seconds: 3), () {
            longPress = false;
          });
        },

        onLongPressEnd: (details) {
          longPress = false;
        },

        // Initial Card definition
        child: Card(
            semanticContainer: true,
            margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0)),
            child: Container(
              height: 200,
              width: 200,

              // Image for the background of the card
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                image: DecorationImage(image: imageAsWidget, fit: BoxFit.cover),
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
                  )),
            )),
      ),

      // Actions to perform on long press
      actionItems: <CustomCupertinoContextMenuAction>[
        CustomCupertinoContextMenuAction(
          text: "Open",
          color: Theme.of(context).textTheme.bodyText1!.color!,
          icon: Icons.open_in_new_outlined,
          onPressed: () {
            Navigator.of(context).pop();
            openPlant(widget.plant, user!);
          },
        ),
        CustomCupertinoContextMenuAction(
          text: "Edit",
          color: Theme.of(context).textTheme.bodyText1!.color!,
          icon: Icons.edit_outlined,
          onPressed: () {
            if (utilServiceConfig.plantOpen) {
              Navigator.pop(context);
            }
            Navigator.of(context).pop();
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => EditPlant(
                        user: user!,
                        garden: widget.garden,
                        plant: widget.plant)));
          },
        ),
        CustomCupertinoContextMenuAction(
            text: "Delete",
            color: theme.errorColor,
            icon: Icons.delete_outlined,
            onPressed: () {
              if (utilServiceConfig.plantOpen) {
                Navigator.pop(context);
              }
              deletePlant(widget.plant, widget.garden.id, user!);
            }),
      ],
    );
  }
}
