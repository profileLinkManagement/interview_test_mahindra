import 'package:flutter/material.dart';
import 'package:interview_test_mahindra/library/month_picker/month_picker_dialog.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class MultiSelectionDateWidget extends StatefulWidget {
  final void Function(DateTime fromDate, DateTime toDate) onRangeSelection;
  final void Function() onClearRangeSelection;

  const MultiSelectionDateWidget({super.key, required this.onRangeSelection, required this.onClearRangeSelection});

  @override
  _MultiSelectionDateWidgetState createState() =>
      _MultiSelectionDateWidgetState();
}

class _MultiSelectionDateWidgetState extends State<MultiSelectionDateWidget> {
  CalendarFormat _calendarFormat = CalendarFormat.week;
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode.toggledOn;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;

  final DateTime kFirstDay =
      DateTime(2023, DateTime.now().month, DateTime.now().day);
  final DateTime kLastDay = DateTime.now();

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
        _rangeStart = null; // Important to clean those
        _rangeEnd = null;
        _rangeSelectionMode = RangeSelectionMode.toggledOff;
      });
      printAll("Date select");
    }
  }

  void _openMonthYearSelectorDialog() async {
    final selectedMonth = await showMonthPicker(
        context: context,
        initialDate: _focusedDay,
        firstDate: kFirstDay,
        lastDate: kLastDay);
    if (selectedMonth != null) {
      setState(() {
        _focusedDay = selectedMonth;
      });
    }
  }

  void _onRangeSelected(DateTime? start, DateTime? end, DateTime focusedDay) {
    setState(() {
      _selectedDay = null;
      _focusedDay = focusedDay;
      _rangeStart = start;
      _rangeEnd = end;
      _rangeSelectionMode = RangeSelectionMode.toggledOn;
    });
    printAll("onRangeSelected");

    if (_rangeStart != null &&
        _rangeEnd != null &&
        _rangeStart.toString().isNotEmpty &&
        _rangeEnd.toString().isNotEmpty) {
      widget.onRangeSelection(_rangeStart!, _rangeEnd!);
    } else {
      widget.onClearRangeSelection();
    }
  }

  void _onFormatChanged(CalendarFormat format) {
    widget.onClearRangeSelection();
    if (_calendarFormat != format) {
      setState(() {
        _calendarFormat = format;
      });
    }
  }

  void onPageChanged(DateTime focusedDay) {
    _focusedDay = focusedDay;
    printAll("onPageChanged");
  }

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      firstDay: kFirstDay,
      lastDay: kLastDay,
      focusedDay: _focusedDay,
      selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
      rangeStartDay: _rangeStart,
      rangeEndDay: _rangeEnd,
      calendarFormat: _calendarFormat,
      rangeSelectionMode: _rangeSelectionMode,
      availableCalendarFormats: const {
        CalendarFormat.month: 'Month',
        CalendarFormat.twoWeeks: '2 weeks',
        CalendarFormat.week: 'Week',
      },
      calendarBuilders: CalendarBuilders(
        dowBuilder: (context, day) {
          final text = DateFormat.E().format(day);
          return Center(
            child: Text(
              text.substring(0, 1),
              style: TextStyle(
                color: day.weekday == DateTime.sunday
                    ? Colors.yellow
                    : Colors.black,
              ),
            ),
          );
        },
      ),
      headerStyle: HeaderStyle(
        /* titleTextFormatter: (date, locale) {
          return DateFormat.yM(locale).format(date);
        },*/
        titleTextStyle: const TextStyle(
          fontSize: 16.0,
        ),
        leftChevronVisible: false,
        formatButtonVisible: false,
        rightChevronIcon: IconButton(
          icon: const Icon(Icons.arrow_drop_down),
          onPressed: _openMonthYearSelectorDialog,
        ),
        rightChevronPadding: EdgeInsets.zero,
        rightChevronMargin: EdgeInsets.zero,
      ),
      onDaySelected: _onDaySelected,
      onRangeSelected: _onRangeSelected,
      onFormatChanged: _onFormatChanged,
      onPageChanged: onPageChanged,
    );
  }

  void printAll(String section) {
    print(
        "LOGGER ==>> $section ==>> _selectedDate: ${_selectedDay.toString()} || _focusedDay: ${_focusedDay.toString()} || rangeStart: ${_rangeStart.toString()} || rageEnd: ${_rangeEnd.toString()}");
  }

  void log(String msg) {
    print("LOGGER ==>> $msg");
  }
}
