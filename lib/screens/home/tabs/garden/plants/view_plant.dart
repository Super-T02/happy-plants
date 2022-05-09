import 'package:flutter/material.dart';
import 'package:happy_plants/screens/home/tabs/garden/plants/edit_plant.dart';
import 'package:happy_plants/shared/models/events.dart';
import 'package:happy_plants/shared/models/user.dart';
import 'package:happy_plants/shared/utilities/sizes.dart';
import 'package:happy_plants/shared/widgets/util/lists/custom_list_group.dart';
import 'package:happy_plants/shared/widgets/util/lists/custom_list_row.dart';

import '../../../../../shared/models/garden.dart';
import '../../../../../shared/models/plant.dart';
import '../../../../../shared/utilities/util.dart';

class ViewPlant extends StatefulWidget {
  const ViewPlant({Key? key,
    required this.user,
    required this.garden,
    required this.plant}) : super(key: key);

  final CustomUser user;
  final Garden garden;
  final Plant plant;

  @override
  State<ViewPlant> createState() => _ViewPlantState();
}

class _ViewPlantState extends State<ViewPlant> {
  final GlobalKey _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    Text titleOfPage = Text(widget.plant.name);
    AssetImage imageAsWidget = AssetImage(
        'assets/images/plant_backgrounds/'+widget.plant.icon!+'.jpg');
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: titleOfPage,
        backgroundColor: Theme.of(context).bottomAppBarColor,
        foregroundColor: Theme.of(context).unselectedWidgetColor,
      ),
      body: ListView(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        padding: const EdgeInsets.all(10), //padding from screen to widget
        addAutomaticKeepAlives: true,
        children: <Widget>[
          Card(
            semanticContainer: true,
            margin: const EdgeInsets.fromLTRB(10, 20, 10, 20),
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
            )
          ),

          //List group for name and type
          CustomListGroup(title: 'Name and type', children: <Widget>[
            CustomListRow(title: 'Name', data: widget.plant.name),
            CustomListRow(title: 'Type', data: widget.plant.type)
          ]),

          //List group for plant size
          CustomListGroup(title: 'Plant Size', children: <Widget>[
            CustomListRow(title: 'Begin', data: widget.plant.plantSize?.begin.toString()),
            CustomListRow(title: 'Now', data: widget.plant.plantSize?.now.toString()),
            CustomListRow(title: 'Pot Size', data: SizeHelper.getStringFromSize(widget.plant.potSize))
          ]),

          //List group for watering
          CustomListGroup(title: 'Watering', children: <Widget>[
            CustomListRow(title: 'Amount', data: widget.plant.watering?.waterAmount.toString()),
            CustomListRow(title: 'Interval', data: PeriodsHelper.getStringFromPeriod(widget.plant.watering?.interval)),
            CustomListRow(title: 'Last Time', data: Util.getStringFromDateTime(widget.plant.watering?.startDate))
          ]),

          //List group for Spray plants
          CustomListGroup(title: 'Spray Plants', children: <Widget>[
            CustomListRow(title: 'Interval', data: PeriodsHelper.getStringFromPeriod(widget.plant.spray?.interval)),
            CustomListRow(title: 'Last Time', data: Util.getStringFromDateTime(widget.plant.spray?.startDate)),
            //widget.plant.spray?.startDate?.toString()
            //"${widget.plant.spray?.startDate?.toLocal()}".split(' ')[0]
          ]),

          //List group for Fertilize
          CustomListGroup(title: 'Fertilize', children: <Widget>[
            CustomListRow(title: 'Amount', data: widget.plant.fertilize?.amount.toString()),
            CustomListRow(title: 'Interval', data: PeriodsHelper.getStringFromPeriod(widget.plant.fertilize?.interval)),
            CustomListRow(title: 'Last Time', data: Util.getStringFromDateTime(widget.plant.fertilize?.startDate))
          ]),

          //List group for Environment
          CustomListGroup(title: 'Environment', children: <Widget>[
            CustomListRow(title: 'Temperature', data: widget.plant.temperature.toString()),
            CustomListRow(title: 'Sun-need', data: SizeHelper.getStringFromSize(widget.plant.sunDemand)),
          ]),

          //List group for Repot
          CustomListGroup(title: 'Repot', children: <Widget>[
            CustomListRow(title: 'Interval', data: PeriodsHelper.getStringFromPeriod(widget.plant.repot?.interval)),
            CustomListRow(title: 'Last Time', data: Util.getStringFromDateTime(widget.plant.repot?.startDate))
          ]),

          //List group for Dust Off
          CustomListGroup(title: 'Dust Off', children: <Widget>[
            CustomListRow(title: 'Interval', data: PeriodsHelper.getStringFromPeriod(widget.plant.dustOff?.interval)),
            CustomListRow(title: 'Last Time', data: Util.getStringFromDateTime(widget.plant.dustOff?.startDate))
          ]),
          const SizedBox(height: 50),

        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to new garden form
          Navigator.of(context).pop();
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => EditPlant(
                  user: widget.user,
                  garden: widget.garden,
                  plant: widget.plant,
                  isTemplate: false))
          );
        },
        backgroundColor: Theme.of(context).primaryColor,
        child: Icon(
          Icons.edit,
          size: 35,
          color: Theme.of(context).unselectedWidgetColor, //scaffoldBackgroundColor for turned around color
        ),
      )
    );
  }
}
