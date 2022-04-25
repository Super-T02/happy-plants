import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:happy_plants/shared/widgets/forms/custom_dropdown.dart';
import 'package:happy_plants/shared/widgets/util/custom_accordion.dart';
import 'package:happy_plants/screens/home/tabs/garden/plants/gardenForm/int_picker.dart';
import 'package:happy_plants/screens/home/tabs/garden/plants/gardenForm/type_picker.dart';
import 'package:happy_plants/shared/utilities/sizes.dart';
import 'package:happy_plants/shared/widgets/forms/custom_datepicker.dart';
import '../../../../../services/plant.dart';
import '../../../../../shared/models/garden.dart';
import '../../../../../shared/models/plant.dart';
import '../../../../../shared/models/user.dart';
import '../../../../../shared/utilities/util.dart';
import '../../../../../shared/widgets/util/custom_form_field.dart';
import '../../../../../shared/widgets/util/image_card.dart';
import 'gardenForm/name_picker.dart';
import 'gardenForm/size_picker.dart';

class NewPlant extends StatefulWidget {
  const NewPlant({Key? key, required this.user, required this.garden}) : super(key: key);

  final CustomUser user;
  final Garden garden;

  @override
  State<NewPlant> createState() => _NewPlantState();
}

class _NewPlantState extends State<NewPlant> {
  final _formKey= GlobalKey<FormState>();
  final List<ImageCard> images = Plant.allFiles.map(
          (image) => ImageCard(
        url: "assets/images/plant_backgrounds/$image.jpg",
        name: image,
      )
  ).toList();

  String pictureName = "one";

  // Form controllers
  TextEditingController plantNameController = TextEditingController();
  TextEditingController plantTypeController = TextEditingController();
  TextEditingController plantSizeBeginningController = TextEditingController();
  TextEditingController plantSizeEndController = TextEditingController();

  TextEditingController wateringAmountController = TextEditingController();
  TextEditingController wateringIntervalController = TextEditingController();
  TextEditingController sprayingIntervalController = TextEditingController();
  TextEditingController fertilizeAmountController = TextEditingController();
  TextEditingController fertilizeIntervalController = TextEditingController();
  TextEditingController temperatureController = TextEditingController();
  TextEditingController reportIntervalController = TextEditingController();
  TextEditingController dustOffIntervalController = TextEditingController();

  //variables for the pickers & their callback functions
  DateTime? wateringLastTime;
  DateTime? sprayPlantsLastTime;
  DateTime? fertilizeLastTime;
  DateTime? repotLastTime;
  DateTime? dustOffLastTime;
  String? potSize;
  String? sunNeed;

  //marker for error info messages
  bool? plantSizeCorrect;
  //TODO: für alle akk

  @override
  void initState() {
    plantSizeCorrect = true;
    super.initState();
  }

  void plantSizeOnChanged(){
    if(plantSizeBeginningController.text.isEmpty && plantSizeEndController.text.isEmpty && potSize != null){
      setState(() {
        plantSizeCorrect = false;
        potSize = potSize;
      });
    }
    //TODO: check all cases, also true case
  }
  //TODO for every accordion

  void pictureChanged(pageNumber, reason) {
    pictureName = Plant.allFiles[pageNumber];
  }


  void _onSubmitted(user, garden) async {
    if (_formKey.currentState!.validate()) {

      // add the plant
      await PlantService.addPlant(
          AddPlant(
            name: plantNameController.text,
            icon: pictureName.toLowerCase(),
            gardenID: garden.id,
            type: plantTypeController.text,
            plantSize: PlantSize(begin: int.tryParse(plantSizeBeginningController.text), now: int.tryParse(plantSizeEndController.text)),
            watering: Watering(waterAmount: int.tryParse(wateringAmountController.text), interval: int.tryParse(wateringIntervalController.text), lastTime: wateringLastTime),
            spray: IntervalDateTime(interval: int.tryParse(sprayingIntervalController.text), lastTime: sprayPlantsLastTime),
            fertilize: Fertilize(amount: int.tryParse(fertilizeAmountController.text), interval: int.tryParse(fertilizeIntervalController.text), lastTime: fertilizeLastTime),
            sunDemand: SizeHelper.getSizeFromString(sunNeed),
            temperature: int.tryParse(temperatureController.text),
            repot: IntervalDateTime(interval: int.tryParse(reportIntervalController.text), lastTime: repotLastTime),
            dustOff: IntervalDateTime(interval: int.tryParse(dustOffIntervalController.text), lastTime: dustOffLastTime),
            potSize: SizeHelper.getSizeFromString(potSize),
          ), user);

      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill the form correctly')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    //final user = Provider.of<CustomUser?>(context);
    CarouselController imageCarouselController = CarouselController();
    TextTheme textTheme = Theme.of(context).textTheme;
    InputDecorationTheme inputDecorationTheme = Theme.of(context).inputDecorationTheme;
    ThemeData theme = Theme.of(context);

    //TODO für alle akk
    List<Widget> plantSizeAccordionChildren = [];
    if(!plantSizeCorrect!){
      plantSizeAccordionChildren = [const Text('hallloooo richtige eingabe!')];
    }
    plantSizeAccordionChildren.addAll([
      IntPicker(plantSizeController: plantSizeBeginningController, heading: 'Plant size beginning (cm)', hint: 'Enter old size of plant', onChange: (value) =>  plantSizeOnChanged()),
      IntPicker(plantSizeController: plantSizeEndController, heading: 'Plant size now (cm)', hint: 'Enter recent size of plant', onChange: (value) => plantSizeOnChanged()),
      CustomDropDown(menuItems: ['xs', 's', 'm', 'l', 'xl'], title: 'Pot size', onChange: (_sunNeeded){potSize = _sunNeeded;plantSizeOnChanged();}, value: potSize, hint: 'Please choose an option for the pot size'),
    ]);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('New plant'),
        backgroundColor: Theme.of(context).bottomAppBarColor,
        foregroundColor: Theme.of(context).unselectedWidgetColor,
      ),
      body: ListView(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        padding: const EdgeInsets.all(15), //padding from screen to widget
        addAutomaticKeepAlives: true,
        children: <Widget>[
          Form(
              key: _formKey,
              child: Padding(
                  padding: const EdgeInsets.all(15), //padding from screen to widget
                  child: Column(

                    // Form
                    children: <Widget>[
                      //icon/image carousel
                      CarouselSlider(
                          carouselController: imageCarouselController,
                          items: images,
                          options: CarouselOptions(
                            height: 180.0,
                            enlargeCenterPage: true,
                            aspectRatio: 16 / 9,
                            autoPlayCurve: Curves.fastOutSlowIn,
                            enableInfiniteScroll: true,
                            viewportFraction: 0.8,
                            onPageChanged: pictureChanged,
                          )
                      ),
                      // Name
                      NamePicker(plantNameController: plantNameController),
                      //type
                      TypePicker(plantTypeController: plantTypeController),
                      const SizedBox(height: 10),

                      //Plant size
                      CustomAccordion(heading: 'Plant Size', description: 'beginning, end, pot size', childrenWidgets: plantSizeAccordionChildren),
                      //watering
                      //TODO: onchange einfügen
                      CustomAccordion(heading: 'Watering', description: 'amount, interval, lastTime', childrenWidgets: [
                        IntPicker(plantSizeController: wateringAmountController, heading: 'Water amount needed', hint: 'Water needed by plant in ml / interval'),
                        IntPicker(plantSizeController: wateringIntervalController, heading: 'Interval between watering', hint: 'Enter number of days that divide watering'),
                        CustomDatePicker(description: 'Last time watered:', onSubmit: (newDate){wateringLastTime = newDate;})
                      ]),
                      //spray
                      CustomAccordion(heading: 'Spray plants', description: 'interval, lastTime', childrenWidgets: [
                        IntPicker(plantSizeController: sprayingIntervalController, heading: 'Interval between spraying', hint: 'Enter number of days that divide spraying'),
                        CustomDatePicker(description: 'Last time sprayed:', onSubmit: (newDate){sprayPlantsLastTime= newDate;}),
                      ]),
                      //fertilize
                      CustomAccordion(heading: 'Fertilize', description: 'amount, interval, lastTime', childrenWidgets: [
                        IntPicker(plantSizeController: fertilizeAmountController, heading: 'Fertilize amount needed', hint: 'Amount of fertilizer needed in mg / interval'),
                        IntPicker(plantSizeController: fertilizeIntervalController, heading: 'Interval between fertilizing', hint: 'Enter number of days that divide fertilizing'),
                        CustomDatePicker(description: 'Last time fertilized:', onSubmit: (newDate){fertilizeLastTime= newDate;})
                      ]),
                      //environment
                      CustomAccordion(heading: 'Environment', description: 'temperature, sun-need', childrenWidgets: [
                        IntPicker(plantSizeController: temperatureController, heading: 'Favourite temperature of plant', hint: 'Enter value of plants prefered temperature in °C'),
                        CustomDropDown(menuItems: ['xs', 's', 'm', 'l', 'xl'], title: 'Sun amount prefered', onChange: (_sunNeeded){sunNeed = _sunNeeded;}, value: sunNeed, hint: 'Please choose an option for the prefered sun amount')
                      ]),
                      //repot
                      CustomAccordion(heading: 'Repot', description: 'interval, lastTime', childrenWidgets: [
                        IntPicker(plantSizeController: reportIntervalController, heading: 'Interval between repoting', hint: 'Enter number of days that divide repoting'),
                        CustomDatePicker(description: 'Last time sprayed:', onSubmit: (newDate){repotLastTime= newDate;}),
                      ]),
                      //dust off
                      CustomAccordion(heading: 'Dust off', description: 'interval, lastTime', childrenWidgets: [
                        IntPicker(plantSizeController: dustOffIntervalController, heading: 'Interval between dusting off', hint: 'Enter number of days that divide dusting off'),
                        CustomDatePicker(description: 'Last time sprayed:', onSubmit: (newDate){dustOffLastTime= newDate;}),
                      ]),


                      // Buttons
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          // Submit Button
                          //TODO: implement generalized button import
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: theme.primaryColor
                            ),
                            onPressed: () => _onSubmitted(widget.user, widget.garden),
                            child: const Text(
                              'Submit',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          const SizedBox(width: 64),
                          // Abort Button
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.grey,
                            ),
                            onPressed: () => Navigator.pop(context),
                            child: const Text(
                              'Abort',
                              style: TextStyle(color: Colors.white),
                            ),
                          )
                        ],
                      )
                    ],
                  )
              )
          )
        ],
      ),
    );
  }
}
