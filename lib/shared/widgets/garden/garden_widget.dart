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
    return Card(
      color: Theme.of(context).bottomAppBarColor,
      elevation: 10.0,
      child: SizedBox(
        child: Column( //Todo: center this shit
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //icon
            Text(
                widget.garden.icon!,
                style: TextStyle(
                    fontFamily: 'MaterialIcons',
                    fontSize: 100,
                    color: Theme.of(context).textTheme.bodyText1?.color,
                )
            ),
            //Text (label for icon)
            Expanded(child:
              Text(
                  widget.garden.name,
                  style: TextStyle(
                      fontSize: 20,
                      color: Theme.of(context).textTheme.bodyText1?.color
                  )
              )
            )
          ],
        ),
      ),
    );
  }
}

