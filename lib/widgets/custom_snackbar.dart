import 'package:flutter/material.dart';

final snackBar = SnackBar(
  backgroundColor: Colors.transparent,
  elevation: 0,
  content: Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.greenAccent,
        border: Border.all(color: Colors.green, width: 3),
        boxShadow: const [
          BoxShadow(
            color: Color(0x19000000),
            spreadRadius: 2.0,
            blurRadius: 8.0,
            offset: Offset(2, 4),
          )
        ],
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        children: [
          const Icon(Icons.favorite, color: Colors.green),
          const Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Text('Yay! A SnackBar!\nYou did great!',
                style: TextStyle(color: Colors.green)),
          ),
          const Spacer(),
          TextButton(onPressed: () => debugPrint("Undid"), child: Text("Undo"))
        ],
      )),
);
