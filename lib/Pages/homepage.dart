import 'package:flutter/material.dart';

import '../Repo/UserExpense.dart';

void main() {
  runApp(const HomePage());
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  late double percentageColumn1 = 0; // Example percentage for column 1 (60%)
  late double percentageColumn2 = 0;
  String _expense = '';
  List<Expense> _expenseList = [];
  String _monthlyExpense = '';

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
  void initState() {
    super.initState();
    _loadExpenseData();
  }

  void _loadExpenseData() async {
    try {
      String expense = await getDailyExpenseTotal({'userId': '1'});
      List<Expense> expenseList = await getDailyExpenseDetails({'userId': '1'});
      String monthlyExpense = await getMonthlyExpenseTotal({'userId': '1'});
      setState(() {
        _expense = expense;
        percentageColumn1 = double.parse(expense) / 500;
        _expenseList = expenseList;
        _monthlyExpense = monthlyExpense;
        percentageColumn2 = double.parse(monthlyExpense) / 5500;
      });
    } catch (e) {
      print("Error Loading data: $e");
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
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Today',
                                style: TextStyle(fontSize: 10),
                              ), // Text 1
                              Text(
                                _expense,
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
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
                    thickness: 0.75, // Thickness of the divider
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
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Monthly',
                                style: TextStyle(fontSize: 10),
                              ),
                              Text(
                                _monthlyExpense,
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
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
          SizedBox(
            height: 500,
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: _expenseList.length,
                    itemBuilder: (context, index) {
                      final expense = _expenseList[index];
                      return Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    expense.description,
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    expense.categoryName,
                                    style: TextStyle(
                                        fontSize: 14.0, color: Colors.grey),
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              '${expense.amount}',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
