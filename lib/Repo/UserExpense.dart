import 'dart:convert';

import 'package:http/http.dart' as http;

Future<String> getDailyExpenseTotal(Map<String, String> params) async {
  final response = await http.get(
      Uri.parse('http://10.0.2.2:8080/api/expense/user/daily')
          .replace(queryParameters: params));
  if (response.statusCode == 200) {
    return response.body;
  }
  return "null";
}

class Expense {
  final String expenseId;
  final String description;
  final String categoryName;
  final String amount;
  final String categoryId;

  Expense({
    required this.expenseId,
    required this.description,
    required this.categoryName,
    required this.amount,
    required this.categoryId,
  });

  factory Expense.fromJson(Map<String, dynamic> json) {
    return Expense(
      expenseId: json['expenseId'],
      description: json['description'],
      categoryName: json['categoryName'],
      amount: json['amount'],
      categoryId: json['categoryId'],
    );
  }
}

Future<List<Expense>> getDailyExpenseDetails(Map<String, String> params) async {
  final response = await http.get(
      Uri.parse('http://10.0.2.2:8080/api/expense/user/daily/details')
          .replace(queryParameters: params));
  final Map<String, dynamic> data = jsonDecode(response.body);
  final List<dynamic> expenseList = data['expense'];
  return expenseList.map((json) => Expense.fromJson(json)).toList();
}

Future<String> getMonthlyExpenseTotal(Map<String, String> params) async {
  final response = await http.get(
      Uri.parse('http://10.0.2.2:8080/api/expense/user/monthly')
          .replace(queryParameters: params));
  if (response.statusCode == 200) {
    return response.body;
  }
  return "null";
}
