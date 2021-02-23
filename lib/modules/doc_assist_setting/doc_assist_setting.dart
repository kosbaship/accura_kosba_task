import 'package:accura_kosba_task/shared/colors.dart';
import 'package:accura_kosba_task/shared/component.dart';
import 'package:accura_kosba_task/shared/styels.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';

class DocAssistSetting extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kSecondaryColor,
      appBar: drawAppBar(context: context),
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
                color: kMainColor,
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
              initiallyExpanded: true,
              elevation: 0.0,
              title: Text(
                'Clinic',
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
                        )
                      )),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Column(
                            children: [
                              Text(
                                'Clinic',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: font14,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
