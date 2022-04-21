import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:happy_plants/screens/home/tabs/garden/plants/gardenForm/drop_down_category.dart';
import 'package:happy_plants/screens/home/tabs/garden/plants/gardenForm/plant_size_picker.dart';
import 'package:happy_plants/screens/home/tabs/garden/plants/gardenForm/type_picker.dart';
import 'package:happy_plants/shared/utilities/sizes.dart';
import 'package:provider/provider.dart';
import '../../../../../services/plant.dart';
import '../../../../../shared/models/garden.dart';
import '../../../../../shared/models/plant.dart';
import '../../../../../shared/models/user.dart';
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

  void pictureChanged(pageNumber, reason) {
    pictureName = Plant.allFiles[pageNumber];
  }


  void _onSubmitted(user, garden) async {
    if (_formKey.currentState!.validate()) {
      // TODO: Loading spinner

      // add the plant
      await PlantService.addPlant(
          AddPlant(
            name: plantNameController.text,
            icon: pictureName.toLowerCase(),
            gardenID: garden.id,
            type: plantTypeController.text,
            //plantSize: PlantSize(begin: int.parse(plantSizeBeginningController.text), now: int.parse(plantSizeEndController.text)),
            //todo: plant size isn't saved
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
                      DropDownCategory(heading: 'Plant Size', description: 'beginning, end', childrenWidgets: [
                        PlantSizePicker(plantSizeController: plantSizeBeginningController, heading: 'Plant size beginning (cm)', hint: 'Please enter the size your plant had in the beginning'),
                        PlantSizePicker(plantSizeController: plantSizeEndController, heading: 'Plant size end (cm)', hint: 'Please enter the size your plant has right now'),
                        const SizedBox(height: 10)
                      ]),
                      //watering
                      const DropDownCategory(heading: 'Watering', description: 'amount, interval, lastTime', childrenWidgets: [SizePicker(title: 'beginning')]),
                      //spray
                      const DropDownCategory(heading: 'Spray plants', description: 'interval, lastTime', childrenWidgets: [SizePicker(title: 'beginning')]),
                      //fertilize
                      const DropDownCategory(heading: 'Fertilize', description: 'amount, interval, lastTime', childrenWidgets: [SizePicker(title: 'beginning')]),
                      //environment
                      const DropDownCategory(heading: 'Environment', description: 'temperature, sun-need', childrenWidgets: [SizePicker(title: 'beginning')]),
                      //repot
                      const DropDownCategory(heading: 'Reopt', description: 'interval, lastTime', childrenWidgets: [SizePicker(title: 'beginning')]),
                      //dust off
                      const DropDownCategory(heading: 'Dust off', description: 'interval, lastTime', childrenWidgets: [SizePicker(title: 'beginning')]),


                      // Buttons
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          // Submit Button
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
