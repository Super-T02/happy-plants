import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:happy_plants/services/garden.dart';
import 'package:happy_plants/shared/models/user.dart';
import 'package:happy_plants/shared/widgets/util/custom_form_field.dart';
import '../../../../shared/models/garden.dart';
import '../../../../shared/widgets/util/image_card.dart';

class EditGarden extends StatefulWidget {
  const EditGarden({Key? key, required this.garden, required this.user}) : super(key: key);

  final Garden garden;
  final CustomUser user;

  @override
  State<EditGarden> createState() => _EditGardenState();
}

class _EditGardenState extends State<EditGarden> {
  final _formKey = GlobalKey<FormState>();
  final List<ImageCard> images = Garden.allFiles.map(
          (image) => ImageCard(
        url: "assets/images/garden_backgrounds/$image.jpg",
        name: image,
      )
  ).toList();


  // Form controllers
  TextEditingController gardenNameController = TextEditingController();

  // Variables for the status and values
  String? pictureInitName;
  String? gardenInitName;
  String? currentPictureName;

  /// Validator for the garden name
  String? nameValidator(String? value) {
    if(value == null || value.isEmpty){
      return 'Please enter a name';
    } else {
      return null;
    }
  }


  /// Validator for the garden icon
  void pictureChanged(pageNumber, reason) {
    currentPictureName = Garden.allFiles[pageNumber];
  }

  /// Handles the submit of the form
  void _onSubmitted(Garden garden, CustomUser user) async {
    if (_formKey.currentState!.validate()) {

      // TODO: Loading spinner

      if(gardenInitName != gardenNameController.text){
        // update garden name
        await GardenService.patchGarden(
            garden.id,
            "name",
            gardenNameController.text,
            user
        );
      }

      if(pictureInitName != currentPictureName){
        // update picture name
        await GardenService.patchGarden(
            garden.id,
            "icon",
            currentPictureName,
            user
        );
      }

      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill the form correctly')),
      );
    }
  }

  @override
  void initState() {
    pictureInitName = widget.garden.icon;
    currentPictureName = widget.garden.icon;
    gardenNameController.text = widget.garden.name;
    gardenInitName = widget.garden.name;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    CarouselController imageCarouselController = CarouselController();
    ThemeData theme = Theme.of(context);




    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('New garden'),
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

                      // Image Carousel
                      CarouselSlider(
                          carouselController: imageCarouselController,
                          items: images,
                          options: CarouselOptions(
                            initialPage: images.indexWhere(
                                    (pic) => pic.name == pictureInitName
                            ),
                            height: 180.0,
                            enlargeCenterPage: true,
                            aspectRatio: 16 / 9,
                            autoPlayCurve: Curves.fastOutSlowIn,
                            enableInfiniteScroll: true,
                            viewportFraction: 0.8,
                            onPageChanged: pictureChanged,
                          )
                      ),
                      const SizedBox(height: 20),

                      // Name
                      CustomFormField(
                          headingText: "Garden Name *",
                          hintText: "Please enter a garden name",
                          obscureText: false,
                          suffixIcon: null,
                          textInputType: TextInputType.name,
                          textInputAction: TextInputAction.done,
                          controller: gardenNameController,
                          maxLines: 1,
                          validator: nameValidator
                      ),
                      const SizedBox(height: 20),


                      // Buttons
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          // Submit Button
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: theme.primaryColor
                            ),
                            onPressed: () => _onSubmitted(widget.garden, widget.user),
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
