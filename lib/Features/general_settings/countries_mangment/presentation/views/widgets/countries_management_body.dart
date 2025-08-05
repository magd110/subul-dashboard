import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:subul_dashboard2/Features/general_settings/countries_mangment/data/repos/get_countries_repo_impl.dart';
import 'package:subul_dashboard2/Features/general_settings/countries_mangment/presentation/manager/countries_cubit.dart';
import 'package:subul_dashboard2/Features/general_settings/countries_mangment/presentation/manager/countries_state.dart';
import 'package:subul_dashboard2/Features/general_settings/countries_mangment/presentation/manager/country_create_cubit.dart';
import 'package:subul_dashboard2/Features/general_settings/countries_mangment/presentation/views/widgets/country_dialog.dart';
import 'package:subul_dashboard2/Features/general_settings/widgets/add_button.dart';
import 'package:subul_dashboard2/core/utils/app_colors.dart';
import 'package:subul_dashboard2/core/utils/app_sizes.dart';
import 'package:subul_dashboard2/core/utils/service_locator.dart';

class CountriesManagementBody extends StatelessWidget {
  const CountriesManagementBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CountriesCubit, CountriesState>(
      builder: (context, state) {
        if (state is CountriesLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is CountriesSuccess) {
          final countries = state.countries;

          return Column(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    border: Border.all(color: AppColors.deepPurple, width: 3.0),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  width: AppSizes.widthRatio(context, 856),
                  child: RefreshIndicator(
                    onRefresh: () async {
                      context.read<CountriesCubit>().getCountries();
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 20),
                      child: GridView.builder(
                        physics: const AlwaysScrollableScrollPhysics(),
                        padding: const EdgeInsets.symmetric(horizontal: 30.0),
                        // padding: const EdgeInsets.all(10),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          childAspectRatio: 5,
                        ),
                        itemCount:
                            countries.length,
                        itemBuilder: (context, index) {
                          final country =
                              countries[index]; 
                          return Center(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.baseline,
                              textBaseline: TextBaseline.alphabetic,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  country.code,
                                  style: TextStyle(
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(width: 10),
                                Expanded(
                                  child: Text(
                                    country.name,
                                    style: TextStyle(
                                      fontSize: 30.sp,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.deepPurple,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: AppSizes.heightRatio(context, 30)),
              Align(
                alignment: Alignment.centerRight,
                child: AddButton(
                  text: 'إضافة بلد',
                  icon: FontAwesomeIcons.plus,
                  onPressed: () {
                    final countriesCubit =
                        context.read<CountriesCubit>(); 

                    showDialog(
                      context: context,
                      builder: (dialogContext) {
                        return MultiBlocProvider(
                          providers: [
                            BlocProvider(
                              create: (_) => CountryCreateCubit(
                                  getIt.get<GetCountriesRepoImpl>()),
                            ),
                            BlocProvider.value(
                             
                              value: countriesCubit,
                            ),
                          ],
                          child: CountryDialog(title: 'إضافة بلد جديد'),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          );
        } else if (state is CountriesFailure) {
          return Center(child: Text('حدث خطأ: ${state.errorMessage}'));
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
