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
    Image imageAsWidget = Image.asset(
      stringOfImageName,
      fit: BoxFit.cover,
    );
    //check if string of filename is known, if yes paste it in path
    if(Garden.checkItemName(widget.garden.icon)) {
      stringOfImageName =
      'assets/images/garden_backgrounds/${widget.garden.icon}.jpg';
      //try to access picture in path created
      try {
        imageAsWidget = Image.asset(
          stringOfImageName,
          fit: BoxFit.cover,
        );
      } catch (e) {
        imageAsWidget = Image.asset(
          'assets/images/garden_backgrounds/one.jpg',
          fit: BoxFit.cover,
        );
      }
    }
    else{
      imageAsWidget = Image.asset(
        'assets/images/garden_backgrounds/one.jpg',
        fit: BoxFit.cover,
      );
    }

    return GestureDetector(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(widget.garden.name + ' was clicked!')),
        );
      },
      child: Card(
        margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        //Todo: not working yet :D (wird überschrieben von irgendwas)
        shape: BeveledRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        color: Colors.white,
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 200.0,
              child: Stack(
                children: <Widget>[
                  Positioned.fill(
                    child: imageAsWidget
                  ),
                  Positioned(
                    bottom: 16.0,
                    left: 16.0,
                    right: 16.0,
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.centerLeft,
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
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      )
    );
  }
}
