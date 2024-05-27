import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../Repo/Data.dart';

void main() {
  runApp(const HomePage());
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  final double percentageColumn1 = 0.6; // Example percentage for column 1 (60%)
  final double percentageColumn2 = 0.3;
  List<User> _users = [];

  Color getColorForPercentage(double percentage) {
    if (percentage <= 0.5) {
      return Colors.green; // Green color for percentages <= 50%
    } else if (percentage <= 0.75) {
      return Colors.yellow; // Yellow color for percentages <= 75%
    } else {
      return Colors.red; // Red color for percentages > 75%
    }
  }

  @override
  void initState(){
    super.initState();
    _loadData();
  }


  void _loadData() async{
    try{
      List<User> users = await fetchUsers();
      print(users);
      setState(() {
        _users = users;
      });
    }
    catch(e){
      if (kDebugMode) {
        print("Error Loading data: $e");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: const [
          Icon(Icons.notifications), // Notification Icon on the right side
        ],
        title: const Text(
          "Hi, There",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ), // Title represents the app name
      ),
      body: Column(
        children: [
          SizedBox(
            height: 100,
            width: double.infinity,
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,

                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          CircularProgressIndicator(
                            value: percentageColumn1, // Set the value based on the given percentage
                            strokeWidth: 10, // Increase the thickness of the progress bar
                            backgroundColor: Colors.grey, // Background color of the progress bar
                            valueColor: AlwaysStoppedAnimation<Color>(getColorForPercentage(percentageColumn1)), // Color of the progress bar
                          ),

                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              Text(
                                'Today',
                                style: TextStyle(fontSize: 10),
                              ), // Text 1
                              Text(
                                "\$200",
                                style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                              ), // Text 2
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 40, // Adjust the height of the divider as needed
                  child: VerticalDivider(
                    color: Colors.grey, // Color of the divider
                    thickness: 0.5, // Thickness of the divider
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          CircularProgressIndicator(
                            value: percentageColumn2, // Set the value based on the given percentage
                            strokeWidth: 10, // Increase the thickness of the progress bar
                            backgroundColor: Colors.grey, // Background color of the progress bar
                            valueColor: AlwaysStoppedAnimation<Color>(getColorForPercentage(percentageColumn2)), // Color of the progress bar
                          ), // Progress bar for column 2

                          const Column(
                            children: [
                              Text(
                                'Text 1',
                                style: TextStyle(color: Colors.black),
                              ),
                              Text(
                                'Text 2',
                                style: TextStyle(color: Colors.black),

                              ),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 100,
            color: Colors.black,
            width: double.infinity,
            child: Center( // Remove 'const'
              child: Text(
                _users.isNotEmpty ? _users[0].name : 'No users found', // Display first user's name or a message
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}




