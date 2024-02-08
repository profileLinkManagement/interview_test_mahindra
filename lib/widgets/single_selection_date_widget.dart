import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class SingleSelectionDateWidget extends StatefulWidget {
  const SingleSelectionDateWidget({super.key});

  @override
  _SingleSelectionDateState createState() => _SingleSelectionDateState();
}

class _SingleSelectionDateState extends State<SingleSelectionDateWidget> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  final DateTime kFirstDay =
  DateTime(2023, DateTime.now().month, DateTime.now().day);
  final DateTime kLastDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      firstDay: kFirstDay,
      lastDay: kLastDay,
      focusedDay: _focusedDay,
      calendarFormat: _calendarFormat,
      selectedDayPredicate: (day) {
        return isSameDay(_selectedDay, day);
      },
      onDaySelected: (selectedDay, focusedDay) {
        if (!isSameDay(_selectedDay, selectedDay)) {
          setState(() {
            _selectedDay = selectedDay;
            _focusedDay = focusedDay;
          });
        }
      },
      onFormatChanged: (format) {
        if (_calendarFormat != format) {
          setState(() {
            _calendarFormat = format;
          });
        }
      },
      onPageChanged: (focusedDay) {
        _focusedDay = focusedDay;
      },
    );
  }
}