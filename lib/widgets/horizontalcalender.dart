import 'package:flutter/material.dart';
import 'package:horizontal_calendar_plus/horizontal_calendar_plus.dart';

class Horizontalcalender extends StatefulWidget {
  const Horizontalcalender({super.key});

  @override
  State<Horizontalcalender> createState() => _HorizontalcalenderState();
}

class _HorizontalcalenderState extends State<Horizontalcalender> {
  final ValueNotifier<DateTime> _currentDateNotifier = ValueNotifier(
    DateTime.now(),
  );
  ScrollController? scrollController = ScrollController();

  @override
  void initState() {
    HorizontalCalendarPlus.startDateTimeUpdater(_currentDateNotifier);
    HorizontalCalendarPlus.jumpToCurrentIndex(scrollController);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // First Calendar (Nepali)
        Container(
          height: 120,
          child: HorizontalCalendarPlus(
            currentDateNotifier: _currentDateNotifier,
            padding: EdgeInsets.only(top: 15, left: 8, right: 8),
            scrollController: scrollController,
            calenderLabelformate: CalenderDateFormate.ABBR_WEEKDAY,
            calenderSubTitleformate: CalenderDateFormate.MONTH_DAY,
            designTypeCalender: DesignTypeCalender.DEFAULTDESIGN,
            boxelevation: 5,
            boxActiveBgColor: Colors.green,
            boxborderRadius: BorderRadius.circular(1),
            changelanguage: Changelanguage.NAPILE,
            cardViewDesign: CardContentView(hideIcon: false),
          ),
        ),
        SizedBox(height: 20),
        // Second Calendar (English Custom Design)
        Container(
          height: 120,
          child: HorizontalCalendarPlus(
            currentDateNotifier: _currentDateNotifier,
            padding: EdgeInsets.only(top: 15, left: 12, right: 12),
            scrollController: scrollController,
            calenderLabelformate: CalenderDateFormate.ABBR_WEEKDAY,
            calenderSubTitleformate: CalenderDateFormate.MONTH_DAY,
            designTypeCalender: DesignTypeCalender.CUSTOMDESIGN,
            boxelevation: 5,
            boxActiveBgColor: Colors.green,
            boxborderRadius: BorderRadius.circular(10),
            changelanguage: Changelanguage.NAPILE,
            cardViewDesign: CardContentView(
              hideIcon: false,
              titletextActiveColor: Colors.red,
              titletextUnActiveColor: Colors.greenAccent,
            ),
            customWidgetbuilder: (context, dateTime, index) {
              final packageCore = PackageCore(
                builderIndex: index,
                dateTime: dateTime,
                countPreviesDate: 3,
              );

              final isToday =
                  packageCore.dateFormatePlus() ==
                  packageCore.checkCurrentDate();

              return Card(
                color: isToday ? Colors.red : Colors.white,
                elevation: 2,
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    width: isToday ? 2 : 1,
                    color: isToday ? Colors.green : Colors.black,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                margin: EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      packageCore.showTitle(
                        CalenderDateFormate.MONTH_DAY.skeleton,
                      ),
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    Text(
                      packageCore.showSubTitle(
                        CalenderDateFormate.WEEKDAY.skeleton,
                      ),
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
