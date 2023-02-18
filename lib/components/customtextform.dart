

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class customTextForm extends StatelessWidget {
  String label;
  TextEditingController controller;
   customTextForm({Key? key,required this.label,required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      child: TextFormField(
        validator: (value){
          if(value!.isEmpty)
            {
              return "empty";
            }
          else
            {
              return null;
            }
        },

        controller: controller,
        decoration: InputDecoration(
          label: Text(label),

          border: OutlineInputBorder(

            //borderSide: BorderSide(color: Colors.black,width: 15),
            borderRadius: BorderRadius.circular(15)
          )
        ),
      ),
    );
  }
}
