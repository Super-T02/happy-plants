import 'package:flutter/material.dart';
import 'package:happy_plants/screens/home/tabs/garden/plants/gardenForm/type_picker.dart';
import 'package:happy_plants/shared/utilities/sizes.dart';
import 'package:provider/provider.dart';
import '../../../../../services/plant.dart';
import '../../../../../shared/models/garden.dart';
import '../../../../../shared/models/plant.dart';
import '../../../../../shared/models/user.dart';
import '../../../../../shared/widgets/util/custom_form_field.dart';
import 'gardenForm/name_picker.dart';
import 'gardenForm/pot_size_picker.dart';

class NewPlant extends StatefulWidget {
  const NewPlant({Key? key, required this.user, required this.garden}) : super(key: key);

  final CustomUser user;
  final Garden garden;

  @override
  State<NewPlant> createState() => _NewPlantState();
}

class _NewPlantState extends State<NewPlant> {
  final _formKey= GlobalKey<FormState>();

  // Form controllers
  TextEditingController plantNameController = TextEditingController();
  TextEditingController plantTypeController = TextEditingController();

  void _onSubmitted(user, garden) async {
    if (_formKey.currentState!.validate()) {

      // TODO: Loading spinner

      // add the plant
      await PlantService.addPlant(
          AddPlant(
            name: plantNameController.text,
            gardenID: garden.id,
            type: plantTypeController.text,
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
                      // Name
                      NamePicker(plantNameController: plantNameController),
                      const SizedBox(height: 20),
                      //type
                      TypePicker(plantTypeController: plantTypeController),
                      const SizedBox(height: 20),

                      Text('--Category--', style: textTheme.bodyLarge),
                      //pot size
                      PotSizePicker(),


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
