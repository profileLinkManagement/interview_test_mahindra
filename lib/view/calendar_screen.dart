import 'dart:math';

import 'package:flutter/material.dart';
import 'package:interview_test_mahindra/utils/convertor.dart';
import 'package:interview_test_mahindra/widgets/multi_selection_date_widget.dart';
import 'package:intl/intl.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool isClearFilter = true;
  DateTime? fromDate;
  DateTime? toDate;
  List<DateTime>? dateList;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        foregroundColor: Colors.black87,
        title: Text(
          "My Calendar",
          style: Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(fontWeight: FontWeight.normal, color: Colors.black87),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: MultiSelectionDateWidget(
              onRangeSelection: (DateTime fromDate, DateTime toDate) {
                setState(() {
                  isClearFilter = false;
                  this.fromDate = fromDate;
                  this.toDate = toDate;
                  dateList = Convertor.convertDateToDays(fromDate, toDate);
                  print(
                      "PSP ==>> ${fromDate.toString()} || ${toDate.toString()}");
                });
              },
              onClearRangeSelection: () {
                setState(() {
                  isClearFilter = true;
                  dateList = null;
                });
              },
            ),
            // child: SingleSelectDateWidget(),
          ),
          Expanded(
            child: Card(
              child: Column(
                children: [
                  TabBar(
                    controller: _tabController,
                    tabs: const [
                      Tab(text: 'All'),
                      Tab(text: 'HRD'),
                      Tab(text: 'Tech 1'),
                      Tab(text: 'Follow up'),
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        allBody(),
                        hrdBody(),
                        techBody(),
                        followUpBody(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget allBody() {
    if(isClearFilter) {
      return const Center(child: Text("Please select date"));
    }

    if(dateList != null && (dateList?.isNotEmpty ?? false)) {
      return ListView.builder(
        itemBuilder: (context, index) {
          final item = dateList![index];
          final day = DateFormat('d').format(item).toString();
          final month = DateFormat('MMM').format(item).toString();
          return LayoutBuilder(
            builder: (context, cons) {
              return Card(
                margin: const EdgeInsets.all(16.0),
                child: Container(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 12.0, right: 12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Text(day, style: const TextStyle(fontWeight: FontWeight.w500),),
                          const SizedBox(height: 4.0,),
                          Text(month, style:  const TextStyle(fontWeight: FontWeight.w500),),
                        ],
                      ),
                      // const Spacer(),


                      Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(20.0),
                            decoration: BoxDecoration(
                              color: Colors.white, // Background color
                              border: Border.all(
                                color: Colors.grey,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(cons.maxWidth * 0.8), // Rounded corners
                            ),
                            child: Text(
                              _getRandomNumber(),
                              style: const TextStyle(
                                color: Colors.grey, // Text color
                                fontSize: 12.0, // Text size
                              ),
                            ),
                          ),
                          const Text(
                            "HRD",
                            style: TextStyle(
                              color: Colors.grey, // Text color
                              fontSize: 12.0, // Text size
                            ),
                          ),
                        ],
                      ),
                      // const Spacer(),

                      Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(20.0),
                            decoration: BoxDecoration(
                              color: Colors.white, // Background color
                              border: Border.all(
                                color: Colors.grey,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(cons.maxWidth * 0.8), // Rounded corners
                            ),
                            child: Text(
                              _getRandomNumber(),
                              style: const TextStyle(
                                color: Colors.grey, // Text color
                                fontSize: 12.0, // Text size
                              ),
                            ),
                          ),
                          const Text(
                            "Tech 1",
                            style: TextStyle(
                              color: Colors.grey, // Text color
                              fontSize: 12.0, // Text size
                            ),
                          ),
                        ],
                      ),
                      // const Spacer(),

                      Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(20.0),
                            decoration: BoxDecoration(
                              color: Colors.white, // Background color
                              border: Border.all(
                                color: Colors.grey,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(cons.maxWidth * 0.8), // Rounded corners
                            ),
                            child: Text(
                              _getRandomNumber(),
                              style: const TextStyle(
                                color: Colors.grey, // Text color
                                fontSize: 12.0, // Text size
                              ),
                            ),
                          ),
                          const Text(
                            "Follow up",
                            style: TextStyle(
                              color: Colors.grey, // Text color
                              fontSize: 12.0, // Text size
                            ),
                          ),
                        ],
                      ),
                      // const Spacer(),


                      Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(20.0),
                            decoration: BoxDecoration(
                              color: Colors.black, // Background color
                              border: Border.all(
                                color: Colors.black,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(cons.maxWidth * 0.8), // Rounded corners
                            ),
                            child: Text(
                              _getRandomNumber(),
                              style: const TextStyle(
                                color: Colors.white, // Text color
                                fontSize: 12.0, // Text size
                              ),
                            ),
                          ),
                          const Text(
                            "Total",
                            style: TextStyle(
                              color: Colors.grey, // Text color
                              fontSize: 12.0, // Text size
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }
          );
        },
        itemCount: dateList!.length,
      );
    }

    return const Center(child: Text("Something went wrong. Please re-select dates"));
  }

  Widget hrdBody() {
    return Container();
  }

  Widget techBody() {
    return Container();
  }

  Widget followUpBody() {
    return Container();
  }


  String _getRandomNumber() {
    return Random().nextInt(10).toString();
  }
}
