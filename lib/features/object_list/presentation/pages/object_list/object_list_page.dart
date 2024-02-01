import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:telestat_test_assignment/core/di/injection.dart';
import 'package:telestat_test_assignment/core/presentation/widgets/error_message.dart';
import 'package:telestat_test_assignment/features/object_list/domain/entities/object_entity.dart';
import 'package:telestat_test_assignment/features/object_list/presentation/pages/object_list/cubit/object_list_cubit.dart';
import 'package:telestat_test_assignment/features/object_list/presentation/pages/create_edit_object/create_edit_object_page.dart';

import 'widgets/object_list_item.dart';

class ObjectListPageProvider extends StatelessWidget {
  const ObjectListPageProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ObjectListCubit>(
      create: (_) => sl<ObjectListCubit>(),
      child: const _ObjectListPage(),
    );
  }
}

class _ObjectListPage extends StatelessWidget {
  const _ObjectListPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<ObjectListCubit, ObjectListState>(
          builder: (context, state) {
            if (state is ObjectListStateLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is ObjectListStateError) {
              return ErrorMessage(message: state.message);
            } else if (state is ObjectListStateLoaded) {
              final List<ObjectEntity> objects = state.objects;
              if (objects.isEmpty) {
                return Center(
                  child: Text(
                    'tap_plus'.tr(),
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                );
              } else {
                return ListView.builder(
                  itemCount: objects.length,
                  itemBuilder: (context, int index) {
                    final object = objects[index];
                    return ObjectListItem(
                      object: object,
                      navigateToEdit: () {
                        Navigator.of(context).pushNamed(
                          CreateEditObjectPageProvider.name,
                          arguments: object,
                        );
                      },
                      deleteObject: () {
                        context.read<ObjectListCubit>().deleteObject(object.id);
                      },
                    );
                  },
                );
              }
            }
            return Container();
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, CreateEditObjectPageProvider.name);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
