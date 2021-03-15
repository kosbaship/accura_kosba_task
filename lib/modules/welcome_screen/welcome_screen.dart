import 'package:accura_kosba_task/modules/doctor/doctor_setting_screen.dart';
import 'package:accura_kosba_task/modules/pharmacy/pharma_screen.dart';
import 'package:accura_kosba_task/shared/colors.dart';
import 'package:accura_kosba_task/shared/component.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kSecondaryColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: double.infinity,
            ),
            Text(
              'You are a...',
              style: TextStyle(
                  fontFamily: 'Poppins-Regular',
                  fontSize: 31,
                  color: kMainColor),
            ),
            SizedBox(
              height: 24.0,
            ),
            buildButton(
              title: 'Doctor',
              onPressed: (){
                navigateTo(context: context, goTO: DoctorSetting());
              },
            ),
            SizedBox(
              height: 16.0,
            ),
            buildButton(
              title: 'Assistant',
              onPressed: (){
                navigateTo(context: context, goTO: DoctorSetting());
              },
            ),
            SizedBox(
              height: 16.0,
            ),
            buildButton(
              title: 'Pharmacy',
              onPressed: (){
                navigateTo(context: context, goTO: PharmacyScreen());
              },
            ),
            SizedBox(
              height: 16.0,
            ),
            buildButton(
              title: 'Laboratory',
              onPressed: (){
                navigateTo(context: context, goTO: PharmacyScreen());
              },
            ),
            SizedBox(
              height: 16.0,
            ),
            buildButton(
              title: 'Ray Center',
              onPressed: (){
                navigateTo(context: context, goTO: PharmacyScreen());

              },
            ),
            SizedBox(
              height: 16.0,
            ),
          ],
        ),
      ),
    );
  }
}
