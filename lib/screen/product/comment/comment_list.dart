import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nike_store/data/repo/comment_repository.dart';
import 'package:nike_store/screen/product/comment/bloc/comment_bloc.dart';
import 'package:nike_store/widgets/error_widget.dart';

import 'comment_item.dart';

class CommentList extends StatelessWidget {
  final int productId;

  const CommentList({super.key, required this.productId});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final CommentBloc bloc = CommentBloc(commentRepository, productId);
        bloc.add(CommentStarted());
        return bloc;
      },
      child: BlocBuilder<CommentBloc, CommentState>(
        builder: (context, state) {
          if (state is CommentSuccess) {
            return SliverList(
                delegate: SliverChildBuilderDelegate(
              (context, index) {
                return CommentItem(
                  comment: state.data[index],
                );
              },
              childCount: state.data.length,
            ));
          } else if (state is CommentLoading) {
            return SliverToBoxAdapter(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else if (state is CommentError) {
            return SliverToBoxAdapter(
              child: AppErrorWidget(
                  onTap: () {
                    BlocProvider.of<CommentBloc>(context).add(CommentStarted());
                  },
                  exception: state.exception),
            );
          } else {
            throw Exception("state is invalid");
          }
        },
      ),
    );
  }
}
