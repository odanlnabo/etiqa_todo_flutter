import 'package:etiqa_todo_flutter/models/do_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:etiqa_todo_flutter/models/todo_model.dart';

class TodoPage extends StatefulWidget {
  final DoModel? doModel;

  const TodoPage({Key? key, this.doModel}) : super(key: key);

  @override
  _TodoPageState createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  final _titleController = TextEditingController();
  final _startDateController = TextEditingController();
  final _endDateController = TextEditingController();

  @override
  void initState() {
    if (widget.doModel != null) {
      _titleController.text = widget.doModel!.getTitle;
      _startDateController.text = widget.doModel!.getStartDate.toString();
      _endDateController.text = widget.doModel!.getEndDate.toString();
    }

    super.initState();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _startDateController.dispose();
    _endDateController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Color(0xFFF59E0B),
          centerTitle: false,
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
          ),
          title: Text(
            'Add New To-Do List',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
        body: SafeArea(
          child: Container(
            child: Column(
              children: [
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 24.0, vertical: 30.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'To-Do Title',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF9CA3AF),
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        padding: EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Color(0xFF9CA3AF),
                            width: 2,
                          ),
                        ),
                        child: TextField(
                          controller: _titleController,
                          maxLines: 8,
                          decoration: InputDecoration.collapsed(
                            hintText: "Enter your text here",
                          ),
                        ),
                      ),
                      SizedBox(height: 20.0),
                      Text(
                        'Start Date',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF9CA3AF),
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        padding: EdgeInsets.only(left: 10.0),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Color(0xFF9CA3AF),
                            width: 2,
                          ),
                        ),
                        child: TextField(
                          controller: _startDateController,
                          focusNode: AlwaysDisabledFocusNode(),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Select a date',
                          ),
                          onTap: () {
                            _selectDate(context, _startDateController);
                          },
                        ),
                      ),
                      SizedBox(height: 20.0),
                      Text(
                        'Estimate End Date',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF9CA3AF),
                        ),
                      ),
                      SizedBox(height: 10.0),
                      Container(
                        padding: EdgeInsets.only(left: 10.0),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Color(0xFF9CA3AF),
                            width: 2,
                          ),
                        ),
                        child: TextField(
                          controller: _endDateController,
                          focusNode: AlwaysDisabledFocusNode(),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Select a date',
                          ),
                          onTap: () {
                            _selectDate(context, _endDateController);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Spacer(),
                widget.doModel == null
                    ? _buildCreateButton()
                    : _buildUpdateButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCreateButton() {
    return GestureDetector(
      onTap: () {
        Provider.of<TodoModel>(context, listen: false).addDoList(
          title: _titleController.text,
          startDate: _startDateController.text.toString(),
          endDate: _endDateController.text.toString(),
        );

        Navigator.pop(context);
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 22.0),
        color: Colors.black,
        child: Text(
          'Create Now',
          style: TextStyle(
            fontSize: 16.0,
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _buildUpdateButton() {
    return GestureDetector(
      onTap: () {
        Provider.of<TodoModel>(context, listen: false).updateDo(
          id: widget.doModel!.id,
          title: _titleController.text,
          startDate: _startDateController.text.toString(),
          endDate: _endDateController.text.toString(),
        );

        Navigator.pop(context);
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 22.0),
        color: Colors.black,
        child: Text(
          'Update To-Do',
          style: TextStyle(
            fontSize: 16.0,
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  _selectDate(BuildContext context, controller) async {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019, 1),
      lastDate: DateTime(2021, 12),
    ).then((pickedDate) {
      controller.text = pickedDate.toString();
    });
  }
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
