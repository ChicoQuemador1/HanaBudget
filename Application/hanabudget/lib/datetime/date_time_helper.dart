String convertDateTimeToString(DateTime dateTime) {
  // Year remains the same, always 4 digits
  String year = dateTime.year.toString();

  // Month is converted to a string directly without zero-padding
  String month = dateTime.month.toString();

  // Day is zero-padded if it's a single digit
  String day = dateTime.day.toString();
  if (day.length == 1) {
    day = '0' + day;
  }

  // Format: M/dd/yyyy (month is not zero-padded, day is zero-padded, year is 4 digits)
  String mddyyyy = month + '/' + day + '/' + year;

  return mddyyyy;
}
