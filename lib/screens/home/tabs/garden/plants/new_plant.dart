import 'dart:ffi';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:happy_plants/shared/models/events.dart';
import 'package:happy_plants/shared/widgets/forms/custom_dropdown.dart';
import 'package:happy_plants/shared/widgets/util/custom_accordion.dart';
import 'package:happy_plants/shared/widgets/forms/int_picker.dart';
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
  TextEditingController fertilizeAmountController = TextEditingController();
  TextEditingController temperatureController = TextEditingController();

  //variables for the pickers & their callback functions
  DateTime? wateringLastTime;
  DateTime? sprayPlantsLastTime;
  DateTime? fertilizeLastTime;
  DateTime? repotLastTime;
  DateTime? dustOffLastTime;
  String? potSize;
  String? wateringInterval;
  String? sprayInterval;
  String? fertilizeInterval;
  String? repotInterval;
  String? dustOffInterval;
  String? sunNeed;

  //marker for error info messages
  bool? plantSizeCorrect;
  bool? wateringCorrect;
  bool? sprayPlantsCorrect;
  bool? fertilizeCorrect;
  bool? environmentCorrect;
  bool? repotCorrect;
  bool? dustOffCorrect;

  @override
  void initState() {
    plantSizeCorrect = true;
    wateringCorrect = true;
    sprayPlantsCorrect = true;
    fertilizeCorrect = true;
    environmentCorrect = true;
    repotCorrect = true;
    dustOffCorrect = true;
    super.initState();
  }

  //callback functions for ifs to set the correctness of the accordions (code reducing)
  void plantSizeCorrectCallback(bool setValue){
    setState(() {
      plantSizeCorrect = setValue;
    });
  }

  void wateringCorrectCallback(bool setValue){
    setState(() {
      wateringCorrect = setValue;
    });
  }

  void sprayPlantsCorrectCallback(bool setValue){
    setState(() {
      sprayPlantsCorrect = setValue;
    });
  }

  void fertilizeCorrectCallback(bool setValue){
    setState(() {
      fertilizeCorrect = setValue;
    });
  }

  void environmentCorrectCallback(bool setValue){
    setState(() {
      environmentCorrect = setValue;
    });
  }

  void repotCorrectCallback(bool setValue){
    setState(() {
      repotCorrect = setValue;
    });
  }

  void dustOffCorrectCallback(bool setValue){
    setState(() {
      dustOffCorrect = setValue;
    });
  }

  ///check plant size accordion
  void plantSizeOnChanged(){
    if(plantSizeBeginningController.text.isEmpty && plantSizeEndController.text.isEmpty && potSize == null){
      plantSizeCorrectCallback(true);
    }
    else if(plantSizeBeginningController.text.isNotEmpty && plantSizeEndController.text.isNotEmpty && potSize != null){
      plantSizeCorrectCallback(true);
    }
    else{
      plantSizeCorrectCallback(false);
    }
  }

  ///check watering accordion correctness
  void wateringOnChanged(){
    if(wateringAmountController.text.isEmpty && wateringInterval == null && wateringLastTime == null){
      wateringCorrectCallback(true);
    }
    else if(wateringAmountController.text.isNotEmpty && wateringInterval != null && wateringLastTime != null){
      wateringCorrectCallback(true);
    }
    else{
      wateringCorrectCallback(false);
    }
  }

  ///check sprayPlants accordion correctness
  void sprayPlantsOnChanged(){
    if(sprayInterval == null && sprayPlantsLastTime == null){
      sprayPlantsCorrectCallback(true);
    }
    else if(sprayInterval != null && sprayPlantsLastTime != null){
      sprayPlantsCorrectCallback(true);
    }
    else{
      sprayPlantsCorrectCallback(false);
    }
  }

  ///check fertilize accordion correctness
  void fertilizeOnChanged(){
    if(fertilizeAmountController.text.isEmpty && fertilizeInterval == null && fertilizeLastTime == null){
      fertilizeCorrectCallback(true);
    }
    else if(fertilizeAmountController.text.isNotEmpty && fertilizeInterval != null && fertilizeLastTime != null){
      fertilizeCorrectCallback(true);
    }
    else{
      fertilizeCorrectCallback(false);
    }
  }

  ///check environment accordion correctness
  void environmentOnChanged(){
    if(temperatureController.text.isEmpty && sunNeed == null){
      environmentCorrectCallback(true);
    }
    else if(temperatureController.text.isNotEmpty && sunNeed != null){
      environmentCorrectCallback(true);
    }
    else{
      environmentCorrectCallback(false);
    }
  }

  ///check repot accordion correctness
  void repotOnChanged(){
    if(repotInterval == null && repotLastTime == null){
      repotCorrectCallback(true);
    }
    else if(repotInterval != null && repotLastTime != null){
      repotCorrectCallback(true);
    }
    else{
      repotCorrectCallback(false);
    }
  }

  ///check dustOff accordion correctness
  void dustOffOnChanged(){
    if(dustOffInterval == null && dustOffLastTime == null){
      dustOffCorrectCallback(true);
    }
    else if(dustOffInterval != null && dustOffLastTime != null){
      dustOffCorrectCallback(true);
    }
    else{
      dustOffCorrectCallback(false);
    }
  }

  void pictureChanged(pageNumber, reason) {
    pictureName = Plant.allFiles[pageNumber];
  }

  ///checks all categories of form for correctness, returns null if everything is fine
  String? getAccordionsErrors() {
    if (plantSizeCorrect != null && plantSizeCorrect!
        && wateringCorrect != null && wateringCorrect!
        && sprayPlantsCorrect != null && sprayPlantsCorrect!
        && fertilizeCorrect != null && fertilizeCorrect!
        && environmentCorrect != null && environmentCorrect!
        && repotCorrect != null && repotCorrect!
        && dustOffCorrect != null && dustOffCorrect!
    ) {
      return null;
    }
    else if (plantSizeCorrect != null && !plantSizeCorrect!) {
      return "Plant Size";
    } else if (wateringCorrect != null && !wateringCorrect!) {
      return "Watering";
    } else if (sprayPlantsCorrect != null && !sprayPlantsCorrect!) {
      return "Spray Plants";
    } else if (fertilizeCorrect != null && !fertilizeCorrect!) {
      return "Fertilize";
    } else if (environmentCorrect != null && !environmentCorrect!) {
      return "Environment";
    } else if (repotCorrect != null && !repotCorrect!) {
      return "Repot";
    } else if (dustOffCorrect != null && !dustOffCorrect!) {
      return "Dust off";
    } else {
      throw Error();
    }
  }

  void _onSubmitted(user, garden) async {
    if (_formKey.currentState!.validate() && getAccordionsErrors() == null) {
      // add the plant
      await PlantService.addPlant(
          AddPlant(
            name: plantNameController.text,
            icon: pictureName.toLowerCase(),
            gardenID: garden.id,
            type: plantTypeController.text,
            plantSize: PlantSize(begin: int.tryParse(plantSizeBeginningController.text), now: int.tryParse(plantSizeEndController.text)),
            watering: Watering(waterAmount: int.tryParse(wateringAmountController.text), interval: PeriodsHelper.getPeriodsFromString(wateringInterval), startDate: wateringLastTime),
            spray: IntervalDateTime(interval: PeriodsHelper.getPeriodsFromString(sprayInterval), startDate: sprayPlantsLastTime),
            fertilize: Fertilize(amount: int.tryParse(fertilizeAmountController.text), interval: PeriodsHelper.getPeriodsFromString(fertilizeInterval), startDate: fertilizeLastTime),
            sunDemand: SizeHelper.getSizeFromString(sunNeed),
            temperature: int.tryParse(temperatureController.text),
            repot: IntervalDateTime(interval: PeriodsHelper.getPeriodsFromString(repotInterval), startDate: repotLastTime),
            dustOff: IntervalDateTime(interval: PeriodsHelper.getPeriodsFromString(dustOffInterval), startDate: dustOffLastTime),
            potSize: SizeHelper.getSizeFromString(potSize),
          ), user);

      Navigator.pop(context);
    } else if (!_formKey.currentState!.validate()){
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill out required fields!')),
      );
    } else if (getAccordionsErrors() != null){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error in Category: ${getAccordionsErrors()}')),
      );
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

    //default error string for incomplete accordion:
    List<Widget> warningString = [
      Text(
        'Please fill out all values of category!',
        style: textTheme.bodyText1?.copyWith(
          color: Colors.red,
        ),
      ),
      const SizedBox(height: 16)
    ];

    //widgets for the children of accordions predefined to be able to add or remove the error message of an incomplete widget
    List<Widget> plantSizeAccordionChildren = [];
    if(!plantSizeCorrect!){
      plantSizeAccordionChildren.addAll(warningString);
    }
    plantSizeAccordionChildren.addAll([
      IntPicker(plantSizeController: plantSizeBeginningController, heading: 'Plant size beginning (cm)', hint: 'Enter old size of plant', onChange: (value) =>  plantSizeOnChanged()),
      IntPicker(plantSizeController: plantSizeEndController, heading: 'Plant size now (cm)', hint: 'Enter recent size of plant', onChange: (value) => plantSizeOnChanged()),
      CustomDropDown(menuItems: const ['xs', 's', 'm', 'l', 'xl'], title: 'Pot size', onChange: (_sunNeeded){potSize = _sunNeeded;plantSizeOnChanged();}, value: potSize, hint: 'Please choose an option for the pot size'),
    ]);

    List<Widget> wateringAccordionChildren = [];
    if(!wateringCorrect!){
      wateringAccordionChildren.addAll(warningString);
    }
    wateringAccordionChildren.addAll([
      IntPicker(plantSizeController: wateringAmountController, heading: 'Water amount needed', hint: 'Water needed by plant in ml / interval', onChange: (value) =>  wateringOnChanged()),
      CustomDropDown(menuItems: PeriodsHelper.periodsMenuItems, title: 'Interval between watering', hint: 'Choose an Option', onChange: (_interval) {wateringInterval = _interval; wateringOnChanged();}),
      CustomDatePicker(description: 'Last time watered:', onSubmit: (newDate){wateringLastTime = newDate;wateringOnChanged();})
    ]);

    List<Widget> sprayPlantsAccordionChildren = [];
    if(!sprayPlantsCorrect!){
      sprayPlantsAccordionChildren.addAll(warningString);
    }
    sprayPlantsAccordionChildren.addAll([
      CustomDropDown(menuItems: PeriodsHelper.periodsMenuItems, title: 'Interval between spraying', hint: 'Choose an Option', onChange: (_interval) {sprayInterval = _interval; sprayPlantsOnChanged();}),
      CustomDatePicker(description: 'Last time sprayed:', onSubmit: (newDate){sprayPlantsLastTime= newDate;sprayPlantsOnChanged();}),
    ]);

    List<Widget> fertilizeAccordionChildren = [];
    if(!fertilizeCorrect!){
      fertilizeAccordionChildren.addAll(warningString);
    }
    fertilizeAccordionChildren.addAll([
      IntPicker(plantSizeController: fertilizeAmountController, heading: 'Fertilize amount needed', hint: 'Amount of fertilizer needed in mg / interval', onChange: (value) =>  fertilizeOnChanged()),
      CustomDropDown(menuItems: PeriodsHelper.periodsMenuItems, title: 'Interval between fertilizing', hint: 'Choose an Option', onChange: (_interval) {fertilizeInterval = _interval; fertilizeOnChanged();}),
      CustomDatePicker(description: 'Last time fertilized:', onSubmit: (newDate){fertilizeLastTime= newDate;fertilizeOnChanged();})
    ]);

    List<Widget> environmentAccordionChildren = [];
    if(!environmentCorrect!){
      environmentAccordionChildren.addAll(warningString);
    }
    environmentAccordionChildren.addAll([
      IntPicker(plantSizeController: temperatureController, heading: 'Favourite temperature of plant', hint: 'Enter value of plants preferred temperature in °C', onChange: (value) =>  environmentOnChanged()),
      CustomDropDown(menuItems: const ['xs', 's', 'm', 'l', 'xl'], title: 'Sun amount preferred', onChange: (_sunNeeded){sunNeed = _sunNeeded;environmentOnChanged();}, value: sunNeed, hint: 'Please choose an option for the preferred sun amount')
    ]);

    List<Widget> repotAccordionChildren = [];
    if(!repotCorrect!){
      repotAccordionChildren.addAll(warningString);
    }
    repotAccordionChildren.addAll([
      CustomDropDown(menuItems: PeriodsHelper.periodsMenuItems, title: 'Interval between repot', hint: 'Choose an Option', onChange: (_interval) {repotInterval = _interval; repotOnChanged();}),
      CustomDatePicker(description: 'Last time sprayed:', onSubmit: (newDate){repotLastTime= newDate;repotOnChanged();}),
    ]);

    List<Widget> dustOffAccordionChildren = [];
    if(!dustOffCorrect!){
      dustOffAccordionChildren.addAll(warningString);
    }
    dustOffAccordionChildren.addAll([
      CustomDropDown(menuItems: PeriodsHelper.periodsMenuItems, title: 'Interval between dusting off', hint: 'Choose an Option', onChange: (_interval) {dustOffInterval = _interval; dustOffOnChanged();}),
      CustomDatePicker(description: 'Last time sprayed:', onSubmit: (newDate){dustOffLastTime= newDate;dustOffOnChanged();}),
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
                      CustomAccordion(heading: 'Watering', description: 'amount, interval, lastTime', childrenWidgets: wateringAccordionChildren),
                      //spray
                      CustomAccordion(heading: 'Spray plants', description: 'interval, lastTime', childrenWidgets: sprayPlantsAccordionChildren),
                      //fertilize
                      CustomAccordion(heading: 'Fertilize', description: 'amount, interval, lastTime', childrenWidgets: fertilizeAccordionChildren),
                      //environment
                      CustomAccordion(heading: 'Environment', description: 'temperature, sun-need', childrenWidgets: environmentAccordionChildren),
                      //repot
                      CustomAccordion(heading: 'Repot', description: 'interval, lastTime', childrenWidgets: repotAccordionChildren),
                      //dust off
                      CustomAccordion(heading: 'Dust off', description: 'interval, lastTime', childrenWidgets: dustOffAccordionChildren),

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
