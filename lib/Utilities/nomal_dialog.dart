import 'package:flutter/material.dart';

Future<void> normalDialog(
    BuildContext context, String title, String massage) async {
  showDialog(
      context: context,
      builder: (BuildContext buildContext) {
        return AlertDialog(
          title: showTitile(title,massage),
          actions: [
            okButton(context),
          ],
        );
      });
}

Widget showTitile(String title,String massage) {
  return ListTile(
    leading: Icon((Icons.add_alert)),
    title: Text(title),
    subtitle: Text(massage),
  );
}
Widget okButton(BuildContext context){

  return FlatButton(
    child: Text('Ok'),
    onPressed: (){
      Navigator.of(context).pop();
    },
  );
}

