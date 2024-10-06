import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  // Email address for "Contact Us"
  final String contactEmail = 'contact@profitpulse.com';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Profile Image
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/images/profile.jpg'), // Replace with your profile image asset
            ),
            SizedBox(height: 10),
            // User Name
            Text(
              'Sheldon Cooper',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: 'PoppinsMedium'
              ),
            ),
            SizedBox(height: 5),
            // Email
            Text(
              'sheldoncooper@gmail.com',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
                fontFamily: 'PoppinsMedium'
              ),
            ), 
            SizedBox(height: 20),
            // Navigation Options
            _buildProfileOption(
              context,
              'PROJECT - ProfitPulse',
              'assets/images/logo.png', // Replace with your home icon asset
              () {
                //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> Home()));
              },
            ),
            SizedBox(height: 10),
            _buildProfileOption(
              context,
              'profitpulse@gmail.com',
              'assets/images/mail.png', // Replace with your contact icon asset
              () {
                // Open email app with predefined email address
               
              },
            ),
           SizedBox(height: 10),
            _buildProfileOption(
              context,
              'profitpulse.vercel.app',
              'assets/images/website.png', // Replace with your contact icon asset
              () {
                // Open email app with predefined email address
               
              },
            ),
          ],
        ),
      ),
    );
  }

  // Widget to create profile option rows
  Widget _buildProfileOption(
    BuildContext context,
    String title,
    String iconPath,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            Image.asset(
              iconPath,
              height: 40,
              width: 40,
            ),
            SizedBox(width: 16),
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                fontFamily: 'PoppinsMedium'
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Method to launch email client
  void _launchEmail(String email) async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: email,
    );

    try {
      if (await canLaunchUrl(emailLaunchUri)) {
        await launchUrl(emailLaunchUri);
      } else {
        throw 'Could not launch $emailLaunchUri';
      }
    } catch (e) {
      print('Error launching email: $e');
    }
  }
}