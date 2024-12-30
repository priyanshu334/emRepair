import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class BottomNav extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const BottomNav({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  // Function to launch different apps based on index
  void _launchApp(int index) async {
    final Uri phoneUri = Uri(scheme: 'tel', path: '1234567890'); // Phone number to dial
    final Uri messageUri = Uri(scheme: 'sms', path: '1234567890'); // Phone number for SMS
    final Uri whatsappUri = Uri.parse('https://wa.me/1234567890'); // WhatsApp link
    final Uri printUri = Uri.parse('https://example.com'); // Placeholder for Printout

    try {
      switch (index) {
        case 0: // Phone
          if (!await launchUrl(phoneUri)) {
            throw 'Could not launch $phoneUri';
          }
          break;
        case 1: // Message
          if (!await launchUrl(messageUri)) {
            throw 'Could not launch $messageUri';
          }
          break;
        case 2: // WhatsApp
          if (!await launchUrl(whatsappUri)) {
            throw 'Could not launch $whatsappUri';
          }
          break;
        case 3: // Printout
          if (!await launchUrl(printUri)) {
            throw 'Could not launch $printUri';
          }
          break;
        default:
          break;
      }
    } catch (e) {
      debugPrint('Error launching URL: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.pink.shade400, Colors.pink.shade700],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.phone,
              size: 30,
              color: selectedIndex == 0 ? Colors.white : Colors.white70,
            ),
            label: 'Phone',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.message,
              size: 30,
              color: selectedIndex == 1 ? Colors.white : Colors.white70,
            ),
            label: 'Message',
          ),
          BottomNavigationBarItem(
            icon: FaIcon(
              FontAwesomeIcons.whatsapp,
              size: 30,
              color: selectedIndex == 2 ? Colors.white : Colors.white70,
            ),
            label: 'WhatsApp',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.print,
              size: 30,
              color: selectedIndex == 3 ? Colors.white : Colors.white70,
            ),
            label: 'Printout',
          ),
        ],
        currentIndex: selectedIndex,
        onTap: (index) {
          _launchApp(index); // Launch app on tap
          onItemTapped(index); // Call the callback function
        },
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.transparent,
        elevation: 10,
      ),
    );
  }
}
