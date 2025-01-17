import 'package:flutter/material.dart';

class MyListTile extends StatefulWidget {
  final String title;
  final VoidCallback onEdit;
  final bool isCompleted;
  final ValueChanged<bool?> onToggle;
  final VoidCallback onDelete;
  const MyListTile({
    super.key,
    required this.title,
    required this.onEdit,
    required this.onDelete,
    required this.isCompleted,
    required this.onToggle,
  });

  @override
  State<MyListTile> createState() => _MyListTileState();
}

class _MyListTileState extends State<MyListTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Theme.of(context).colorScheme.secondary,
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: Color.fromARGB(204, 212, 202, 202),
            offset: Offset(1, 1),
            blurRadius: 0,
            spreadRadius: 0,
          ),
        ],
      ),
      child: ListTile(
        leading: Checkbox(
          value: widget.isCompleted,
          onChanged: widget.onToggle,
          activeColor: Theme.of(context).colorScheme.primary,
        ),
        title: Text(
          widget.title,
          style: TextStyle(
            fontSize: 20,
            decoration: widget.isCompleted
                ? TextDecoration.lineThrough
                : TextDecoration.none,
          ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(Icons.edit,
                  color: Theme.of(context).colorScheme.primary),
              onPressed: widget.onEdit,
            ),
            IconButton(
              icon: Icon(Icons.delete,
                  color: Theme.of(context).colorScheme.primary),
              onPressed: widget.onDelete,
            ),
          ],
        ),
      ),
    );
  }
}
