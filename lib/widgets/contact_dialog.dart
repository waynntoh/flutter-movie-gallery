import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactDialog extends StatefulWidget {
  @override
  _ContactDialogState createState() => _ContactDialogState();
}

class _ContactDialogState extends State<ContactDialog> {
  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      contentPadding: const EdgeInsets.all(12),
      backgroundColor: Colors.white,
      title: Text('Get in touch!'),
      titleTextStyle: GoogleFonts.arvo().copyWith(
        fontSize: 20,
      ),
      children: [
        ListTile(
          leading: FaIcon(
            FontAwesomeIcons.linkedin,
            color: Color(0xFF0E76A8),
            size: 28,
          ),
          title: Text('LinkedIn'),
          onTap: () => _launchInBrowser('https://linkedin.com/in/waynn-toh'),
        ),
        ListTile(
          leading: FaIcon(
            FontAwesomeIcons.github,
            color: Colors.black87,
            size: 28,
          ),
          title: Text('GitHub'),
          onTap: () => _launchInBrowser('https://github.com/waynntoh'),
        ),
        ListTile(
          leading: FaIcon(
            FontAwesomeIcons.stackOverflow,
            color: Color(0xFFF48024),
            size: 28,
          ),
          title: Text('Stack Overflow'),
          onTap: () => _launchInBrowser(
              'https://stackoverflow.com/users/12035327/waynn-toh'),
        )
      ],
    );
  }

  Future<void> _launchInBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: false,
        forceWebView: false,
      );
      Navigator.pop(context);
    } else {
      throw 'Could not launch $url';
    }
  }
}
