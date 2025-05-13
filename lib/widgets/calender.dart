import 'package:flutter/material.dart';
import 'package:nepali_utils/nepali_utils.dart';
import 'package:nepali_english_calendar/nepali_english_calendar.dart';

Color red = const Color(0xffDC143C);
Color blue = const Color(0xff003893);

void main() => runApp(const Calender());

class Calender extends StatefulWidget {
  const Calender({super.key});

  @override
  State<Calender> createState() => _CalenderState();
}

class _CalenderState extends State<Calender> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.green),
      title: 'Nepali Date Picker Demo',
      home: DefaultTabController(
        length: 1,
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Nepali Date Picker"),
            backgroundColor: Colors.green,
            centerTitle: true,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.maybePop(context);
              },
            ),
            actions: [
              IconButton(
                icon: Text(
                  NepaliUtils().language == Language.english ? 'ने' : 'En',
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(color: Colors.white),
                ),
                onPressed: () {
                  NepaliUtils().language =
                      NepaliUtils().language == Language.english
                          ? Language.nepali
                          : Language.english;
                  setState(() {});
                },
              ),
            ],
          ),
          body: const TabBarView(children: [NepaliCalendarTab()]),
        ),
      ),
    );
  }
}

class NepaliCalendarTab extends StatefulWidget {
  const NepaliCalendarTab({super.key});

  @override
  State<NepaliCalendarTab> createState() => _NepaliCalendarTabState();
}

class _NepaliCalendarTabState extends State<NepaliCalendarTab> {
  final ValueNotifier<NepaliDateTime> _selectedDate = ValueNotifier(
    NepaliDateTime.now(),
  );

  final Map<String, List<String>> eventsMap = {};
  final TextEditingController eventController = TextEditingController();

  String _dateKey(NepaliDateTime date) =>
      date.toIso8601String().substring(0, 10);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        NepaliCalendar(
          language: NepaliUtils(),
          monthYearPickerStyle: const TextStyle(
            color: Colors.red,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
          rightLeftButtonColor: Colors.red,
          weekHeaderStyle: const TextStyle(
            color: Colors.blue,
            fontWeight: FontWeight.bold,
            fontSize: 26,
          ),
          initialDate: NepaliDateTime.now(),
          firstDate: NepaliDateTime(2000),
          lastDate: NepaliDateTime(2100),
          onDateChanged: (date) => _selectedDate.value = date,
          dayBuilder: (dayToBuild) {
            final key = _dateKey(dayToBuild);
            final hasEvent =
                eventsMap.containsKey(key) && eventsMap[key]!.isNotEmpty;

            return Stack(
              children: <Widget>[
                Center(
                  child: Text(
                    NepaliUtils().language == Language.english
                        ? '${dayToBuild.day}'
                        : NepaliUnicode.convert('${dayToBuild.day}'),
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                if (hasEvent)
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      width: 6,
                      height: 6,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.red,
                      ),
                    ),
                  ),
              ],
            );
          },
          selectedDayDecoration: const BoxDecoration(
            color: Colors.deepOrange,
            shape: BoxShape.circle,
          ),
          todayDecoration: const BoxDecoration(
            gradient: LinearGradient(colors: [Colors.yellow, Colors.orange]),
            shape: BoxShape.circle,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: eventController,
                  decoration: const InputDecoration(
                    hintText: 'Add event title',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: () {
                  final text = eventController.text.trim();
                  if (text.isNotEmpty) {
                    final key = _dateKey(_selectedDate.value);
                    setState(() {
                      eventsMap.putIfAbsent(key, () => []);
                      eventsMap[key]!.add(text);
                    });
                    eventController.clear();
                  }
                },
                child: const Text("Add"),
              ),
            ],
          ),
        ),
        Expanded(
          child: ValueListenableBuilder<NepaliDateTime>(
            valueListenable: _selectedDate,
            builder: (context, date, _) {
              final key = _dateKey(date);
              final events = eventsMap[key];

              if (events == null || events.isEmpty) {
                return const Center(child: Text('No Events'));
              }

              return ListView.separated(
                itemCount: events.length,
                itemBuilder:
                    (context, index) => ListTile(
                      leading: TodayWidget(today: date),
                      title: Text(events[index]),
                    ),
                separatorBuilder: (context, _) => const Divider(),
              );
            },
          ),
        ),
      ],
    );
  }
}

class TodayWidget extends StatelessWidget {
  final NepaliDateTime today;
  const TodayWidget({super.key, required this.today});

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: SizedBox(
        width: 60,
        height: 60,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DecoratedBox(
              decoration: BoxDecoration(
                color: red,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 2),
                child: Text(
                  NepaliDateFormat.EEEE()
                      .format(today)
                      .substring(0, 3)
                      .toUpperCase(),
                  style: Theme.of(
                    context,
                  ).textTheme.bodyLarge?.copyWith(color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            const Spacer(),
            Text(
              NepaliDateFormat.d().format(today),
              style: Theme.of(context).textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
