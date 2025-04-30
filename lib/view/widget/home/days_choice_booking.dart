import 'package:flutter/material.dart';

enum Days { sun, mon, tue, wed, thu, fri, sat }

class DaysChoiceBooking extends StatefulWidget {
  const DaysChoiceBooking({super.key});

  @override
  State<DaysChoiceBooking> createState() => _DaysChoiceBookingState();
}

class _DaysChoiceBookingState extends State<DaysChoiceBooking> {
  Days daysView = Days.sun;

  @override
  Widget build(BuildContext context) {
    return SegmentedButton<Days>(
      showSelectedIcon: false,
      segments: const <ButtonSegment<Days>>[
        ButtonSegment<Days>(
          value: Days.sun,
          label: Text('SUN'),
        ),
        ButtonSegment<Days>(
          value: Days.mon,
          label: Text('MON'),
        ),
        ButtonSegment<Days>(
          value: Days.tue,
          label: Text('TUE'),
        ),
        ButtonSegment<Days>(
          value: Days.wed,
          label: Text('WED'),
        ),
        ButtonSegment<Days>(
          value: Days.thu,
          label: Text('THU'),
        ),
        ButtonSegment<Days>(
          value: Days.fri,
          label: Text('FRI'),
        ),
        ButtonSegment<Days>(
          value: Days.sat,
          label: Text('SAT'),
        ),
      ],
      selected: <Days>{daysView},
      onSelectionChanged: (Set<Days> newSelection) {
        setState(() {
          daysView = newSelection.first;
        });
      },
    );
  }
}
