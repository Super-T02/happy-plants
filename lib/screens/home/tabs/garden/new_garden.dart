import 'package:flutter/material.dart';
import 'package:happy_plants/services/garden.dart';
import 'package:happy_plants/shared/models/user.dart';
import 'package:happy_plants/shared/utilities/theme.dart';
import 'package:provider/provider.dart';
import '../../../../shared/models/garden.dart';
import '../../../../shared/utilities/app_colors.dart';

class NewGarden extends StatefulWidget {
  const NewGarden({Key? key}) : super(key: key);

  @override
  State<NewGarden> createState() => _NewGardenState();
}

class _NewGardenState extends State<NewGarden> {
  final _formKey = GlobalKey<FormState>();

  // Form controllers
  TextEditingController pictureController = TextEditingController();
  TextEditingController gardenNameController = TextEditingController();

  /// Validator for the garden name
  String? nameValidator(String? value) {
    if(value == null || value.isEmpty){
      return 'Please enter a name';
    } else {
      return null;
    }
  }


  /// Validator for the garden icon
  String? pictureValidator(String? value) {
    if(value == null || value.isEmpty){
      return 'Please enter a picture name';
    } else if(!Garden.checkItemName(value.toLowerCase())){
      return 'Please enter a valid picture name';
    } else {
      return null;
    }
  }

  /// Handles the submit of the form
  void _onSubmitted(user) async {
    if (_formKey.currentState!.validate()) {

      // TODO: Loading spinner

      // add the garden
      await GardenService.addGarden(
          AddGarden(
            name: gardenNameController.text,
            icon: pictureController.text.toLowerCase(),
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
    final user = Provider.of<CustomUser?>(context);
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
                children: <Widget>[
                  TextFormField(
                    // TODO: As selection of images
                    style: textTheme.bodyText1,
                    controller: pictureController,
                    cursorColor: AppColors.accent1,
                    decoration: const InputDecoration(
                      labelText: 'Picture name *'
                    ),
                    validator: pictureValidator,
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    style: textTheme.bodyText1,
                    controller: gardenNameController,
                    cursorColor: AppColors.accent1,
                    decoration: const InputDecoration(
                      labelText: 'Garden name *',
                    ),
                    validator: nameValidator,
                  ),
                  const SizedBox(height: 20),
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
