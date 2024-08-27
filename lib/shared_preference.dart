import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreference extends StatefulWidget {
  const SharedPreference({super.key});

  @override
  State<SharedPreference> createState() => _SharedPreferenceState();
}

class _SharedPreferenceState extends State<SharedPreference> {
  TextEditingController textEditingController = TextEditingController();

  static const String KEYNAME = 'name';
  var name = 'No value entered';

  //for showing the text when user first open this page
  @override
  void initState() {
    super.initState();
    //we can't make initState() fn async so we need to use another fn inside it which is async
    getName();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TextField(
            controller: textEditingController,
          ),
          ElevatedButton(
              onPressed: () async {
                //we are svaing the text entered by the user
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.setString(KEYNAME, textEditingController.text.toString());
              },
              child: const Text('Save')),
          Text(name),
        ],
      ),
    );
  }

  void getName() async {
    //get the stored text from shared preference
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var getName = prefs.getString(KEYNAME);

    setState(() {
      name = getName ??
          name; //for the first time when app runs getName will be null
    });
  }
}
