import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:telestat_test_assignment/core/di/injection.dart';
import 'package:telestat_test_assignment/features/object_list/domain/entities/object_entity.dart';
import 'package:telestat_test_assignment/features/object_list/presentation/pages/create_edit_object/cubit/create_edit_cubit_cubit.dart';

class CreateEditObjectPageProvider extends StatelessWidget {
  const CreateEditObjectPageProvider({super.key});

  static const String name = '/create-edit';

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as ObjectEntity?;
    return BlocProvider(
      create: (_) => sl<CreateEditCubit>(),
      child: CreateEditObjectPage(
        id: args?.id,
        title: args?.title,
        description: args?.description,
      ),
    );
  }
}

class CreateEditObjectPage extends StatefulWidget {
  const CreateEditObjectPage(
      {super.key, this.id, this.title, this.description});

  final String? id;
  final String? title;
  final String? description;

  @override
  State<CreateEditObjectPage> createState() => _CreateEditObjectPageState();
}

class _CreateEditObjectPageState extends State<CreateEditObjectPage> {
  final _formKey = GlobalKey<FormState>();
  final _descriptionFocusNode = FocusNode();

  late String title;
  late String description;

  bool get isCreate => widget.id == null;

  @override
  void initState() {
    title = widget.title ?? '';
    description = widget.description ?? '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          isCreate ? 'create_object'.tr() : 'update_object'.tr(),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SafeArea(
        child: BlocListener<CreateEditCubit, CreateEditState>(
          listener: (context, state) {
            if (state is CreateEditStateSuccess) {
              Navigator.of(context).pop();
            } else if (state is CreateEditStateError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                ),
              );
            }
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 8.0,
              vertical: 16.0,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        initialValue: title,
                        autofocus: isCreate,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          hintText: 'enter_title'.tr(),
                          labelText: 'title'.tr(),
                        ),
                        validator: (title) {
                          if (title?.trim().isEmpty == true) {
                            return 'title_cannot_be_empty'.tr();
                          }
                          return null;
                        },
                        onSaved: (newValue) {
                          title = newValue!.trim();
                        },
                        onFieldSubmitted: (_) {
                          _descriptionFocusNode.requestFocus();
                        },
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      TextFormField(
                        initialValue: description,
                        focusNode: _descriptionFocusNode,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          hintText: 'enter_description'.tr(),
                          labelText: 'description'.tr(),
                        ),
                        validator: (description) {
                          if (description?.trim().isEmpty == true) {
                            return 'description_cannot_be_empty'.tr();
                          }
                          return null;
                        },
                        onSaved: (newValue) {
                          description = newValue!.trim();
                        },
                        onFieldSubmitted: (_) {
                          _onSave();
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _onSave,
                    child: Text(
                      'save'.tr(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onSave() {
    if (_formKey.currentState?.validate() == true) {
      _formKey.currentState!.save();
      if (!isCreate) {
        if (widget.title == title && widget.description == description) {
          Navigator.of(context).pop();
        } else {
          context.read<CreateEditCubit>().updateObject(
                id: widget.id!,
                title: title,
                description: description,
              );
        }
      } else {
        context.read<CreateEditCubit>().createObject(
              title: title,
              description: description,
            );
      }
    }
  }
}
