import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:akashganga/exoplanets.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';

class NavigationPage extends StatefulWidget {
  @override
  _NavigationPageState createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  int _currentIndex = 0;
  PageController _pageController = PageController();

  // Method to handle bottom navigation bar tap
  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
    _pageController.animateToPage(index,
        duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
  }

  // When the page is swiped horizontally, update the bottom navigation index
  void _onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Ionicons.cloud_done_outline, size: 28),
          color: Colors.white,
          onPressed: () {
            // Add functionality if needed
          },
        ),
        title: Text(
          'AkashGanga',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: 'PoppinsBold',
            color: Colors.white,
            fontSize: 24,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Ionicons.settings_outline, size: 28),
            color: Colors.white,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProjectDetailsPage()),
              );
            },
          ),
        ],
        backgroundColor: Colors.black,
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: _onPageChanged,
        children: <Widget>[
          HomePage(),
          ExoplanetPage(),
          ProfilePage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Ionicons.home_outline),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Ionicons.planet_outline),
            label: 'Exoplanets',
          ),
          BottomNavigationBarItem(
            icon: Icon(Ionicons.person_outline),
            label: 'Profile',
          ),
        ],
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.black,
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}

// Home Page Code
class HomePage extends StatelessWidget {
  final List<Map<String, String>> exoplanets = [
    {'name': 'PROXIMA CENTAURI B', 'image': 'assets/images/proxima.png'},
    {'name': 'KELPER 425 B', 'image': 'assets/images/kelper425.png'},
    {'name': 'LP-791-18 D', 'image': 'assets/images/lp791.png'},
    {'name': 'LHS 1140 B', 'image': 'assets/images/lhs1140.png'},
    {'name': '55 CANCRI E', 'image': 'assets/images/55cancrie.png'},
    {'name': 'KELPER 22 B', 'image': 'assets/images/kelper22.png'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // Add the background image here
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/appbg.png'), // Your background image
            fit: BoxFit.cover, // Cover the whole screen
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.85,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            itemCount: exoplanets.length,
            itemBuilder: (context, index) {
              final exoplanet = exoplanets[index];
              return Column(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: AssetImage(exoplanet['image']!),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    exoplanet['name']!,
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white, fontFamily: 'PoppinsMedium'),
                    textAlign: TextAlign.center,
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}


//ExoPlanets Class
class ExoplanetPage extends StatefulWidget {
  @override
  _ExoplanetPageState createState() => _ExoplanetPageState();
}

class _ExoplanetPageState extends State<ExoplanetPage> {
  int currentExoplanetIndex = 0;

  final List<String> exoplanets = [
    'Proxima Centauri B',
    'Kepler 425 B',
    'Kepler 22 B',
    'LP-791-18D',
    'LHS 1140 B',
    '55 Cancri E',
  ];

  final List<String> exoplanetModels = [
    'assets/proxima_b.glb', 
    'assets/kepler.glb',
    'assets/kepler_22b.glb',
    'assets/lp_791.glb',
    'assets/lhs.glb',
    'assets/55_cancri_e.glb',
  ];

  void _showPreviousExoplanet() {
    setState(() {
      currentExoplanetIndex =
          (currentExoplanetIndex - 1 + exoplanets.length) % exoplanets.length;
    });
  }

  void _showNextExoplanet() {
    setState(() {
      currentExoplanetIndex = (currentExoplanetIndex + 1) % exoplanets.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Image.asset(
              'assets/images/appbg.png',
              fit: BoxFit.cover,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Model Viewer for 3D model
              Expanded(
                child: Center(
                  child: ModelViewer(
                    key: ValueKey(currentExoplanetIndex),  // Use a key to force re-render
                    src: exoplanetModels[currentExoplanetIndex],
                    alt: "A 3D model of ${exoplanets[currentExoplanetIndex]}",
                    ar: true,
                    autoRotate: true,
                    cameraControls: true,
                    //height: 300,
                    //width: 300,
                  ),
                ),
              ),
              SizedBox(height: 20),
              // Name of the exoplanet
              Text(
                exoplanets[currentExoplanetIndex],
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              // Arrow buttons for navigation
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_left, color: Colors.white, size: 40),
                    onPressed: _showPreviousExoplanet,
                  ),
                  IconButton(
                    icon: Icon(Icons.arrow_right, color: Colors.white, size: 40),
                    onPressed: _showNextExoplanet,
                  ),
                ],
              ),
              SizedBox(height: 20),
            ],
          ),
        ],
      ),
    );
  }
}

//Profile Class
class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/profilebg.png'), // Replace with your background image path
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Profile Content
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage('assets/images/profile.jpg'), // Replace with your profile image path
                ),
                SizedBox(height: 20),
                Text(
                  'CHIRAG FERWANI',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'chiragferwani@gmail.com',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.location_on, color: Colors.white),
                    SizedBox(width: 5),
                    Text(
                      'Pune, Maharashtra',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Dummy ProjectDetailsPage for settings
class ProjectDetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.white, // Back arrow icon
          onPressed: () {
            Navigator.pop(context); // Redirect to the previous page (home)
          },
        ),
        title: Text(
          'Project Details',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: 'PoppinsBold',
            color: Colors.white,
            fontSize: 24,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.black, // Adjust AppBar color
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/detailsbg.png'), // Your background image here
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 30), // Space from the top
            Container(
              height: 100, // Adjust height for the logo
              width: 100, // Adjust width for the logo
              child: Image.asset('assets/images/logo.png', fit: BoxFit.contain), // Your project logo here
            ),
            SizedBox(height: 20),
            Text(
              'AKASHGANGA',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                fontFamily: 'PoppinsBold',
                color: Colors.white, // Adjust color for visibility
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'AkashGanga is a cutting-edge app that allows users to explore exoplanets through immersive 3D models. With an intuitive interface and elegant design, users can navigate a curated database of exoplanets, enjoying an engaging and educational experience in the universe.',
                textAlign: TextAlign.justify, // Justify text
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'PoppinsMedium',
                  color: Colors.white, // Adjust color for visibility
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
