import 'package:coinector/Merchant.dart';
import 'package:coinector/Tags.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ItemInfoStackLayer extends StatelessWidget {
  const ItemInfoStackLayer({
    Key key,
    @required this.item,
    @required this.textStyleMerchantTitle,
    @required this.textStyleMerchantLocation,
    @required this.height,
  }) : super(key: key);

  final Merchant item;
  final TextStyle textStyleMerchantTitle;
  final TextStyle textStyleMerchantLocation;
  final double height;

  @override
  Widget build(BuildContext context) {
    var splittedtags = item.tags.split(",");
    return Container(
      height: height,
      child: Padding(
        padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 0.0),
        child: ListView(
          physics: const NeverScrollableScrollPhysics(),
          children: <Widget>[
            Text(
              item.name,
              style: textStyleMerchantTitle,
              maxLines: 1,
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              item.location,
              maxLines: 1,
              style: textStyleMerchantLocation,
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              //TODO make items fit on the card
              children: <Widget>[buildTagText(splittedtags)],
            ),
          ],
        ),
      ),
    );
  }

  Text buildTagText(List<String> splittedtags) {
    return Text(
        parseElementAt(splittedtags, 0) +
            parseElementAt(splittedtags, 1) +
            parseElementAt(splittedtags, 2) +
            parseElementAt(splittedtags, 3),
        style: TextStyle(
            fontSize: 15.0, fontWeight: FontWeight.w300, color: Colors.white));
  }

  String parseElementAt(splittedTags, int pos) {
    int tagIndex = int.parse(splittedTags.elementAt(pos));

    if (tagIndex == 104) return "";

    String addSeparator = "";
    if (pos != 0) addSeparator = "   ";

    return addSeparator + Tags.tagText.elementAt(tagIndex);
  }
}
