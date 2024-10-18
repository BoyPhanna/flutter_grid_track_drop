import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Syncfusion Column Group Example')),
        body: ColumnGroupExample(),
      ),
    );
  }
}

class ColumnGroupExample extends StatefulWidget {
  @override
  _ColumnGroupExampleState createState() => _ColumnGroupExampleState();
}

class _ColumnGroupExampleState extends State<ColumnGroupExample> {
  late EmployeeDataSource _employeeDataSource;
  List<GridColumn> columns = [];

  @override
  void initState() {
    super.initState();
    _employeeDataSource = EmployeeDataSource();

    columns = [
      GridColumn(
        columnWidthMode: ColumnWidthMode.fill,
        columnName: 'id',
        label: Container(
          padding: EdgeInsets.all(8.0),
          alignment: Alignment.center,
          child: Text('ID'),
        ),
      ),
      GridColumn(
        columnWidthMode: ColumnWidthMode.fill,
        columnName: 'name',
        label: Container(
          padding: EdgeInsets.all(8.0),
          alignment: Alignment.center,
          child: Text('Name'),
        ),
      ),
      GridColumn(
        columnWidthMode: ColumnWidthMode.fill,
        columnName: 'designation',
        label: Container(
          padding: EdgeInsets.all(8.0),
          alignment: Alignment.center,
          child: Text('Designation'),
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: SfDataGrid(
        gridLinesVisibility: GridLinesVisibility.both,

        autoExpandGroups: true,
        groupCaptionTitleFormat: '{ColumnName} : {Key} = {ItemsCount} Items',

        columnWidthMode: ColumnWidthMode.lastColumnFill,
        source: _employeeDataSource,
        allowColumnsDragging: true, // Enable column dragging
        allowExpandCollapseGroup: true,
        onColumnDragging: (details) {
          // Get the column name based on the index
          String columnName = columns[details.from].columnName;

          _groupByColumn(columnName);

          return true; // Prevent the default drag behavior
        },
        columns: columns,
      ),
    );
  }

  // Method to simulate grouping by a specific column
  void _groupByColumn(String columnName) {
    setState(() {
      _employeeDataSource.clearColumnGroups();
      _employeeDataSource.addColumnGroup(ColumnGroup(
          name: columnName,
          sortGroupRows: true)); // Group data by dragged column
      // // Check if the column group already exists
      // bool haveIngroup = _employeeDataSource.groupedColumns
      //     .any((group) => group.name == columnName);

      // // If the group doesn't exist, add it
      // if (!haveIngroup) {

      // }

      // else {
      //   _employeeDataSource.removeColumnGroup(_employeeDataSource.groupedColumns
      //       .firstWhere((group) => group.name == columnName));
      // }
    });
  }
}

class Employee {
  Employee(this.id, this.name, this.designation);

  final int id;
  final String name;
  final String designation;
}

class EmployeeDataSource extends DataGridSource {
  List<Employee> employees = [
    Employee(1, 'John', 'Manager'),
    Employee(2, 'Doe', 'Developer'),
    Employee(3, 'Alice', 'Manager'),
    Employee(4, 'Bob', 'Developer'),
    Employee(4, 'Bob', 'Developer'),
    Employee(4, 'Bob', 'Developer'),
    Employee(4, 'Bob', 'Developer'),
  ];

  List<DataGridRow> _employees = [];

  EmployeeDataSource() {
    _employees = employees.map<DataGridRow>((employee) {
      return DataGridRow(cells: [
        DataGridCell<int>(columnName: 'id', value: employee.id),
        DataGridCell<String>(columnName: 'name', value: employee.name),
        DataGridCell<String>(
            columnName: 'designation', value: employee.designation),
      ]);
    }).toList();
  }

  @override
  List<DataGridRow> get rows => _employees;
  int i = 0;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    final color = (i % 2 == 1) ? Colors.white : Colors.grey[300];
    i++;
    return DataGridRowAdapter(cells: [
      Container(
        color: color,
        alignment: Alignment.center,
        padding: EdgeInsets.all(8.0),
        child: Text(row.getCells()[0].value.toString()),
      ),
      Container(
        color: color,
        alignment: Alignment.center,
        padding: EdgeInsets.all(8.0),
        child: Text(row.getCells()[1].value.toString()),
      ),
      Container(
        color: color,
        alignment: Alignment.center,
        padding: EdgeInsets.all(8.0),
        child: Text(row.getCells()[2].value.toString()),
      ),
    ]);
  }

  @override
  Widget? buildGroupCaptionCellWidget(
      RowColumnIndex rowColumnIndex, String summaryValue) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 15),
        child: Text(summaryValue));
  }
}
