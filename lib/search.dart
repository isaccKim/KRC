import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  bool _isExpanded = false;
  List<String> filters = ['No Kids Zone', 'Pet-Friendly', 'Free breakfast'];
  Set<String> selectedFilters = {};
  DateTime? _checkInDate;

  Future<void> _selectDate(BuildContext context, bool isCheckIn) async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2024),
    );

    if (selectedDate != null && mounted) {
      setState(() {
        if (isCheckIn) {
          _checkInDate = selectedDate;
        }
      });
    }
  }

  String _formattedDate(DateTime? date) {
    if (date == null) {
      return 'Not selected';
    } else {
      final DateFormat formatter = DateFormat('y.MM.dd (E)');
      return formatter.format(date);
    }
  }

  void _showSelectedOptionsDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Please check your choice;)'),
          content: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Icon(Icons.filter_list),
                    ),
                    Flexible(
                        child: Text(
                          ' ${selectedFilters.join('/ ')}',
                          maxLines: 4,)),
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(Icons.calendar_month),
                    ),
                    Text('IN: ${_formattedDate(_checkInDate)}'),
                  ],
                ),
              ],
            ),
          ),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Search'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Cancel'),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop(); // 뒤로 가기 기능 추가
          },
        ),
      ),
      body: ListView(
        children: [
          Column(
            children: [
              ExpansionPanelList(
                elevation: 1,
                expandedHeaderPadding: EdgeInsets.all(0),
                expansionCallback: (int index, bool isExpanded) {
                  setState(() {
                    _isExpanded = !_isExpanded;
                  });
                },
                children: [
                  ExpansionPanel(
                    headerBuilder: (BuildContext context, bool isExpanded) {
                      return const ListTile(
                        leading: Text('Filter', style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold)),
                        title: Text('SelectFilter', style: TextStyle(fontSize: 18)),
                      );
                    },
                    body: Padding(
                      padding: const EdgeInsets.only(left: 60,right: 16.0),
                      child: Column(
                        children: filters.map<Widget>((String filter) {
                          return Row(
                            children: [
                              Checkbox(
                                value: selectedFilters.contains(filter),
                                onChanged: (bool? value) {
                                  setState(() {
                                    if (value != null) {
                                      if (value) {
                                        selectedFilters.add(filter);
                                      } else {
                                        selectedFilters.remove(filter);
                                      }
                                    }
                                  });
                                },
                              ),
                              Text(
                                filter,
                                style: TextStyle(fontSize: 16), // 텍스트 스타일 조정 가능
                              ),
                            ],
                          );
                        }).toList(),

                      ),
                    ),
                    isExpanded: _isExpanded,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('Date',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                  ],
                ),
              ),
              ListTile(
                title: Row(
                  children: [
                    Text('🗓️ Check-in'),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(60, 0, 0, 0),
                      child: ElevatedButton(
                        child: const Text('select date', style: TextStyle(color: Colors.black)),
                        onPressed: () {
                          _selectDate(context, true);
                        },
                      ),
                    ),
                  ],
                ),
                subtitle: Text('${_formattedDate(_checkInDate)}'),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0,300,0,0),
                child: ElevatedButton(
                  child: const Text('Search', style: TextStyle(color: Colors.black)),
                  onPressed: () {
                    _showSelectedOptionsDialog();
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}