import 'package:covid/generated/l10n.dart';
import 'package:covid/model/contact_model.dart';
import 'package:covid/resources/icons_svg.dart';
import 'package:covid/ui/assets/colors.dart';
import 'package:covid/ui/screens/contacts/components/contact_card.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactsPage extends StatefulWidget {
  @override
  _ContactsPageState createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  final List<ContactModel> _contacts = <ContactModel>[];

  @override
  Widget build(BuildContext context) {
    if (_contacts.isEmpty) {
      _initContacts();
    }

    return Scaffold(
      appBar: AppBar(
        iconTheme:
            Theme.of(context).iconTheme.copyWith(color: Covid19Colors.white),
        title: Text(
          S.of(context).contactsPageTitle.toUpperCase(),
          style: Theme.of(context)
              .textTheme
              .display2
              .copyWith(color: Covid19Colors.white),
        ),
        backgroundColor: Covid19Colors.blue,
        elevation: 0.0,
      ),
      body: Container(
        margin: EdgeInsets.all(12.0),
        child: ListView.builder(
            itemCount: _contacts.length,
            itemBuilder: (context, index) {
              var contact = _contacts[index];

              return ContactCard(
                contact: contact,
                onTap: _onContactTap,
              );
            }),
      ),
    );
  }

  _initContacts() {
    _contacts
      ..add(ContactModel(
          contactType: ContactType.phone,
          title: S.of(context).contactsPageSNSNumber,
          description: S.of(context).contactsPageSNSNumberText,
          icon: SvgIcons.phoneSvg))
      ..add(ContactModel(
          contactType: ContactType.phone,
          title: S.of(context).contactsPageSSNumber,
          description: S.of(context).contactsPageSSNumberText,
          icon: SvgIcons.phoneSvg))
      ..add(ContactModel(
          contactType: ContactType.phone,
          title: S.of(context).contactsPageMNENumber,
          description: S.of(context).contactsPageMNENumberText,
          icon: SvgIcons.phoneSvg))
      ..add(ContactModel(
          contactType: ContactType.phone,
          title: S.of(context).contactsPageMSWeb,
          description: S.of(context).contactsPageMSWebText,
          icon: SvgIcons.phoneSvg))
      ..add(ContactModel(
          contactType: ContactType.phone,
          title: S.of(context).contactsPageSNSEmail,
          description: S.of(context).contactsPageSNSEmailText,
          icon: SvgIcons.phoneSvg))
      ..add(ContactModel(
          contactType: ContactType.phone,
          title: S.of(context).contactsPageMNEEmail,
          description: S.of(context).contactsPageMNEEmailText,
          icon: SvgIcons.phoneSvg));
  }

  _onContactTap(ContactModel contact) {
    switch (contact.contactType) {
      case ContactType.phone:
        _launch("tel:${contact.title.replaceAll(RegExp(r'[^0-9+]'), '')}");
        break;
      case ContactType.link:
        var urlToOpen = contact.title;
        if (!(contact.title.startsWith("https://") ||
            contact.title.startsWith("http://"))) {
          urlToOpen = "https://${contact.title}";
        }

        _launch(urlToOpen);
        break;
      case ContactType.email:
        _launch("mailto: ${contact.title}");
        break;
    }
  }

  _launch(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
