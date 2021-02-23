import 'package:accura_kosba_task/models/post.dart';
import 'package:accura_kosba_task/network/api_provider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'colors.dart';

// database initialization
void initApp() {
  APIProvider();
}

// divider
Widget drawDivider() => Divider(
      height: 1.0,
      color: kMainColor,
      thickness: 1.0,
    );
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
              color: kThirdColor,
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

// textField
Widget buildTextField({
  @required String title,
  @required IconData icon,
  TextInputType keyboardType = TextInputType.text,
  bool obscureText = false,
  TextEditingController controller,
  Function onChange,
}) =>
    TextFormField(
      keyboardType: keyboardType,
      obscureText: obscureText,
      controller: controller,
      onChanged: onChange,
      decoration: InputDecoration(
        hintText: "Enter your $title",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Icon(icon),
        labelText: title,
        labelStyle: TextStyle(
          fontSize: 16.0,
        ),
        hintStyle: TextStyle(color: kTitleDarkColor, fontSize: 10),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide: BorderSide(color: kSecondaryColor, width: 2),
          gapPadding: 10,
        ),
      ),
      style: TextStyle(fontSize: 14.0, color: kSecondaryColor),
    );

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


// Widget buildExpandedCard({@required Function startToday, @required String price, @required ImageProvider<Object> image, @required String title, @required String startDate, @required String description, bool initiallyExpanded = false,}) =>