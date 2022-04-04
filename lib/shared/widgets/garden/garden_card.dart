import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:happy_plants/shared/models/garden.dart';

class GardenSingle extends StatefulWidget {
  const GardenSingle({Key? key, required this.garden}) : super(key: key);

  final Garden garden;

  @override
  State<GardenSingle> createState() => _GardenSingleState();
}

class _GardenSingleState extends State<GardenSingle> {
  @override
  Widget build(BuildContext context) {
    var stringOfImageName = 'assets/images/garden_backgrounds/one.jpg';
    AssetImage imageAsWidget = AssetImage(
      stringOfImageName,
    );
    //check if string of filename is known, if yes paste it in path
    if(Garden.checkItemName(widget.garden.icon)) {
      stringOfImageName =
      'assets/images/garden_backgrounds/${widget.garden.icon}.jpg';
      //try to access picture in path created
      try {
        imageAsWidget = AssetImage(stringOfImageName);
      } catch (e) {
        imageAsWidget = const AssetImage('assets/images/garden_backgrounds/one.jpg');
      }
    }
    else{
      imageAsWidget = const AssetImage('assets/images/garden_backgrounds/one.jpg');
    }

    return CupertinoContextMenu(
        child: GestureDetector(
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(widget.garden.name + ' was clicked!')),
              );
            },
            child:  Card(
                semanticContainer: true,
                margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0)
                ),
                //Todo: not working yet :D (wird überschrieben von irgendwas)
                child: Container(
                  height: 200,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      image: DecorationImage(
                          image: imageAsWidget,
                          fit: BoxFit.cover
                      )
                  ),
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
        actions: <Widget>[
          CupertinoContextMenuAction(
            child: const Text("Delete Garden"),
            onPressed: (){
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(widget.garden.id + ' was popup deleted!')));
            },
          ),
        ],
    );



  }
}

