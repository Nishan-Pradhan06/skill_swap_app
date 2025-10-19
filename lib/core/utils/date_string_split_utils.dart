String getDayFromDateTime(String dateTime) {
  return dateTime.split(',').first; // "Monday, 5:45 PM" -> "Monday"
}
