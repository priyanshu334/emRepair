import 'package:flutter/material.dart';
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
    return BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.phone),
          label: 'Phone',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.message),
          label: 'Message',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.phone_android),
          label: 'WhatsApp',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.print),
          label: 'Printout',
        ),
      ],
      currentIndex: selectedIndex,
      onTap: (index) {
        _launchApp(index); // Launch app on tap
        onItemTapped(index); // Call the callback function
      },
      selectedItemColor: Colors.pink,
      unselectedItemColor: Colors.grey,
      showUnselectedLabels: true,
      type: BottomNavigationBarType.fixed,
    );
  }
}
