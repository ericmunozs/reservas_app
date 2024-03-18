import 'package:flutter/material.dart';

class BookingSchedule extends StatefulWidget {
  @override
  _BookingScheduleState createState() => _BookingScheduleState();
}

class _BookingScheduleState extends State<BookingSchedule> {
  late int selectedDayIndex;

  @override
  void initState() {
    super.initState();
    selectedDayIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 100,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 14,
            itemBuilder: (context, index) {
              String day = getDay(index);
              String dayName = getDayName(index);
              String monthName = getMonthName(index);

              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedDayIndex = index;
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 12.0),
                  child: Column(
                    children: [
                      Text(
                        dayName,
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: index == selectedDayIndex
                                ? FontWeight.bold
                                : FontWeight.normal),
                      ),
                      Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: index == selectedDayIndex
                              ? Colors.blue
                              : Colors.transparent,
                        ),
                        child: Center(
                          child: Text(
                            day,
                            style: TextStyle(
                              color: index == selectedDayIndex
                                  ? Colors.white
                                  : Colors.black,
                              fontWeight: index == selectedDayIndex
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                            ),
                          ),
                        ),
                      ),
                      Text(
                        monthName,
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: index == selectedDayIndex
                                ? FontWeight.bold
                                : FontWeight.normal),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: 10,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Card(
                  elevation: 2,
                  child: ListTile(
                    title: Text('${index + 10}:00'),
                    subtitle: Text('Personas: ${index * 2}'),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  String getDay(int index) {
    DateTime now = DateTime.now();
    return now.add(Duration(days: index)).day.toString();
  }

  String getDayName(int index) {
    List<String> daysOfWeek = ['DOM', 'LUN', 'MAR', 'MIÉ', 'JUE', 'VIE', 'SÁB'];

    int adjustedIndex = (DateTime.now().weekday + index) % daysOfWeek.length;

    return daysOfWeek[adjustedIndex];
  }

  String getMonthName(int index) {
    DateTime now = DateTime.now();
    List<String> months = [
      'ene',
      'feb',
      'mar',
      'abr',
      'may',
      'jun',
      'jul',
      'ago',
      'sep',
      'oct',
      'nov',
      'dic'
    ];

    int adjustedIndex = now.add(Duration(days: index)).month - 1;

    return months[adjustedIndex];
  }
}
