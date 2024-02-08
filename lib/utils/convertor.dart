
class Convertor {

  static List<DateTime> convertDateToDays(DateTime fromDate, DateTime toDate) {
    return getDaysInRange(fromDate, toDate);
  }

  static List<DateTime> getDaysInRange(DateTime fromDate, DateTime toDate) {
    List<DateTime> days = [];
    Duration difference = toDate.difference(fromDate);

    for (int i = 0; i <= difference.inDays; i++) {
      DateTime day = fromDate.add(Duration(days: i));
      days.add(day);
    }

    return days;
  }
}