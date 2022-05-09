import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:happy_plants/services/garden.dart';
import 'package:happy_plants/services/util_service.dart';
import 'package:happy_plants/shared/models/user.dart';
import 'package:happy_plants/shared/utilities/util.dart';
import 'package:happy_plants/shared/widgets/util/custom_form_field.dart';
import 'package:provider/provider.dart';
import '../../../../shared/models/garden.dart';
import '../../../../shared/widgets/util/image_card.dart';

class NewGarden extends StatefulWidget {
  const NewGarden({Key? key}) : super(key: key);

  @override
  State<NewGarden> createState() => _NewGardenState();
}

class _NewGardenState extends State<NewGarden> {
  final _formKey = GlobalKey<FormState>();
  final List<ImageCard> images = Garden.allFiles.map(
          (image) => ImageCard(
            url: "assets/images/garden_backgrounds/$image.jpg",
            name: image,
          )
  ).toList();


  // Form controllers
  TextEditingController gardenNameController = TextEditingController();

  // Picture name
  String pictureName = "one";

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
    pictureName = Garden.allFiles[pageNumber];
  }

  /// Handles the submit of the form
  void _onSubmitted(user) async {
    if (_formKey.currentState!.validate()) {

      try {
        Util.startLoading();

        // add the garden
        await GardenService.addGarden(
            AddGarden(
              name: gardenNameController.text,
              icon: pictureName.toLowerCase(),
            ), user);

        Util.endLoading();
        Navigator.pop(context);
        UtilService.showSuccess('Created!', '${gardenNameController.text} was created successfully!');
      } catch (e) {
        UtilService.showError('Unable to create Garden', 'Please add the garden later');
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill the form correctly')),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CustomUser?>(context);
    CarouselController imageCarouselController = CarouselController();
    TextTheme textTheme = Theme.of(context).textTheme;
    InputDecorationTheme inputDecorationTheme = Theme.of(context).inputDecorationTheme;
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
                        onPressed: () => _onSubmitted(user),
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
