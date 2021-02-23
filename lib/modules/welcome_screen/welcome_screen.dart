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
              onPressed: (){},
            ),
            SizedBox(
              height: 16.0,
            ),
            buildButton(
              title: 'Assistant',
              onPressed: (){},
            ),
            SizedBox(
              height: 16.0,
            ),
            buildButton(
              title: 'Pharmacy',
              onPressed: (){},
            ),
            SizedBox(
              height: 16.0,
            ),
            buildButton(
              title: 'Laboratory',
              onPressed: (){},
            ),
            SizedBox(
              height: 16.0,
            ),
            buildButton(
              title: 'Ray Center',
              onPressed: (){},
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
