import 'package:expenses/widgets/chart/chart.dart';
import 'package:expenses/widgets/expenses_list/expenses_list.dart';
import 'package:expenses/models/expense.dart';
import 'package:expenses/widgets/new_expense.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _reqisteredExpenses = [
    //Dummy data for testing
    Expense(
        title: "Kremówka",
        amount: 21.37,
        date: DateTime.now(),
        category: Category.food),
    Expense(
        title: "Public transport bill",
        amount: 9.99,
        date: DateTime.now(),
        category: Category.travel)
  ];

  void _openExpenseAdd() {
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (ctx) => NewExpense(onAddExpense: _addExpense),
    );
  }

  void _addExpense(Expense expense) {
    setState(() {
      _reqisteredExpenses.add(expense);
    });
  }

  void _removeExpense(Expense expense) {
    final expanseIndex = _reqisteredExpenses.indexOf(expense);
    setState(() {
      _reqisteredExpenses.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          duration: const Duration(seconds: 3),
          content: const Text('Wydatek usunięty'),
          action: SnackBarAction(
              label: 'Cofnij',
              onPressed: () {
                setState(() {
                  _reqisteredExpenses.insert(expanseIndex, expense);
                });
              })),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    Widget mainContent =
        const Center(child: Text('Nie dodano jeszcze żadnych wydatków'));

    if (_reqisteredExpenses.isNotEmpty) {
      mainContent = ExpensesList(
        expenses: _reqisteredExpenses,
        onRemoveExpense: _removeExpense,
      );
    }

    return Scaffold(
        appBar: AppBar(
          title: const Text('Wydatki'),
          actions: [
            IconButton(icon: const Icon(Icons.add), onPressed: _openExpenseAdd)
          ],
        ),
        body: width < 600
            ? Column(
                children: [
                  Chart(expenses: _reqisteredExpenses),
                  Expanded(child: mainContent)
                ],
              )
            : Row(
                children: [
                  Expanded(child: Chart(expenses: _reqisteredExpenses)),
                  Expanded(child: mainContent)
                ],
              ));
  }
}
