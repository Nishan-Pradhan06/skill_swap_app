import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:skill_swap/core/di/dependency_injection.dart';
import 'package:skill_swap/core/theme/app_theme.dart';
import 'package:skill_swap/core/widgets/custom_appbar.dart';
import 'package:skill_swap/core/widgets/custom_padding.dart';
import 'package:skill_swap/core/widgets/custom_text_form_field.dart';
import 'package:skill_swap/features/learner/home/widgets/custom_skill_card.dart';
import 'package:skill_swap/features/skill_swap/blocs/skill_search_bloc.dart';
import 'package:skill_swap/router/app_routes_names.dart';
import 'package:skeletonizer/skeletonizer.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<SkillSearchBloc>(),
      child: const _SearchScreenView(),
    );
  }
}

class _SearchScreenView extends StatefulWidget {
  const _SearchScreenView();

  @override
  State<_SearchScreenView> createState() => _SearchScreenViewState();
}

class _SearchScreenViewState extends State<_SearchScreenView> {
  final TextEditingController _searchController = TextEditingController();
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      context.read<SkillSearchBloc>().add(
        SkillSearchEvent.searchQueryChanged(_searchController.text),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final darkTextTheme = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: SafeArea(
        child: CustomPadding(
          child: Column(
            spacing: 10,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomBackButton(),
              CustomTextField(
                hint: 'Search skills...',
                borderColor: Colors.transparent,
                borderRadius: 18,
                leading: const Icon(Icons.search),
                controller: _searchController,
                type: CustomTextFieldType.text,
                fillColor: darkTextTheme
                    ? const Color(0XFF272c29)
                    : AppTheme.surfaceLight,
              ),
              Expanded(
                child: BlocBuilder<SkillSearchBloc, SkillSearchState>(
                  builder: (context, state) {
                    return state.maybeWhen(
                      loading: () => ListView.builder(
                        itemCount: 5,
                        itemBuilder: (context, index) => const Skeletonizer(
                          enabled: true,
                          child: Padding(
                            padding: EdgeInsets.only(bottom: 12.0),
                            child: CustomSkillCard(
                              userName: "Skeleton User",
                              userProfileUrl: "",
                              categoryTitle: "Category",
                              skillTitle: "Skill Title",
                              skillDescription: "Description loading...",
                              skillList: [],
                              point: "0",
                            ),
                          ),
                        ),
                      ),
                      loaded: (posts) {
                        if (posts.isEmpty) {
                          return const Center(child: Text('No skills found'));
                        }
                        return ListView.builder(
                          itemCount: posts.length,
                          itemBuilder: (context, index) {
                            final skill = posts[index];
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 12.0),
                              child: CustomSkillCard(
                                userName: skill.user.fullName,
                                userProfileUrl: skill.user.profileImage ?? '',
                                categoryTitle:
                                    skill.category?.name ?? 'General',
                                skillTitle: skill.skillToLearn,
                                skillDescription: skill.description,
                                skillList: [],
                                point: skill.pointsCost.toString(),
                                onTap: () {
                                  context.pushNamed(
                                    AppRoutesName.skillCardDetails,
                                    extra: skill,
                                  );
                                },
                              ),
                            );
                          },
                        );
                      },
                      failure: (message) => Center(child: Text(message)),
                      orElse: () => const Center(
                        child: Text('Type to search for skills'),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
