import 'package:flutter/material.dart';

class DialogAddDevice extends StatelessWidget {
  final String title;
  final Image image;

  DialogAddDevice({
    @required this.title,
    this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Consts.padding),
      ),      
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }

  dialogContent(BuildContext context) {
    return Stack(
      children: <Widget>[
        //...bottom card part,
        Container(
          padding: EdgeInsets.only(
            top: Consts.padding,
            bottom: Consts.padding,
            left: Consts.padding,
            right: Consts.padding,
          ),
          margin: EdgeInsets.only(top: Consts.avatarRadius),
          decoration: new BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(Consts.padding),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10.0,
                offset: const Offset(0.0, 10.0),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min, // To make the card compact
            children: <Widget>[
              Text(
                title,
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.w700,
                  color: Colors.black
                ),
              ),
              SizedBox(height: 16.0),
              TextField(
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  labelText: "Device Code",
                  labelStyle: TextStyle(color: Colors.blue),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                    borderRadius: BorderRadius.circular(16.0)
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                    borderRadius: BorderRadius.circular(16.0)
                  ),
                ),
              ),
              SizedBox(height: 24.0),
              Align(
                alignment: Alignment.bottomRight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    FlatButton(
                      color: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)
                      ),
                      onPressed: () {
                        Navigator.of(context).pop(); // To close the dialog
                      },
                      child: Text("Cancel"),
                    ),
                    SizedBox(width: 10,),
                    FlatButton(
                      color: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)
                      ),
                      onPressed: () {
                        Navigator.of(context).pop(); // To close the dialog
                      },
                      child: Text("Add"),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        //...top circlular image part,
        // Positioned(
        //   left: Consts.padding,
        //   right: Consts.padding,
        //   child: CircleAvatar(
        //     backgroundColor: Colors.blue,
        //     radius: Consts.avatarRadius,
        //   ),
        // ),
      ],
    );
  }
}

class Consts {
  Consts._();

  static const double padding = 16.0;
  static const double avatarRadius = 66.0;
}