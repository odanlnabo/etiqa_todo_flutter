import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:duration/duration.dart';

class TodoCardWidget extends StatelessWidget {
  final String title;
  final DateTime startDate;
  final DateTime endDate;
  final bool completed;
  final VoidCallback completeTask;

  TodoCardWidget({
    required this.title,
    required this.startDate,
    required this.endDate,
    required this.completed,
    required this.completeTask,
  });

  @override
  Widget build(BuildContext context) {
    int hoursDiff = endDate.difference(startDate).inHours;
    final dur = Duration(minutes: hoursDiff * 60);

    return Container(
      margin: EdgeInsets.only(bottom: 38.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 2), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTodo(
            prettyDuration(
              dur,
              abbreviated: true,
            ),
          ),
          _buildFooter(completed),
        ],
      ),
    );
  }

  Widget _buildTodo(hours) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w900,
              color: Color(0xFF4B5563),
            ),
          ),
          SizedBox(height: 20.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildTimeLabel(
                label: 'Start Date',
                data: DateFormat('dd MMM yyyy').format(startDate),
              ),
              _buildTimeLabel(
                label: 'End Date',
                data: DateFormat('dd MMM yyyy').format(endDate),
              ),
              _buildTimeLabel(
                label: 'Time Left',
                data: hours.toString(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTimeLabel({label, data}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.w500,
            color: Color(0xFF9CA3AF),
          ),
        ),
        SizedBox(height: 10.0),
        Text(
          data,
          style: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.w900,
            color: Color(0xFF4B5563),
          ),
        ),
      ],
    );
  }

  Widget _buildFooter(completed) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      decoration: BoxDecoration(
        color: Color(0xFFEEEBE2),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(12.0),
          bottomRight: Radius.circular(12.0),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Row(
              children: [
                Text('Status: '),
                Text(
                  completed ? 'Completed' : 'Incomplete',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          Container(
            child: Row(
              children: [
                Text('Tick if completed'),
                GestureDetector(
                  onTap: () {
                    completeTask();
                  },
                  child: Container(
                    width: 30.0,
                    height: 30.0,
                    margin: EdgeInsets.only(left: 5.0),
                    decoration: BoxDecoration(
                      color: completed ? Color(0xFFF59E0B) : Colors.transparent,
                      borderRadius: BorderRadius.circular(6.0),
                      border: Border.all(
                        color: Colors.grey,
                        width: 1.5,
                      ),
                    ),
                    child: Icon(Icons.check),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
