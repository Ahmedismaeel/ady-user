import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension FormatterCustom on DateTime? {
  format() {
    return this != null ? DateFormat("yyyy-MM-dd").format(this!) : null;
  }

  requestFormat() {
    return this != null ? DateFormat("dd-MM-yyyy").format(this!) : null;
  }

  dateText() {
    return this != null ? DateFormat('d MMMM yyyy').format(this!) : null;
  }
}

extension FormatterExtention on TimeOfDay? {
  formatWithAmPm() {
    // Create a DateTime object from the TimeOfDay
    if (this == null) {
      return null;
    }
    final now = DateTime.now();
    final dateTime =
        DateTime(now.year, now.month, now.day, this!.hour, this!.minute);

    // Use the intl package to format the time with am/pm
    return DateFormat('hh:mm a').format(dateTime);
  }

  requestFormat() {
    if (this == null) {
      return null;
    }

    final now = DateTime.now();
    final dateTime =
        DateTime(now.year, now.month, now.day, this!.hour, this!.minute);

    // Use the intl package to format the time with am/pm
    return DateFormat('HH:mm').format(dateTime);
  }
}
