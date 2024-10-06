import 'package:flutter/material.dart';

class ProjectDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Project'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Project Logo and Name
            Row(
              children: [
                Image.asset(
                  'assets/images/logo.png', // Ensure to add the logo image to your assets folder
                  height: 100.0,
                ),
                SizedBox(width: 10.0),
                Text(
                  'ProfitPulse',
                  style: TextStyle(
                    fontSize: 28.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'PoppinsMedium'
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.0),
            // About Section
            Text(
              'About',
              style: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'PoppinsMedium'
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              'Profit Pulse is a comprehensive financial calculator app designed to empower users with easy access to essential financial tools. It includes a suite of calculators for investment tracking, loan/EMI calculations, currency conversion, and income tax estimation. Profit Pulse helps users make informed financial decisions by simplifying complex calculations and providing real-time insights.',
              style: TextStyle(
                fontSize: 15.0,
                height: 1.75,
                fontFamily: 'PoppinsMedium',
                color: Colors.grey[800],
              ),
              textAlign: TextAlign.justify,
              
            ),
            SizedBox(height: 30.0),
            // Features Section
            Text(
              'Features',
              style: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildFeatureIcon('assets/images/banks.png', 'Banks'),
                _buildFeatureIcon('assets/images/interest.png', 'Interest'),
                _buildFeatureIcon('assets/images/profit.png', 'Profit'),
                _buildFeatureIcon('assets/images/easy.png', 'Accessible'),
              ],
            ),
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildFeatureIcon('assets/images/invest.png', 'Investment'),
                _buildFeatureIcon('assets/images/loan.png', 'Loan/EMI'),
                _buildFeatureIcon('assets/images/currency.png', 'Currency'),
                _buildFeatureIcon('assets/images/tax.png', 'Income Tax'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureIcon(String assetPath, String label) {
    return Column(
      children: [
        Image.asset(
          assetPath, // Ensure to add the feature icons to your assets folder
          height: 50.0,
        ),
        SizedBox(height: 5.0),
        Text(
          label,
          style: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'PoppinsMedium'
          ),
        ),
      ],
    );
  }
}
