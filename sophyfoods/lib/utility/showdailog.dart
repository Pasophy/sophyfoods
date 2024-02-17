import 'package:flutter/material.dart';
import 'package:sophyfoods/myconstant/myconstant.dart';

Future<void> mydialog(BuildContext context, String message) async {
  showDialog(
    context: context,
    builder: (context) => SimpleDialog(
      title: Text(message,style: TextStyle(color: Color(Myconstant().reds)),),
      children: [
        Row(
          mainAxisAlignment:MainAxisAlignment.end,
          children: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                'OK',
                style: TextStyle(
                  color: Color(Myconstant().reds),
                  fontSize: 20.0
                ),
              ),
            ),
          ],
        )
      ],
    ),
  );
}
