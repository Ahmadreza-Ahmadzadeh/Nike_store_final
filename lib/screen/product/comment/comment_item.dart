import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nike_store/data/comment.dart';

class CommentItem extends StatelessWidget {
  final CommentEntity comment;
  const CommentItem({
    super.key,
    required this.comment,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      margin: EdgeInsets.fromLTRB(8, 0, 8, 8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Theme.of(context).dividerColor)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(comment.title),
              Text(
                comment.date,
                style: Theme.of(context).textTheme.caption,
              )
            ],
          ),
          Text(
            comment.email,
            style: Theme.of(context).textTheme.caption,
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            comment.content,
            style: const TextStyle(height: 1.2),
          ),
        ],
      ),
    );
  }
}
