import 'package:fimto_frame/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../select_to_who_viewmodel.dart';

class GiftCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: context.read<SelectToWhoViewModel>().onGiftSelected,
      child: Container(
        child: Column(
          children: [
            Image(
              fit: BoxFit.fill,
              height: width > 600 ? 180 : 120,
              filterQuality: FilterQuality.high,
              image: AssetImage('assets/images/gift.png'),
            ),
            SizedBox(height: 6),
            Choice(
              selected: context.watch<SelectToWhoViewModel>().giftSelected,
              label: S.of(context).gift,
            ),
            SizedBox(height: 6),
            Text(
              S.of(context).forPerson,
              style: TextStyle(fontSize: 16, color: Color(0xFFbabdc5)),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 6),
            Text(
              S.of(context).noAdditionalExpenses,
              style: TextStyle(fontSize: 16, color: Color(0xFFbabdc5)),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 6),
          ],
        ),
      ),
    );
  }
}

class ForMeCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: context.read<SelectToWhoViewModel>().onForMeSelected,
      child: Container(
        child: Column(
          children: [
            Image(
              fit: BoxFit.fill,
              height: width > 600 ? 200 : 120,
              filterQuality: FilterQuality.high,
              image: AssetImage('assets/images/onboard2.png'),
            ),
            SizedBox(height: 6),
            Choice(
              selected: context.watch<SelectToWhoViewModel>().forMeSelected,
              label: S.of(context).forMe,
            ),
            SizedBox(height: 6),
            Text(
              S.of(context).decorateMyWall,
              style: TextStyle(fontSize: 16, color: Color(0xFFbabdc5)),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class Choice extends StatelessWidget {
  final String label;
  final bool selected;

  const Choice({Key? key, required this.label, required this.selected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: MediaQuery.of(context).size.width * 0.6,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
          color: Color(0xFFe4e4e4), borderRadius: BorderRadius.circular(25)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
                fontSize: 18,
                color: Color(0xFF62687a),
                fontWeight: FontWeight.w500),
            textAlign: TextAlign.center,
          ),
          Icon(Icons.radio_button_checked,
              color: selected ? Colors.green : Colors.grey)
        ],
      ),
    );
  }
}
