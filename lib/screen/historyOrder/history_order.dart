import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nike_store/common/utility.dart';
import 'package:nike_store/data/repo/history_repository.dart';
import 'package:nike_store/main.dart';
import 'package:nike_store/screen/historyOrder/bloc/history_order_bloc.dart';
import 'package:nike_store/widgets/loadingImage.dart';

class HistoryOrderScreen extends StatelessWidget {
  const HistoryOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("سوابق سفارش"),
      ),
      body: BlocProvider<HistoryOrderBloc>(create: (context) {
        final bloc = HistoryOrderBloc(historyRepository)..add(HistoryInitial());
        return bloc;
      }, child: BlocBuilder<HistoryOrderBloc, HistoryOrderState>(
        builder: (context, state) {
          if (state is HistorySuccess) {
            return ListView.builder(
              itemCount: state.historyOrder.length,
              itemBuilder: (context, index) {
                return ValueListenableBuilder(
                  valueListenable: theme,
                  builder:
                      (BuildContext context, ThemeMode value, Widget? child) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 250,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Theme.of(context).colorScheme.surface,
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 10,
                                  color: Theme.of(context).colorScheme.shadow)
                            ]),
                        child: Column(children: [
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text("شناسه سفارش "),
                                Text(state.historyOrder[index].id.toString()),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Divider(
                            color: Theme.of(context).dividerColor,
                            height: 1,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text("مبلغ"),
                                RichText(
                                  text: TextSpan(
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge
                                          ?.copyWith(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18),
                                      text: state.historyOrder[index].payable
                                          .seprateByComma,
                                      children: [
                                        TextSpan(
                                            text: " تومان",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium
                                                ?.copyWith(fontSize: 12))
                                      ]),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Divider(
                            color: Theme.of(context).dividerColor,
                            height: 1,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: SizedBox(
                              height: 110,
                              child: ListView.builder(
                                physics: defaultPhysics,
                                itemCount:
                                    state.historyOrder[index].products.length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, indexProduct) {
                                  final list =
                                      state.historyOrder[index].products;
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: SizedBox(
                                      height: 40,
                                      width: 100,
                                      child: loadingImageServer(
                                          imageUrl: list[indexProduct].image,
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                    ),
                                  );
                                },
                              ),
                            ),
                          )
                        ]),
                      ),
                    );
                  },
                );
              },
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      )),
    );
  }
}
