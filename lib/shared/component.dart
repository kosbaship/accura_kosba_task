import 'package:accura_kosba_task/models/get_doctor.dart';
import 'package:accura_kosba_task/network/api_provider.dart';
import 'package:accura_kosba_task/shared/styels.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'colors.dart';
import 'constants.dart';

// database initialization
void initApp() {
  APIProvider();
}

// divider
Widget drawDivider() => Divider(
      height: 2.0,
      color: kDividerColor,
      thickness: 2.0,
    );

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

Widget writeText14({@required title}) => Text(
      title,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: font14,
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

// card item
// Widget buildList({@required list}) => ListView.separated(
//       shrinkWrap: true,
//       itemCount: list.length,
//       itemBuilder: (BuildContext context, int index) {
//         //=====================================================
//         // here the trick we pass every list map with the index
//         // to the model class
//         return buildItem(Post(list[index]), context);
//         //=====================================================
//       },
//       separatorBuilder: (context, index) => drawDivider(),
//     );

// // card item
// Widget buildItem(Post post, BuildContext context) => Card(
//       elevation: 0,
//       margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
//       color: kForthColor,
//       child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           // this a good structure for a list item
//           child: ListTile(
//             // one
//             leading: Text(
//               post.id.toString(),
//             ),
//             //two
//             title: Text(
//               post.title,
//               maxLines: 2,
//               overflow: TextOverflow.ellipsis,
//             ),
//             //three
//             subtitle: Text(post.id.toString()),
//           )),
//     );

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
    FlatButton(
      onPressed: onPressed,
      color: kExpansionTitleColor,
      textColor: kSecondaryColor,
      child: Center(
        child: Text(
          title,
          style: TextStyle(
            fontSize: 12.0,
            fontFamily: 'Poppins-Regular',
          ),
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
    );

Widget buildSwitchBtn({
  @required bool value,
  @required Function onChanged,
}) =>
    CupertinoSwitch(
      activeColor: kExpansionTitleColor,
      value: value,
      onChanged: onChanged,
    );

Widget buildTextFormField(
        {@required TextEditingController controller,
        @required validator,
        keyboardType = TextInputType.number}) =>
    TextFormField(
      keyboardType: keyboardType,
      controller: controller,
      validator: validator,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(10.0, 0.0, 47.0, 0.0),
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

// textField
// Widget buildTextField({
//   @required String title,
//   @required IconData icon,
//   TextInputType keyboardType = TextInputType.text,
//   bool obscureText = false,
//   TextEditingController controller,
//   Function onChange,
// }) =>

// alertDialog (loading & error)
// void buildAlertDialog(
//         {@required BuildContext context,
//         @required String title,
//         error = false}) =>
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         contentPadding: EdgeInsets.all(8),
//         backgroundColor: kMainColor,
//         content: Container(
//           color: kForthColor,
//           child: Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Row(
//                   children: [
//                     if (!error)
//                       CircularProgressIndicator(
//                         backgroundColor: kForthColor,
//                       ),
//                     if (!error)
//                       SizedBox(
//                         width: 20.0,
//                       ),
//                     Expanded(
//                       child: Text(
//                         title,
//                         style: TextStyle(
//                           fontSize: 18.0,
//                           fontFamily: 'BoltRegular',
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 if (error) SizedBox(height: 20.0),
//                 if (error)
//                   buildButton(
//                     onPressed: () => Navigator.pop(context),
//                     title: "Cancel",
//                   ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );

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
  @required buildTDropdownButtonItems,
  @required buildTDropdownButtonOnChanged,
  @required dayShiftChooseDateFrom,
  @required dayShiftChooseDateTo,
  @required nightShiftChooseDateFrom,
  @required nightShiftChooseDateTo,
  @required drawCircleIconOnTap,
  @required buildButtonOnPressed,
  @required List<AvailabilityTimeList> availabilityTimeList,
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
            child: Form(
              key: key,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // switch button
                  Text(
                    'Activation',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: font14,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        buildSwitchBtnValue ? 'on' : 'Off',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: font14.copyWith(
                          color: kTitleGreyColor,
                        ),
                      ),
                      buildSwitchBtn(
                        value: buildSwitchBtnValue,
                        onChanged: buildSwitchBtnOnChange,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  drawDivider(),
                  SizedBox(
                    height: 16.0,
                  ),
                  // add price
                  Text(
                    'Pricing',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: font14,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'add price',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: font14.copyWith(color: kTitleGreyColor),
                      ),
                      Container(
                        width: 110,
                        child: Stack(
                          children: [
                            Positioned(
                              right: 9,
                              top: 8.5,
                              child: Text(
                                'EGP',
                                style: font12,
                              ),
                            ),
                            buildTextFormField(
                              controller: buildTextFieldController,
                              validator: buildTextFieldValidator,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  drawDivider(),
                  SizedBox(
                    height: 16.0,
                  ),
                  // choose day
                  Text(
                    'Available',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: font14,
                  ),
                  SizedBox(
                    height: 4.0,
                  ),
                  SizedBox(
                    height: 250,
                    child: ListView.separated(
                        itemBuilder: (context, index)  {
                          String selectedDay = 'Day';

                          // select the day from db
                          switch (availabilityTimeList[index].wdayDayName) {
                            case 'saturday':
                              selectedDay = kSaturday;
                              break;
                            case 'sunday':
                              selectedDay = kSunday;
                              break;
                            case 'monday':
                              selectedDay = kMonday;
                              break;
                            case 'tuesday':
                              selectedDay = kTuesday;
                              break;
                            case 'wednesday':
                              selectedDay = kWednesday;
                              break;
                            case 'thursday':
                              selectedDay = kThursday;
                              break;
                            case 'friday':
                              selectedDay = kFriday;
                              break;
                          }

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                            buildTDropdownButton(
                              items: buildTDropdownButtonItems,
                              onChanged: buildTDropdownButtonOnChanged,
                              value: selectedDay,
                            ),
                            SizedBox(
                              height: 16.0,
                            ),
                            // Day Shift
                            writeText14(title: 'Day Shift'),
                            SizedBox(
                              height: 4.0,
                            ),
                            chooseDateRow(
                                leftTitle: '${availabilityTimeList[index].wdayFrom}' ?? 'from',
                                leftOnTap: dayShiftChooseDateFrom,
                                rightTitle: '${availabilityTimeList[index].wdayTo}' ?? 'to',
                                rightOnTap: dayShiftChooseDateTo),
                            SizedBox(
                              height: 16.0,
                            ),
                            // Night Shift
                            Text(
                              'Night Shift',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: font14,
                            ),
                            SizedBox(
                              height: 4.0,
                            ),
                            chooseDateRow(
                                leftTitle: '${availabilityTimeList[index].wdayFrom2}' ?? 'from',
                                leftOnTap: nightShiftChooseDateFrom,
                                rightTitle: '${availabilityTimeList[index].wdayTo2}' ?? 'to',
                                rightOnTap: nightShiftChooseDateTo),

                          ],);
                        },
                        separatorBuilder: (context, index) => Column(
                          children: [
                            SizedBox(
                              height: 8.0,
                            ),
                            drawDivider(),
                            SizedBox(
                              height: 8.0,
                            ),
                          ],
                        ),
                        itemCount: availabilityTimeList.length
                    ),
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      drawCircleIcon(onTap: drawCircleIconOnTap ),
                      Container(
                        height: 50.0,
                        width: 150.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: kSecondaryColor,
                        ),
                        child: buildSaveButton(
                            onPressed: buildButtonOnPressed, title: 'Save Settings'),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
