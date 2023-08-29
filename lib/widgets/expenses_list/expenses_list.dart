import 'package:expenses/models/expense.dart';
import 'package:expenses/widgets/expenses_list/expanse_item.dart';
import 'package:flutter/material.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList(
      {super.key, required this.expenses, required this.onRemoveExpense});

  final void Function(Expense expense) onRemoveExpense;
  final List<Expense> expenses;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: expenses.length,
        itemBuilder: (cntx, index) => Dismissible(
              background: Container(
                color: Theme.of(context).colorScheme.error,
                margin: Theme.of(context).cardTheme.margin,
              ),
              key: ValueKey(expenses[index]),
              onDismissed: (direction) {
                onRemoveExpense(expenses[index]);
              },
              child: ExpenseItem(expenses[index]),
            ));
  }
}
