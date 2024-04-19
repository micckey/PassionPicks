import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:passion_picks/config/custom_widgets.dart';
import 'package:passion_picks/config/style.dart';
import 'package:intl/intl.dart';
import '../../models/transaction_list_model.dart';

class HistoryPage extends StatefulWidget {
  final String? userId;

  const HistoryPage({
    super.key,
    this.userId,
  });

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  Future<List<TransactionList>> fetchTransactions() async {
    try {
      final response = await http.get(Uri.parse(
          'https://jay.john-muinde.com/view_transactions.php?user_id=${widget.userId}'));
      if (response.statusCode == 200) {
        final List<dynamic> responseData = json.decode(response.body);
        return responseData
            .map((data) => TransactionList.fromJson(data))
            .toList();
      } else {
        throw Exception('Failed to load transactions');
      }
    } catch (e) {
      throw Exception('Failed to fetch transactions: $e');
    }
  }

  Future<void> deleteTransaction(String transactionId) async {
    try {
      final response = await http.post(
        Uri.parse('https://jay.john-muinde.com/delete_transaction.php'),
        body: {'transaction_id': transactionId},
      );
      final responseData = json.decode(response.body);
      if (responseData['status'] == 'success') {
        print(responseData);
        return;
      } else {
        throw Exception('Failed to delete transaction');
      }
    } catch (e) {
      throw Exception('Failed to delete transaction: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBackgroundColor,
      body: FutureBuilder<List<TransactionList>>(
        future: fetchTransactions(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child: LoadingAnimationWidget.fourRotatingDots(
                    color: AppColors.secondaryBackgroundColor, size: 80));
          } else if (snapshot.hasError) {
            return const Center(child: Text('Experiencing trouble fetching data \u{1F615}'));
          } else {
            final transactions = snapshot.data!;
            if (transactions.isEmpty) {
              return Center(
                child: MyTextWidget(
                  myText: 'No transactions available',
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  fontColor: AppColors.menuTextColor,
                ),
              );
            } else {
              return ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: transactions.length,
                itemBuilder: (context, index) {
                  // Sort the transactions based on transaction date in descending order
                  transactions.sort(
                          (a, b) => b.transactionDate.compareTo(a.transactionDate));
                  final transaction = transactions[index];
                  DateFormat dateFormat = DateFormat('yyyy-MM-dd HH:mm:ss');
                  String formattedDate =
                  dateFormat.format(transaction.transactionDate);

                  return Container(
                    padding: const EdgeInsets.all(8),
                    margin:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    decoration: BoxDecoration(
                      color: AppColors.cardsColor,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    width: double.maxFinite,
                    height: 100,
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: Image.asset(
                            transaction.image,
                            height: double.maxFinite,
                            width: 100,
                            fit: BoxFit.fill,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            MyTextWidget(
                              myText: transaction.name,
                              fontSize: 18.0,
                              fontWeight: FontWeight.w600,
                              fontColor: AppColors.menuIconsColor,
                            ),
                            MyTextWidget(
                              myText:
                              'Ksh${int.parse(transaction.price) * int.parse(transaction.quantity)}',
                              fontSize: 20.0,
                              fontWeight: FontWeight.w700,
                              fontColor: AppColors.menuIconsColor,
                            ),
                            Expanded(child: Container()),
                            MyTextWidget(
                              myText: formattedDate,
                              fontSize: 15.0,
                              fontWeight: FontWeight.w500,
                              fontColor: AppColors.menuIconsColor,
                            ),
                          ],
                        ),
                        Expanded(child: Container()),
                        GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  backgroundColor: AppColors.feedbackColor,
                                  title: const Text('Alert!'),
                                  content: MyTextWidget(
                                    myText:
                                    'Do you want to delete this transaction?',
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w600,
                                    fontColor: AppColors.menuTextColor,
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.of(context).pop(),
                                      child: MyTextWidget(
                                        myText: 'Cancel',
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w900,
                                        fontColor: AppColors.menuIconsColor,
                                      ),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        deleteTransaction(
                                            transaction.transactionId)
                                            .then((_) {
                                          setState(() {});
                                          Get.back();
                                        });
                                      },
                                      style: ButtonStyle(
                                        backgroundColor:
                                        MaterialStateProperty.all(
                                            AppColors.cardsColor),
                                      ),
                                      child: MyTextWidget(
                                        myText: 'Yes',
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w900,
                                        fontColor: AppColors.menuIconsColor,
                                      ),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          child: Icon(
                            Icons.delete_forever,
                            color: AppColors.feedbackColor,
                            size: 35,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            }
          }
        },
      ),
    );
  }
}
