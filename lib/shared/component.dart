import 'package:accura_kosba_task/network/api_provider.dart';
import 'package:accura_kosba_task/shared/styels.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'colors.dart';

// database initialization
void initApp() {
  APIProvider();
}

// divider
class DrawFancyDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Divider(
      height: 2.0,
      color: kDividerColor,
      thickness: 2.0,
    );
  }
}

Widget chooseDateRow(
        {@required Function leftOnTap,
        @required String leftTitle,
        @required String rightTitle,
        @required Function rightOnTap}) =>
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: chooseDate(title: leftTitle, onTap: leftOnTap),
        ),
        SizedBox(
          width: 16.0,
        ),
        Expanded(
          child: chooseDate(title: rightTitle, onTap: rightOnTap),
        ),
      ],
    );

Widget writeText14({@required title, maxLines = 1}) => Text(
      title,
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
      style: font14,
      textAlign: TextAlign.center,
    );

Widget chooseDate({
  @required Function onTap,
  @required String title,
}) =>
    InkWell(
      splashColor: kTitleGreyColor,
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(
              const Radius.circular(24.0),
            ),
            color: kSecondaryColor,
            border: Border.all(
              width: 1,
              color: kTitleGreyColor,
            )),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: font14.copyWith(
                color: kTitleGreyColor,
              ),
            ),
            ClipOval(
              child: SizedBox(
                width: 20,
                height: 20,
                child: Image.asset('assets/images/clocicon.png'),
              ),
            ),
          ],
        ),
      ),
    );

// draw circle icon or image
Widget drawCircleIcon({@required onTap}) => ClipOval(
      child: Material(
        color: kExpansionTitleColor, // button color
        child: InkWell(
          splashColor: kTitleGreyColor, // inkwell color
          child: SizedBox(
            width: 40,
            height: 40,
            child: Icon(
              Icons.add,
              color: kSecondaryColor,
              size: 40.0,
            ),
          ),
          onTap: onTap,
        ),
      ),
    );

// draw simple app bar
Widget drawAppBar({@required BuildContext context}) => AppBar(
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios_outlined, color: kSecondaryColor),
        onPressed: () => Navigator.of(context).pop(),
      ),
      title: Text(
        'Setting',
        style: TextStyle(
          fontSize: 16.0,
          fontFamily: 'Poppins-Regular',
        ),
      ),
      centerTitle: true,
    );

// toast
showToast({@required String message, @required bool error}) =>
    Fluttertoast.showToast(
        msg: " $message ",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: error ? kSecondaryColor : kMainColor,
        textColor: kSecondaryColor,
        fontSize: 16.0);

// button
Widget buildButton({
  @required String title,
  @required Function onPressed,
}) =>
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Container(
        height: 50.0,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: kSecondaryColor,
            border: Border.all(
              width: 1,
              color: kButtonBorderColor,
            )),
        child: FlatButton(
          onPressed: onPressed,
          color: kSecondaryColor,
          textColor: kMainColor,
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 20.0,
                fontFamily: 'Poppins-Regular',
              ),
            ),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
        ),
      ),
    );
// button
Widget buildSaveButton({
  @required String title,
  @required Function onPressed,
}) =>
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: RawMaterialButton(
        onPressed: onPressed,
        fillColor: kExpansionTitleColor,
        splashColor: kExpansionBorderColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24),
          child: Text(
            title,
            style: TextStyle(
                fontSize: 12.0,
                fontFamily: 'Poppins-Regular',
                color: kSecondaryColor),
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
      ),
    );
// button
Widget buildRemoveButton({
  @required String title,
  @required Function onPressed,
}) =>
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: FlatButton(
        onPressed: onPressed,
        color: kRemoveColor,
        textColor: kSecondaryColor,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              title,
              style: TextStyle(
                fontSize: 12.0,
                fontFamily: 'Poppins-Regular',
              ),
            ),
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
      ),
    );

Widget buildPriceTextFormField(
        {@required TextEditingController controller,
        validator,
        onChanged,
        keyboardType = TextInputType.number,
        double startPadding = 10.0}) =>
    TextFormField(
      keyboardType: keyboardType,
      controller: controller,
      validator: validator,
      onChanged: onChanged,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(startPadding, 0.0, 47.0, 0.0),
        border: OutlineInputBorder(
          borderRadius: const BorderRadius.all(
            const Radius.circular(24.0),
          ),
        ),
      ),
    );

Widget buildTDropdownButton({
  @required items,
  @required onChanged,
  @required value,
}) =>
    Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            const Radius.circular(24.0),
          ),
          color: kSecondaryColor,
          border: Border.all(
            width: 1,
            color: kTitleGreyColor,
          )),
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
          elevation: 0,
          isExpanded: true,
          icon: Icon(
            Icons.keyboard_arrow_down_outlined,
            size: 40,
          ),
          style: font14.copyWith(
            color: kTitleGreyColor,
          ),
          items: items,
          onChanged: onChanged,
          value: value,
        ),
      ),
    );

// navigation
void navigateTo({@required BuildContext context, @required Widget goTO}) =>
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => goTO,
      ),
    );

void navigateToReplaceMe(
        {@required BuildContext context, @required Widget widget}) =>
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );

void navigateAndFinish(
        {@required BuildContext context, @required Widget widget}) =>
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => widget,
        ),
        (Route<dynamic> route) => false);

Widget buildExpandedCard({
  @required String expansionTitle,
  @required key,
  @required buildSwitchBtnValue,
  @required buildSwitchBtnOnChange,
  @required buildTextFieldController,
  @required buildTextFieldValidator,
  @required drawCircleIconOnTap,
  @required buildButtonOnPressed,
  @required list,
  bool initiallyExpanded = false,
}) =>
    Container(
      decoration: BoxDecoration(
          border: Border(
        top: BorderSide(
          width: 1,
          color: kExpansionBorderColor,
        ),
      )),
      child: ExpansionTileCard(
        borderRadius: BorderRadius.all(Radius.circular(0)),
        finalPadding: EdgeInsets.zero,
        baseColor: kExpansionBGColor,
        expandedColor: kExpansionBGColor,
        initiallyExpanded: initiallyExpanded,
        elevation: 0.0,
        title: Text(
          expansionTitle,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: font18.copyWith(color: kExpansionTitleColor),
        ),
        onExpansionChanged: (value) {},
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14),
            decoration: BoxDecoration(
                color: kSecondaryColor,
                border: Border(
                    top: BorderSide(
                  width: 1,
                  color: kExpansionBorderColor,
                ))),
            child: Container(),
          ),
        ],
      ),
    );
