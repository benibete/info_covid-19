import 'package:covid/model/contact_model.dart';
import 'package:covid/resources/style/text_styles.dart';
import 'package:covid/ui/assets/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ContactCard extends StatelessWidget {
  const ContactCard({Key key, @required this.contact, @required this.onTap})
      : super(key: key);

  final ContactModel contact;
  final Function(ContactModel) onTap;

  @override
  Widget build(BuildContext context) {
    assert(contact != null, 'contact cannot be null');

    return Theme(
      data: Theme.of(context).copyWith(
        dividerColor: Colors.transparent,
      ),
      child: Card(
        color: Covid19Colors.contactCardBackgroundGrey,
        elevation: 0.0,
        margin: const EdgeInsets.symmetric(vertical: 4.0),
        child: ListTileTheme(
          contentPadding: EdgeInsets.zero,
          child: ListTile(
            contentPadding: EdgeInsets.all(16.0),
            onTap: () => onTap(contact),
            title: Padding(
              padding: const EdgeInsets.only(top: 4.0, bottom: 8.0),
              child: Text(
                contact.title,
                style: Theme.of(context).textTheme.display2.copyWith(
                    fontSize: contact.textSize,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 0.35,
                    height: 22.6 / 28),
              ),
            ),
            subtitle: Text(
              contact.description,
              style: TextStyles.paragraphNormal(
                color: Covid19Colors.darkGreyLight,
              ).copyWith(letterSpacing: 0.2, height: 22.4 / 16),
            ),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                    padding: contact.contactType == ContactType.link
                        ? EdgeInsets.only(top: 8, right: 12)
                        : EdgeInsets.only(top: 8),
                    child: contact.icon),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
