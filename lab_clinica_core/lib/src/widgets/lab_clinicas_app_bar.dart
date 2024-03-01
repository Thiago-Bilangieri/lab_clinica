import 'package:flutter/material.dart';

class LabClinicasAppBar extends AppBar {
  LabClinicasAppBar({super.key, List<Widget>? actions})
      : super(
            backgroundColor: Colors.transparent,
            toolbarHeight: 42,
            flexibleSpace: Container(
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(.5),
                      offset: Offset(0, 1),
                      blurRadius: 4),
                ],
              ),
              child: Padding(
                padding: EdgeInsets.only(left: 64),
                child: Image.asset('assets/images/logo_horizontal.png'),
              ),
            ),
            actions: actions);
}
