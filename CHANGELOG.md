# Changelog

All notable changes to this project are documented in this file.

Format based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/).

## [0.4.0](https://github.com/dariomatias-dev/sql_studio_app/compare/sql_studio-v0.3.0...sql_studio-v0.4.0) (2026-09-06)


### Features

* **a11y:** add semantic labels and clamp text scaling ([c2a9080](https://github.com/dariomatias-dev/sql_studio_app/commit/c2a9080c5b1b3130dda850496b0a9632d1ba0c63))
* add About screen with a custom license viewer ([0c5d560](https://github.com/dariomatias-dev/sql_studio_app/commit/0c5d56000d2187db263256bbe1ca75be511f9657))
* add URL opening in settings screen ([46c6729](https://github.com/dariomatias-dev/sql_studio_app/commit/46c67293d2edeb537c3e0f294fde9355fd213929))
* added `SqlCommandsNotifier` to the widget tree ([e76bd82](https://github.com/dariomatias-dev/sql_studio_app/commit/e76bd8230974e460594cd222a6f3c7102b44a6e1))
* added app version display ([f3386e2](https://github.com/dariomatias-dev/sql_studio_app/commit/f3386e2200fe4d47e96e8c0947cc4d46eb20d339))
* added result handling to `DatabaseService` ([31ae0da](https://github.com/dariomatias-dev/sql_studio_app/commit/31ae0da1171e2062d9ba5efaa273085050da6705))
* added smoothed version of app icon ([541f9ad](https://github.com/dariomatias-dev/sql_studio_app/commit/541f9ad70375f8c4c845be340801683d979cc898))
* added SQL export ([b3eebbf](https://github.com/dariomatias-dev/sql_studio_app/commit/b3eebbf5f01eee4e8610ab2c38a638a2806feed6))
* **android/app/build.gradle.kts:** configure signing ([94e4191](https://github.com/dariomatias-dev/sql_studio_app/commit/94e41918e7670c0cd43c161eb7a346d173cd5c91))
* **assets/sql/schemas:** add table drop commands ([950f897](https://github.com/dariomatias-dev/sql_studio_app/commit/950f89709b6bd3f870c25c5959caf837e6ac9c9a))
* **assets/sql/seeds:** expand records ([440a871](https://github.com/dariomatias-dev/sql_studio_app/commit/440a87198fd13c3238cf17cbdc5d67c8f666ed7d))
* **assets/sql:** create new schemas and seeds ([91df07d](https://github.com/dariomatias-dev/sql_studio_app/commit/91df07d4b5e4a5653bf077b9ffcf68fdb25769c7))
* configure internationalization ([1f99445](https://github.com/dariomatias-dev/sql_studio_app/commit/1f994456de40f57b8694b1f71daa9e170ca3d833))
* configured routes ([b143072](https://github.com/dariomatias-dev/sql_studio_app/commit/b143072eb49a6c0707c1caa2d91768d45321b156))
* **console:** add empty states for query execution ([1ab7588](https://github.com/dariomatias-dev/sql_studio_app/commit/1ab75885195582649750e4d63abff9537b7eee46))
* **core:** add an injectable logger behind a contract ([9d9a266](https://github.com/dariomatias-dev/sql_studio_app/commit/9d9a2661848c91b8cefb3bc0deb4b7d943cb03d5))
* **core:** add Riverpod infrastructure and feature architecture ([1a297d0](https://github.com/dariomatias-dev/sql_studio_app/commit/1a297d08ab2efa469ba4ec9e16003b4b6db61460))
* **core:** install global error handlers and a startup failure screen ([0d482fd](https://github.com/dariomatias-dev/sql_studio_app/commit/0d482fd37f993e8ad37762b3712b23e4cdf7a256))
* created class for `SharedPreferences` abstraction ([a3dd333](https://github.com/dariomatias-dev/sql_studio_app/commit/a3dd33308e1e330cc19d3a4290a7b8c6d90a77e2))
* created database repository ([079e6bb](https://github.com/dariomatias-dev/sql_studio_app/commit/079e6bbab6abb935612d63525ceddda62354466c))
* created editor and console components ([a9a3166](https://github.com/dariomatias-dev/sql_studio_app/commit/a9a316622ecee28d3d53c8f5bc9b46224cade2f8))
* created initial structure for main screens ([f249dca](https://github.com/dariomatias-dev/sql_studio_app/commit/f249dca5cce6e85d4594a2404b38c1798c4b4cb6))
* created schemas for default databases ([2214ecb](https://github.com/dariomatias-dev/sql_studio_app/commit/2214ecbdd0101f1b4c9b194a48b2a97aa84ac46d))
* created seeds for default databases ([181c255](https://github.com/dariomatias-dev/sql_studio_app/commit/181c255d36605b5ef6fa3dddc4fee57208ad1214))
* **database-visualizer:** add navigate-to-table action from schema diagram ([9f6ebf2](https://github.com/dariomatias-dev/sql_studio_app/commit/9f6ebf2cefdb36bceed6d578351dbf3cecd386aa))
* **database-visualizer:** fit diagram to the viewport on load ([9acc62b](https://github.com/dariomatias-dev/sql_studio_app/commit/9acc62b084445463579f2123e428cbde462b2411))
* **database:** add search filter to the databases list ([cbb53c2](https://github.com/dariomatias-dev/sql_studio_app/commit/cbb53c2af8270ac6dfa70fbe2a246e3c4180f0ae))
* **feedback:** add toast confirmation for database actions ([2fa3193](https://github.com/dariomatias-dev/sql_studio_app/commit/2fa3193d2db6c76f17a20d4d4db2efa68ea8e76c))
* **l10n:** add l10n.yaml and describe every ARB key ([eb8ae0b](https://github.com/dariomatias-dev/sql_studio_app/commit/eb8ae0b05e53d61d3cd7107fdb26eb61d35c4d8f))
* **lib/l10n:** added translations for `SqlExecutionService` ([8d357a3](https://github.com/dariomatias-dev/sql_studio_app/commit/8d357a39ef62e604b23f1f7fa93b0aa7dff42d6a))
* **lib/src/core/constants/default_databases.dart:** add new default databases ([03b88ab](https://github.com/dariomatias-dev/sql_studio_app/commit/03b88ab5f9a6282514a882c5381ead6f1c590d26))
* **lib/src/core/navigation/widgets/root_drawer:** refactor design ([430d31e](https://github.com/dariomatias-dev/sql_studio_app/commit/430d31e96158579b9aa83c0bb4ce26b55a8bb804))
* **lib/src/core/navigation:** refactor navigation bar ([92e765b](https://github.com/dariomatias-dev/sql_studio_app/commit/92e765be9c94494fc194d58b1cf629ba8fb1125b))
* **lib/src/core/result.dart:** added `DatabaseSuccess` class ([b0f6353](https://github.com/dariomatias-dev/sql_studio_app/commit/b0f6353428baa6653d7fc908e420ab17e75d97bb))
* **lib/src/core/routes:** refactored routing ([bf3a9d9](https://github.com/dariomatias-dev/sql_studio_app/commit/bf3a9d97261798abf0c07b6d26925b3400185527))
* **lib/src/core/routes:** updated routes ([4244fc8](https://github.com/dariomatias-dev/sql_studio_app/commit/4244fc845119d5cda426fb550fc1f7d0288119ac))
* **lib/src/core/types/sql_advanced_suggestion_model.dart:** added new features ([ee71cdc](https://github.com/dariomatias-dev/sql_studio_app/commit/ee71cdcc21a9a7c212b4f2bb6393c8c5a6877662))
* **lib/src/core:** created classes to handle results ([2411cb3](https://github.com/dariomatias-dev/sql_studio_app/commit/2411cb34c334182ca04246b47985978c2df870b3))
* **lib/src/core:** created list extension ([6e5583a](https://github.com/dariomatias-dev/sql_studio_app/commit/6e5583a0594547e9c28be776f39cbc9f26b1fee0))
* **lib/src/core:** created new global navigation structure ([4403ff9](https://github.com/dariomatias-dev/sql_studio_app/commit/4403ff94429eed273df86ec107cca64a28caf91b))
* **lib/src/notifiers/database_notifier.dart:** exposed `getByName` method ([f064a7c](https://github.com/dariomatias-dev/sql_studio_app/commit/f064a7cd2abd27ebf8e060c33364ca3219e1a66d))
* **lib/src/notifiers/sql_commands_notifier.dart:** add result handling to `resetDatabase` method ([240dc80](https://github.com/dariomatias-dev/sql_studio_app/commit/240dc802b2e4a7d0763677eb0ce9a45bb058d21f))
* **lib/src/notifiers/sql_commands_notifier.dart:** added `activeDatabase` property ([cec6515](https://github.com/dariomatias-dev/sql_studio_app/commit/cec651596213347cebfd29db07a8b92b3dabce48))
* **lib/src/notifiers/sql_commands_notifier.dart:** added `getTableColumns` method ([214e6b5](https://github.com/dariomatias-dev/sql_studio_app/commit/214e6b5ce92de3650a5a26bbd829565c466460dd))
* **lib/src/notifiers/sql_commands_notifier.dart:** added method to reset default database ([144309c](https://github.com/dariomatias-dev/sql_studio_app/commit/144309c0f83cfa044716f80ce27420e615a43188))
* **lib/src/notifiers/sql_commands_notifier.dart:** simplify reset method ([94149e3](https://github.com/dariomatias-dev/sql_studio_app/commit/94149e33a544d2ccc4e037683b0ae7406e236fb1))
* **lib/src/notifiers/sql_editor_notifier.dart:** add auto-selection to `insertCommand` method ([d4c3adf](https://github.com/dariomatias-dev/sql_studio_app/commit/d4c3adf59f1e429e3a451666c43d156e8c106ed6))
* **lib/src/notifiers/sql_editor_notifier.dart:** disable auto-suggestion in code field ([6e39027](https://github.com/dariomatias-dev/sql_studio_app/commit/6e390274ac2cc9d574bee001cb2b75b106080e08))
* **lib/src/notifiers/sql_suggestions_notifier.dart:** add management for all types of suggestions ([92f8dd5](https://github.com/dariomatias-dev/sql_studio_app/commit/92f8dd57c6c6012363103bab188988d9e016146d))
* **lib/src/notifiers/sql_suggestions_notifier.dart:** added result handling ([388c596](https://github.com/dariomatias-dev/sql_studio_app/commit/388c59685148460ab22220252f858ad91503783f))
* **lib/src/notifiers/sql_suggestions_notifier.dart:** removed SQL advanced suggestions list ([fbc93d2](https://github.com/dariomatias-dev/sql_studio_app/commit/fbc93d29e56985c371ab7ea0238b02b2154f7ddd))
* **lib/src/notifiers/sql_suggestions_notifier.dart:** removed SQL advanced suggestions list ([156dfbe](https://github.com/dariomatias-dev/sql_studio_app/commit/156dfbe38f7565364854d19dd886c0ba51c2228a))
* **lib/src/notifiers/sql_suggestions_notifiers/sql_advanced_suggestions_notifier.dart:** created `reorderSuggestions` method ([8bde175](https://github.com/dariomatias-dev/sql_studio_app/commit/8bde17547378f2d0b28c92316d961156f204d0b5))
* **lib/src/notifiers/sql_suggestions_notifiers/sql_basic_suggestions_notifier.dart:** added result handling support ([f6d9eb8](https://github.com/dariomatias-dev/sql_studio_app/commit/f6d9eb8cf15686ad934c44c0ae858c7986451bd2))
* **lib/src/notifiers/sql_suggestions_notifiers:** created notifier dedicated to basic suggestions ([b3ce640](https://github.com/dariomatias-dev/sql_studio_app/commit/b3ce640a5c3eba8447ccf4f998ecf54c29bf76e8))
* **lib/src/notifiers/workspace_layout_notifier.dart:** added result handling ([2e3a552](https://github.com/dariomatias-dev/sql_studio_app/commit/2e3a552fde8c8bbbb43fb7c6f407fd2f33336ca3))
* **lib/src/notifiers:** created app version notifier ([bcf9905](https://github.com/dariomatias-dev/sql_studio_app/commit/bcf99056ba14f2a3b633a5ffbe8a51bb5fdb02aa))
* **lib/src/notifiers:** created notifier for databases ([735cde2](https://github.com/dariomatias-dev/sql_studio_app/commit/735cde2323eec2482305b77e6c20b8194efeffdd))
* **lib/src/notifiers:** created notifier for the code editor element ([a07ce3a](https://github.com/dariomatias-dev/sql_studio_app/commit/a07ce3ad5cd15e9631d40e56b4c11a2efe35b8a8))
* **lib/src/notifiers:** created SQL advanced suggestions notifier ([22ab7a3](https://github.com/dariomatias-dev/sql_studio_app/commit/22ab7a32533239a975fd33c9457bcf4f3c1be37a))
* **lib/src/repositories/database_repository.dart:** added customizable `getWhere` method ([ba089da](https://github.com/dariomatias-dev/sql_studio_app/commit/ba089dabf2dd90333644555b54ac660c41c35eb1))
* **lib/src/repositories/database_repository.dart:** created `insertAll` method ([70efb28](https://github.com/dariomatias-dev/sql_studio_app/commit/70efb28d2238d0b45df9904d9f82277aecd4f9ee))
* **lib/src/repositories/migrations.dart:** created SQL advanced suggestions table ([a09061a](https://github.com/dariomatias-dev/sql_studio_app/commit/a09061a4597dff40025e3292f9c0d250fb0f85e3))
* **lib/src/repositories:** added creation of app tables ([bad219c](https://github.com/dariomatias-dev/sql_studio_app/commit/bad219c75f91ae82c43c11b9244f72ac8bdbc0a3))
* **lib/src/screen/home/home_screen.dart:** created base structure ([27f416f](https://github.com/dariomatias-dev/sql_studio_app/commit/27f416f1268e343febeeef7cd6043d6497b2267e))
* **lib/src/screen/home:** created suggestions component ([80fb8fe](https://github.com/dariomatias-dev/sql_studio_app/commit/80fb8fe7e582305e074064eabad0909997a57642))
* **lib/src/screen/main/main_screen.dart:** added swipe gesture navigation ([1e83ad7](https://github.com/dariomatias-dev/sql_studio_app/commit/1e83ad7b2e58fee3520df63da80ac2a046abecf7))
* **lib/src/screen/main/main_screen.dart:** added swipe navigation on bottom navigation bar ([2d0d88f](https://github.com/dariomatias-dev/sql_studio_app/commit/2d0d88f0ea1fca1634bfbe3a2f6e7d039a1a3149))
* **lib/src/screen/main/main_screen.dart:** removed database creation button ([7d584d8](https://github.com/dariomatias-dev/sql_studio_app/commit/7d584d8bbf97f3bd9a0e92a2c9994dd186f6ce77))
* **lib/src/screen/main/widgets/drawer/drawer_database_list_tile_widget.dart:** added confirmation dialog for database deletion ([ffd4663](https://github.com/dariomatias-dev/sql_studio_app/commit/ffd46634d05f4bc3cc2e2424420b146b57819bb7))
* **lib/src/screen/main/widgets/drawer/drawer_database_list_tile_widget.dart:** improved design ([9fe8069](https://github.com/dariomatias-dev/sql_studio_app/commit/9fe80696fbe1d76087ae767a58eae35c5cab5f2c))
* **lib/src/screen/main/widgets/drawer/drawer_widget.dart:** refactored component ([420d664](https://github.com/dariomatias-dev/sql_studio_app/commit/420d6640cabd97af02333f079f54819e0b98d505))
* **lib/src/screen/main/widgets:** simplified components using text fields ([c4c9562](https://github.com/dariomatias-dev/sql_studio_app/commit/c4c9562dab07bf34437b2e342f79d9b494dafe13))
* **lib/src/screen/main:** created database creation dialog ([fa5131b](https://github.com/dariomatias-dev/sql_studio_app/commit/fa5131b70fd6d8b10cd23f0cc6514ec8fc170eee))
* **lib/src/screen/main:** implemented AppBar ([8bbb3d8](https://github.com/dariomatias-dev/sql_studio_app/commit/8bbb3d8ce6229d595b9a044d245790ad1a37206b))
* **lib/src/screen/settings/settings_screen.dart:** created initial drawer structure ([94fc567](https://github.com/dariomatias-dev/sql_studio_app/commit/94fc567c60cba0d7979e0c15b2f82c5b52034d8b))
* **lib/src/screen/settings/settings_screen.dart:** created initial structure ([ee3a117](https://github.com/dariomatias-dev/sql_studio_app/commit/ee3a11708d8730131d6011c5d1925420c0e0aa4b))
* **lib/src/screen/settings:** restructured elements ([af60a91](https://github.com/dariomatias-dev/sql_studio_app/commit/af60a91b9c6e3d1e51577133a82f81ee40d3b3bc))
* **lib/src/screen:** added tooltips and standardized component organization ([441d968](https://github.com/dariomatias-dev/sql_studio_app/commit/441d9681a5007a36b38904ad8fa6ea43da70d8eb))
* **lib/src/screen:** created SplashScreen ([eb30a5a](https://github.com/dariomatias-dev/sql_studio_app/commit/eb30a5ab494b82117038fb871008f91954b0d907))
* **lib/src/screen:** implemented `ConfirmationDialogWidget` ([36e9a3a](https://github.com/dariomatias-dev/sql_studio_app/commit/36e9a3a256b96a1a9d017a524ceccc54dba20988))
* **lib/src/screen:** implemented `InputDialogWidget` ([3facbc2](https://github.com/dariomatias-dev/sql_studio_app/commit/3facbc265439752bcb6247e1c1e52deb4b7ee4b1))
* **lib/src/screen:** improved screen transitions ([87769ba](https://github.com/dariomatias-dev/sql_studio_app/commit/87769bade092222b344629d079ca1ed8a38729f2))
* **lib/src/screens/database_visualizer/database_visualizer_screen.dart:** develop display of database structure ([32b8576](https://github.com/dariomatias-dev/sql_studio_app/commit/32b857633e7289a0711f90fcbe7a4d885bb5bf86))
* **lib/src/screens/database_visualizer:** componentize table element ([deb6367](https://github.com/dariomatias-dev/sql_studio_app/commit/deb636779c854b663abb63ec4a5f597c5c81fd17))
* **lib/src/screens/database_visualizer:** refactor design ([0a83548](https://github.com/dariomatias-dev/sql_studio_app/commit/0a83548693867f4b5166e6a6c1fcde898f1019a5))
* **lib/src/screens/databases/databases_screen.dart:** added `PopupMenuButtonWidget` ([e85c8c3](https://github.com/dariomatias-dev/sql_studio_app/commit/e85c8c3b1a35828a5344f7dce2c961811cbfa324))
* **lib/src/screens/databases/databases_screen.dart:** created screen structure ([259e17a](https://github.com/dariomatias-dev/sql_studio_app/commit/259e17a0e1c52d475602b512bdcf4ec0ca04f243))
* **lib/src/screens/databases/databases_screen.dart:** implemented `CardWidget` ([0ba4bf5](https://github.com/dariomatias-dev/sql_studio_app/commit/0ba4bf566e741180fb208e18e8291714eb6baaf5))
* **lib/src/screens/databases/databases_screen.dart:** implemented card option methods ([eff780e](https://github.com/dariomatias-dev/sql_studio_app/commit/eff780e0409146e65321cde56946ecdbc8cf83fd))
* **lib/src/screens/databases/databases_screen.dart:** simplified methods ([9f81c08](https://github.com/dariomatias-dev/sql_studio_app/commit/9f81c08b8e89ebcf4f37cc359007fdf379890453))
* **lib/src/screens/databases/widgets/database_card_widget.dart:** refactor design ([076331f](https://github.com/dariomatias-dev/sql_studio_app/commit/076331f247fe9b9ca7963d2e515929d5536f57d6))
* **lib/src/screens/databases:** componentized database card element ([3f61617](https://github.com/dariomatias-dev/sql_studio_app/commit/3f61617c93637df0d78aeedab061448fc734d59c))
* **lib/src/screens/home/home_screen.dart:** simplified screen ([fa87cac](https://github.com/dariomatias-dev/sql_studio_app/commit/fa87cac6fbb51726681b9f09b481719c03a9bb64))
* **lib/src/screens/home/widgets/console_widget.dart:** added usage of `getTableColumns` ([7542133](https://github.com/dariomatias-dev/sql_studio_app/commit/754213380932398c3030c5d6fa4f62fc818599f1))
* **lib/src/screens/home/widgets/console_widget.dart:** improved design and column name display ([f9e4a7e](https://github.com/dariomatias-dev/sql_studio_app/commit/f9e4a7eea7885f44c282a9185ccec6f3e08ebd0a))
* **lib/src/screens/home/widgets/panel_widget.dart:** defined default body style ([b38938d](https://github.com/dariomatias-dev/sql_studio_app/commit/b38938d4c38fedb443b9c191dc4c5cdc10daa22d))
* **lib/src/screens/home/widgets:** added display of selected database name ([037a141](https://github.com/dariomatias-dev/sql_studio_app/commit/037a1416f5109b6ae054c39cde79f1d430d99c12))
* **lib/src/screens/home/widgets:** added execution and display of SQL commands ([c8df98a](https://github.com/dariomatias-dev/sql_studio_app/commit/c8df98a8c3381670b892ba977c3158abc43b8a7c))
* **lib/src/screens/home/widgets:** componentized `StyledDataTableWidget` ([e4a9d21](https://github.com/dariomatias-dev/sql_studio_app/commit/e4a9d2158cf0e2d01e494999ff770bef8a26309c))
* **lib/src/screens/main/screens/databases/widgets/database_card_widget.dart:** add option to view database structure ([610056a](https://github.com/dariomatias-dev/sql_studio_app/commit/610056a8a30b469075d615370291560cc5af03b7))
* **lib/src/screens/main/screens/databases/widgets/database_card_widget.dart:** redesigned component ([43b859a](https://github.com/dariomatias-dev/sql_studio_app/commit/43b859a6ae4661d332a7b9dc7b542d6330f01ff9))
* **lib/src/screens/main/screens/settings/widgets:** develop language selection element ([deaa4e0](https://github.com/dariomatias-dev/sql_studio_app/commit/deaa4e00ca3cdf0d7b7331c13b9f8a7157abe516))
* **lib/src/screens/main/widgets/create_database_dialog_widget.dart:** added database existence check before creation ([4ee8d43](https://github.com/dariomatias-dev/sql_studio_app/commit/4ee8d431a063cc496e4490d28437a4b2941037b9))
* **lib/src/screens/main/widgets/create_database_dialog_widget.dart:** refactored component ([14199ec](https://github.com/dariomatias-dev/sql_studio_app/commit/14199ecf87c91ad6af77f2820e8ffb88cf1d8b1e))
* **lib/src/screens/main/widgets/drawer/create_database_dialog_widget.dart:** add automatic focus when creating a database ([e54d43a](https://github.com/dariomatias-dev/sql_studio_app/commit/e54d43a91fbfc721b553c87ca28d16d9bffc4b61))
* **lib/src/screens/main/widgets/drawer/drawer_database_group/drawer_database_list_tile_widget.dart:** add reset of selected database when it is removed ([f070b7a](https://github.com/dariomatias-dev/sql_studio_app/commit/f070b7a5b7760350363187f0758cbaa5fafeac2e))
* **lib/src/screens/main/widgets/drawer/drawer_database_group/drawer_database_list_tile_widget.dart:** added click visual feedback ([753ebdc](https://github.com/dariomatias-dev/sql_studio_app/commit/753ebdce25004391870ccc4884e9c25684d116a1))
* **lib/src/screens/main/widgets/drawer/drawer_database_group/drawer_database_list_tile_widget.dart:** added database selection ([f7fa824](https://github.com/dariomatias-dev/sql_studio_app/commit/f7fa824ed2532fdace6e507bd3eee8fd5aa1f3c4))
* **lib/src/screens/main/widgets/drawer/drawer_database_group/drawer_database_list_tile_widget.dart:** enhanced database selection ([d6b0f1a](https://github.com/dariomatias-dev/sql_studio_app/commit/d6b0f1a3933d234331d3d1f55de1bf37ccea60d4))
* **lib/src/screens/main/widgets/drawer/drawer_database_group/drawer_database_list_tile_widget.dart:** implemented `PopupMenuButtonWidget` ([268872a](https://github.com/dariomatias-dev/sql_studio_app/commit/268872a053879b5839c99adda10dc0c055b09922))
* **lib/src/screens/main/widgets/drawer/drawer_database_group/drawer_database_list_tile_widget.dart:** removed usage of `SnackBarUtils` ([0a55094](https://github.com/dariomatias-dev/sql_studio_app/commit/0a55094b7343a67e37ba2caceeb76851364e6d81))
* **lib/src/screens/main/widgets/drawer/drawer_database_group:** componentize database removal dialog ([fa87286](https://github.com/dariomatias-dev/sql_studio_app/commit/fa8728652fbf50a05a487737bfaf23bd8b083c77))
* **lib/src/screens/main/widgets/drawer/drawer_database_group:** rename `DrawerDatabaseListTileWidget` component ([35cf9f5](https://github.com/dariomatias-dev/sql_studio_app/commit/35cf9f5d22f68388b62243824c92855595fcbcbc))
* **lib/src/screens/main/widgets/drawer/drawer_widget.dart:** add clear search field button ([8deaece](https://github.com/dariomatias-dev/sql_studio_app/commit/8deaece3bcba4b27b198093f7df39e11037f83f8))
* **lib/src/screens/main/widgets/drawer/drawer_widget.dart:** implemented `DatabaseNotifier` ([426da5a](https://github.com/dariomatias-dev/sql_studio_app/commit/426da5ac89960336d41af47f6fc2d1d0efcac616))
* **lib/src/screens/main/widgets/drawer:** improved design ([fb5497e](https://github.com/dariomatias-dev/sql_studio_app/commit/fb5497e8554c5f816b109c4353437a57d5186d92))
* **lib/src/screens/main/widgets/drawer:** minor design improvements ([5c9a985](https://github.com/dariomatias-dev/sql_studio_app/commit/5c9a985f94d49ab28dac18420d7e25074e6e9698))
* **lib/src/screens/main/widgets/drawer:** moved favorite and remove methods ([1301cb6](https://github.com/dariomatias-dev/sql_studio_app/commit/1301cb628cadbced838816b9c652f8027fb43a46))
* **lib/src/screens/main/widgets/drawer:** organized components ([9fdfb73](https://github.com/dariomatias-dev/sql_studio_app/commit/9fdfb73defb3b87bf653a017c0b879681c16376a))
* **lib/src/screens/main/widgets:** added database management operations ([77476b1](https://github.com/dariomatias-dev/sql_studio_app/commit/77476b1dbeee0c9fe2f2e070cd2da6b19f136406))
* **lib/src/screens/main/widgets:** moved `CreateDatabaseDialogWidget` component ([7bbb571](https://github.com/dariomatias-dev/sql_studio_app/commit/7bbb57100cbb5d9854afa62ef718e01b83ac110d))
* **lib/src/screens/main:** comment out features to be developed in the future ([ad76eea](https://github.com/dariomatias-dev/sql_studio_app/commit/ad76eea4813c92cc1bd29c8873d606f4f8e3b9dd))
* **lib/src/screens/main:** componentize main screen elements ([b60fe3a](https://github.com/dariomatias-dev/sql_studio_app/commit/b60fe3a30134e947fab5ccf3842a5e8f872bcd83))
* **lib/src/screens/settings:** implemented `CardWidget` ([3a87e81](https://github.com/dariomatias-dev/sql_studio_app/commit/3a87e8183db5f656634ac045a62d38d9ae71a531))
* **lib/src/screens/settings:** refactor design ([6704162](https://github.com/dariomatias-dev/sql_studio_app/commit/6704162e69729d5780253e3f4107263a4cbfe3bd))
* **lib/src/screens/splash/splash_screen.dart:** add result handling to `DefaultDatabaseService.init` ([e99f7ad](https://github.com/dariomatias-dev/sql_studio_app/commit/e99f7ad804d4b2c8cef60095b3edd1ea7f8ab4e7))
* **lib/src/screens/splash/splash_screen.dart:** added error handling ([7c2860b](https://github.com/dariomatias-dev/sql_studio_app/commit/7c2860bc912827baffbec2780b754b8a9dffd803))
* **lib/src/screens/splash/splash_screen.dart:** added error handling for `AppVersionNotifier` ([01b5ba1](https://github.com/dariomatias-dev/sql_studio_app/commit/01b5ba1faef87126ff4d9304b7dfd1471982d1d4))
* **lib/src/screens/splash/splash_screen.dart:** added result handling for `SqlSuggestionsNotifier` ([fa7f1bb](https://github.com/dariomatias-dev/sql_studio_app/commit/fa7f1bb1d5cb1f6f8cdbf23e2db8b0a94c77da10))
* **lib/src/screens/splash/splash_screen.dart:** added result handling for advanced suggestions loading ([a6c38c8](https://github.com/dariomatias-dev/sql_studio_app/commit/a6c38c80238e83460130e851ed511c4f9c1e7512))
* **lib/src/screens/splash/splash_screen.dart:** added result handling to basic suggestions loading ([81edd7f](https://github.com/dariomatias-dev/sql_studio_app/commit/81edd7fde546894966ad2371351a6f9606226c20))
* **lib/src/screens/splash/splash_screen.dart:** redesign screen ([7550bc4](https://github.com/dariomatias-dev/sql_studio_app/commit/7550bc4d27d2f0d51bb5889ec64867c4474c3b9e))
* **lib/src/screens/sql_advanced_suggestion_settings/sql_advanced_suggestion_settings_screen.dart:** add creation and deletion dialogs and tooltips to action buttons ([cfe7c61](https://github.com/dariomatias-dev/sql_studio_app/commit/cfe7c61d2c686baad004e80378131feaacfa8773))
* **lib/src/screens/sql_advanced_suggestion_settings/sql_advanced_suggestion_settings_screen.dart:** added update dialog call ([ee247df](https://github.com/dariomatias-dev/sql_studio_app/commit/ee247dfb52521b66a9e0dbfd0a9ea21cf052d487))
* **lib/src/screens/sql_advanced_suggestion_settings/sql_advanced_suggestion_settings_screen.dart:** implemented `SqlAdvancedSuggestionsNotifier` usage ([18ddfb6](https://github.com/dariomatias-dev/sql_studio_app/commit/18ddfb69a4706a8dbf165cf196338f401feee7b5))
* **lib/src/screens/sql_advanced_suggestion_settings/sql_advanced_suggestion_settings_screen.dart:** implemented `SuggestionsSettingsLayoutWidget` ([0551394](https://github.com/dariomatias-dev/sql_studio_app/commit/05513948dcf4614a68b9d243fa04415a93ce77b1))
* **lib/src/screens/sql_advanced_suggestion_settings/sql_advanced_suggestion_settings_screen.dart:** implemented suggestions ordering ([b471a1b](https://github.com/dariomatias-dev/sql_studio_app/commit/b471a1b3565f3dd75c94361c1f3ff0cbc7c79823))
* **lib/src/screens/sql_advanced_suggestion_settings/sql_advanced_suggestion_settings_screen.dart:** refactored creation of suggestions order notifier ([912dd45](https://github.com/dariomatias-dev/sql_studio_app/commit/912dd45131bede3c6144f7d52857aa05a50e1c0c))
* **lib/src/screens/sql_advanced_suggestion_settings/sql_advanced_suggestion_settings_screen.dart:** repositioned save button ([8370f87](https://github.com/dariomatias-dev/sql_studio_app/commit/8370f8788472b0238580430edb57b2cfd86cb6b4))
* **lib/src/screens/sql_advanced_suggestion_settings/widgets/create_sql_advanced_suggestion_dialog_widget.dart:** implemented `SqlAdvancedSuggestionFormDialogWidget` ([5a9f406](https://github.com/dariomatias-dev/sql_studio_app/commit/5a9f40657dff46f5412fbfe710dd2016ec73f40e))
* **lib/src/screens/sql_advanced_suggestion_settings/widgets/dialogs/reset_sql_advanced_suggestions_dialog_widget.dart:** add result handling ([dc00554](https://github.com/dariomatias-dev/sql_studio_app/commit/dc00554c382a9f3ca1482549a0e9590c9353c4fb))
* **lib/src/screens/sql_advanced_suggestion_settings/widgets:** create dialog for removing advanced SQL command suggestion ([535b1f4](https://github.com/dariomatias-dev/sql_studio_app/commit/535b1f4179f31d1da87b1fe363ec6f8d67d7e595))
* **lib/src/screens/sql_advanced_suggestion_settings/widgets:** created form dialog ([1b8a348](https://github.com/dariomatias-dev/sql_studio_app/commit/1b8a348d776c9b8348df6e1a2f7bed77ab379ad5))
* **lib/src/screens/sql_advanced_suggestion_settings/widgets:** created update dialog ([7bd3611](https://github.com/dariomatias-dev/sql_studio_app/commit/7bd361155adf861f1724fb7c70ed9e0a3f156d12))
* **lib/src/screens/sql_advanced_suggestion_settings:** added display of ordered suggestions ([de67164](https://github.com/dariomatias-dev/sql_studio_app/commit/de6716439220db449befddac5e840a41a8a05392))
* **lib/src/screens/sql_advanced_suggestion_settings:** componentized reset suggestions dialog ([d7f0fc0](https://github.com/dariomatias-dev/sql_studio_app/commit/d7f0fc066b9459883a76ddf885d16ac960803dfe))
* **lib/src/screens/sql_advanced_suggestion_settings:** componentized suggestion item ([c05de33](https://github.com/dariomatias-dev/sql_studio_app/commit/c05de33ed562d6596a81b1c3e9666347abbcaeac))
* **lib/src/screens/sql_advanced_suggestion_settings:** create dialog for adding advanced SQL command suggestion ([fbcded0](https://github.com/dariomatias-dev/sql_studio_app/commit/fbcded05035bf45b78f52043e9f0bc80cea9b5a7))
* **lib/src/screens/sql_advanced_suggestion_settings:** created controller ([cf08631](https://github.com/dariomatias-dev/sql_studio_app/commit/cf086313c3abd753c69ef0492ab0e251c830f6ef))
* **lib/src/screens/sql_advanced_suggestion_settings:** created dialogs folder ([f3cdacd](https://github.com/dariomatias-dev/sql_studio_app/commit/f3cdacdbdd095883c4e86d2999e6fa32a8305a2a))
* **lib/src/screens/sql_advanced_suggestion_settings:** moved create, update, and remove suggestion actions ([11fd07e](https://github.com/dariomatias-dev/sql_studio_app/commit/11fd07efbbdea39eade5ae779a00ba16fd876d1b))
* **lib/src/screens/sql_basic_suggestion_settings/sql_basic_suggestion_settings_screen.dart:** implemented `SuggestionsSettingsLayoutWidget` ([e76268c](https://github.com/dariomatias-dev/sql_studio_app/commit/e76268cde150d0cf39db71d8ae88cdbbc9c6a0a6))
* **lib/src/screens/sql_basic_suggestion_settings/widgets/dialogs/create_sql_basic_suggestion_dialog_widget.dart:** added result handling ([900a701](https://github.com/dariomatias-dev/sql_studio_app/commit/900a701141d770b26844f43f1f40a75e38a1b179))
* **lib/src/screens/sql_basic_suggestion_settings/widgets/dialogs/remove_sql_basic_suggestion_dialog_widget.dart:** added result handling ([1bfa98f](https://github.com/dariomatias-dev/sql_studio_app/commit/1bfa98f4faeb1983d59748634a697afda2631be4))
* **lib/src/screens/sql_basic_suggestion_settings/widgets/dialogs/reset_sql_basic_suggestions_dialog_widget.dart:** added result handling ([08e2fba](https://github.com/dariomatias-dev/sql_studio_app/commit/08e2fbac18e9c2fad6f976c84943c2d56ce60e7f))
* **lib/src/screens/sql_basic_suggestion_settings:** applied standardizations and componentizations ([8153b4d](https://github.com/dariomatias-dev/sql_studio_app/commit/8153b4d3fe3a9f8a1f57050c8a818169e2654786))
* **lib/src/screens/sql_basic_suggestion_settings:** componentized reset commands dialog ([2b94f00](https://github.com/dariomatias-dev/sql_studio_app/commit/2b94f00b64788da6203e52abb64998c080bf30c8))
* **lib/src/screens/sql_basic_suggestion_settings:** componentized suggestion card ([dfc22cb](https://github.com/dariomatias-dev/sql_studio_app/commit/dfc22cbef8136e21239ed029a8d2d10908dee7a9))
* **lib/src/screens/sql_basic_suggestion_settings:** created controller ([9137532](https://github.com/dariomatias-dev/sql_studio_app/commit/9137532edb946115a512b6845528ccbbf3c0c40b))
* **lib/src/screens/sql_basic_suggestion_settings:** created dialogs folder ([9698eff](https://github.com/dariomatias-dev/sql_studio_app/commit/9698eff6107a3b04db953aa68ff3de3d716518a5))
* **lib/src/screens/sql_basic_suggestion_settings:** implemented saving of suggestion order ([abe8b63](https://github.com/dariomatias-dev/sql_studio_app/commit/abe8b631b321e9d12a0cec805a7a12af2f12406e))
* **lib/src/screens/sql_basic_suggestion_settings:** renamed dialog components ([6fbc939](https://github.com/dariomatias-dev/sql_studio_app/commit/6fbc939cfc32735a7779559bcc0ef652d856d9a7))
* **lib/src/screens/sql_basic_suggestion_settings:** standardized texts ([65b17dc](https://github.com/dariomatias-dev/sql_studio_app/commit/65b17dce2e4476074e14d5ea5c49c0ef49badda7))
* **lib/src/screens/sql_command_settings/sql_command_settings_screen.dart:** added commands reset ([f9b1161](https://github.com/dariomatias-dev/sql_studio_app/commit/f9b1161f5215b85ec743ff7e2ea553b797c6db2f))
* **lib/src/screens/sql_command_settings:** componentized dialogs ([95098d4](https://github.com/dariomatias-dev/sql_studio_app/commit/95098d495095b583af411f8bce1b4910a01a311c))
* **lib/src/screens/sql_suggestion_settings/sql_suggestion_settings_screen.dart:** add result handling when initializing advanced suggestions ([e0d679e](https://github.com/dariomatias-dev/sql_studio_app/commit/e0d679e8f46a1066f64bb6cda02921d47c054ae3))
* **lib/src/screens/sql_suggestion_settings/sql_suggestion_settings_screen.dart:** added save button disable state ([8fffbc9](https://github.com/dariomatias-dev/sql_studio_app/commit/8fffbc9e2a89cac9f1af8f9f54e5e2be20854604))
* **lib/src/screens/sql_suggestion_settings/sql_suggestion_settings_screen.dart:** implement `SqlSuggestionsNotifier` ([b8c982f](https://github.com/dariomatias-dev/sql_studio_app/commit/b8c982f2f375c1f901a697fcc84e458ad2be3486))
* **lib/src/screens/sql_suggestion_settings/sql_suggestion_settings_screen.dart:** restructure settings state management ([87e9b87](https://github.com/dariomatias-dev/sql_studio_app/commit/87e9b8748db9ad4953647531b456a2f3264a92f1))
* **lib/src/screens/sql_suggestion_settings:** moved suggestion settings button to `SqlSuggestionSettingsCardWidget` ([8ddff3e](https://github.com/dariomatias-dev/sql_studio_app/commit/8ddff3e03d997e4df95efd059429faacdd78a59a))
* **lib/src/screens/workspace_layout/workspace_layout_screen.dart:** add `SqlWorkspaceWidget` ([d21626e](https://github.com/dariomatias-dev/sql_studio_app/commit/d21626e2886809eb901b0ef4ee532f501c34734a))
* **lib/src/screens/workspace_layout/workspace_layout_screen.dart:** added layout save handling ([ca757c0](https://github.com/dariomatias-dev/sql_studio_app/commit/ca757c030f81c461120fa6d2f7e013991fd54df9))
* **lib/src/screens:** added `SnackBar` display on successful suggestion save ([7e083f7](https://github.com/dariomatias-dev/sql_studio_app/commit/7e083f7cc620fed77d7055bbc29db86a0cc98988))
* **lib/src/screens:** added `SqlWorkspaceWidget` to `DefaultDatabaseScreen`, fullscreen icon, and active database selection ([ad9aae6](https://github.com/dariomatias-dev/sql_studio_app/commit/ad9aae6c95e83ad0800d4af306a99bd24c3e3172))
* **lib/src/screens:** added display and update of saved commands list ([4d0b3a9](https://github.com/dariomatias-dev/sql_studio_app/commit/4d0b3a9f4f872d008c1d9535cd3b255e23f0ef05))
* **lib/src/screens:** create screen for defining `SqlWorkspaceWidget` layout ([fe33534](https://github.com/dariomatias-dev/sql_studio_app/commit/fe33534617e8ebceedbef50cbbabdde45c96729e))
* **lib/src/screens:** implement `ScaffoldWidget` ([d77e9e7](https://github.com/dariomatias-dev/sql_studio_app/commit/d77e9e72e456bb45b394474f4f243760f7c22fa9))
* **lib/src/screen:** simplified usage of `ButtonWidget` ([a089d0b](https://github.com/dariomatias-dev/sql_studio_app/commit/a089d0bc7942d4a144b41f9263e3a0f5f22a901d))
* **lib/src/screens:** improve empty state, icon color, and database removal handling ([74aaeac](https://github.com/dariomatias-dev/sql_studio_app/commit/74aaeac819176e96be7474b5c0cbb7247e365967))
* **lib/src/screens:** moved main screens into dedicated folder ([e792e16](https://github.com/dariomatias-dev/sql_studio_app/commit/e792e1626e10d20f87751bdecd375bd6840f1f2c))
* **lib/src/screens:** preserved screen state ([0c1c4fb](https://github.com/dariomatias-dev/sql_studio_app/commit/0c1c4fbb619b0ae72515d940418ec2a039270fee))
* **lib/src/screens:** standardized screen styles ([cd4114d](https://github.com/dariomatias-dev/sql_studio_app/commit/cd4114de8e2aea82f9448effc83b81535b03e4a9))
* **lib/src/services/database_service.dart:** added method to retrieve database by name ([1011663](https://github.com/dariomatias-dev/sql_studio_app/commit/10116639ead8c36747f808ff463eb0c01c195c9e))
* **lib/src/services/database/default_database_service.dart:** add result handling ([27b46c8](https://github.com/dariomatias-dev/sql_studio_app/commit/27b46c8b52778790fcbc9b2935e56c3a87258b5d))
* **lib/src/services/shared_preferences_service.dart:** add integer methods ([b65d52e](https://github.com/dariomatias-dev/sql_studio_app/commit/b65d52e85caf8cc520fc2358376c48dac5adfd10))
* **lib/src/services/sql_execution_service.dart:** add support for executing multiple statements ([aad6949](https://github.com/dariomatias-dev/sql_studio_app/commit/aad69499a5e15ccb3aa4e961e6672e0bdc4b609f))
* **lib/src/services/sql_execution_service.dart:** added affected rows return ([9f68bc2](https://github.com/dariomatias-dev/sql_studio_app/commit/9f68bc29ef8c2254596ae1f1d0fb6626bc1cbabf))
* **lib/src/services/sql_execution_service.dart:** added method to get database table names ([c8e4617](https://github.com/dariomatias-dev/sql_studio_app/commit/c8e4617ad7a910303afcdd8662068084867acea1))
* **lib/src/services:** created service for databases table ([064a4aa](https://github.com/dariomatias-dev/sql_studio_app/commit/064a4aa313e81aeaa3f8ec6706394061e93e8320))
* **lib/src/services:** created service for executing SQL from editor ([d31d402](https://github.com/dariomatias-dev/sql_studio_app/commit/d31d402fa24f4d82013e0af61b475fde72ba9490))
* **lib/src/services:** created SQL advanced suggestions service ([ae7ae6b](https://github.com/dariomatias-dev/sql_studio_app/commit/ae7ae6bfd7e5472038af35cb4ce40b87fa23913f))
* **lib/src/shared/models/database_model.dart:** added new properties and methods to `DatabaseModel` ([b1ee6a7](https://github.com/dariomatias-dev/sql_studio_app/commit/b1ee6a7e42d6983c057b34e2e48c40c7445a8859))
* **lib/src/shared/utils/default_database_initializer.dart:** add versioning for executing schemas and seeds ([2b0b236](https://github.com/dariomatias-dev/sql_studio_app/commit/2b0b236bad9a876115f5ac7f3aa211061ba87124))
* **lib/src/shared/utils:** created function to handle errors ([e20cc79](https://github.com/dariomatias-dev/sql_studio_app/commit/e20cc79cc0563f2d24f3fdab9ebe41ff2be4cf42))
* **lib/src/shared/widgets/button_widget.dart:** defined predefined styles ([bca8c5c](https://github.com/dariomatias-dev/sql_studio_app/commit/bca8c5ca38ed454a7d9acb1dce22917cc492762e))
* **lib/src/shared/widgets/buttons/button_widget.dart:** add optional `padding` property ([81d4e74](https://github.com/dariomatias-dev/sql_studio_app/commit/81d4e7447b2e5265ae77edec22bc103046e04625))
* **lib/src/shared/widgets/buttons/loading_button_widget.dart:** added visual feedback for disabled state ([c335f99](https://github.com/dariomatias-dev/sql_studio_app/commit/c335f99c54bc5dd217dee2ca20de01470ad5caf2))
* **lib/src/shared/widgets/card_widget.dart:** add new property ([7960b2d](https://github.com/dariomatias-dev/sql_studio_app/commit/7960b2d80294ff55cf2f6615fbd8c044c1ce8a68))
* **lib/src/shared/widgets/dialogs/dialog_widget.dart:** refactor design ([d55a1cc](https://github.com/dariomatias-dev/sql_studio_app/commit/d55a1cc1671a55519be6ee13f5ad12c2378bbc8e))
* **lib/src/shared/widgets/dialogs/input_dialog_widget.dart:** created text input dialog ([8dc7a11](https://github.com/dariomatias-dev/sql_studio_app/commit/8dc7a117576d1a0da8c8ac211cbe05bae4337d80))
* **lib/src/shared/widgets/dialogs:** created error dialog ([223442d](https://github.com/dariomatias-dev/sql_studio_app/commit/223442d7dbad9df841a76b29abcad86c78180122))
* **lib/src/shared/widgets/input_widget.dart:** added `suffixIcon` property ([eea4e17](https://github.com/dariomatias-dev/sql_studio_app/commit/eea4e1762b96533797d917725f4d6f838e883678))
* **lib/src/shared/widgets/input_widget.dart:** refactor design ([931052b](https://github.com/dariomatias-dev/sql_studio_app/commit/931052bdbaf627575365925a2dbe0d1fdcbd7d38))
* **lib/src/shared/widgets/input_widget.dart:** standardize visual feedback ([5b98c5f](https://github.com/dariomatias-dev/sql_studio_app/commit/5b98c5fe421a5d910771716aa6c3989cce91992f))
* **lib/src/shared/widgets/sql_workspace/console/console_widget.dart:** improved information display ([eff261d](https://github.com/dariomatias-dev/sql_studio_app/commit/eff261da70deca646f1c5d96f511c07fb24fbfbe))
* **lib/src/shared/widgets/sql_workspace/console/console_widget.dart:** refactored execution result handling ([a864833](https://github.com/dariomatias-dev/sql_studio_app/commit/a86483302d1c32e546e550c9803f6b70c736b547))
* **lib/src/shared/widgets/sql_workspace/console:** created controller ([eb9ed01](https://github.com/dariomatias-dev/sql_studio_app/commit/eb9ed01ccdfdcf813fec86a0f180c3574a42e5b8))
* **lib/src/shared/widgets/sql_workspace/sql_editor/sql_editor_widget.dart:** add icon to access database visualization ([0139ad4](https://github.com/dariomatias-dev/sql_studio_app/commit/0139ad4a42c59b55484adfffe273e2951266739f))
* **lib/src/shared/widgets/sql_workspace/sql_editor/sql_editor_widget.dart:** added automatic focus when selecting a suggestion ([fb146e2](https://github.com/dariomatias-dev/sql_studio_app/commit/fb146e2b804416c9eaae5f736e4f167aef78261c))
* **lib/src/shared/widgets/sql_workspace/sql_editor/sql_editor_widget.dart:** added database reset option ([73c3dcd](https://github.com/dariomatias-dev/sql_studio_app/commit/73c3dcd3d26addcb1ff5c644d7f98b03719cde8e))
* **lib/src/shared/widgets/sql_workspace/sql_editor/sql_editor_widget.dart:** added new actions ([7f28e7a](https://github.com/dariomatias-dev/sql_studio_app/commit/7f28e7a466cf42ca0066122fe8cb8ad4ddd59c46))
* **lib/src/shared/widgets/sql_workspace/sql_editor/sql_editor_widget.dart:** added reset action ([f08485d](https://github.com/dariomatias-dev/sql_studio_app/commit/f08485d356eeb14aacd333be85d529ec07086670))
* **lib/src/shared/widgets/sql_workspace/sql_editor/sql_editor_widget.dart:** created popup menu element to simplify editor actions ([86dbfe6](https://github.com/dariomatias-dev/sql_studio_app/commit/86dbfe6d79359c3c1f0773cb8b5c31380fe171b3))
* **lib/src/shared/widgets/sql_workspace/sql_editor/sql_editor_widget.dart:** implement `SqlSuggestionsNotifier` ([cf6ef15](https://github.com/dariomatias-dev/sql_studio_app/commit/cf6ef1544a5a283a994d448a3b0a988e0f059224))
* **lib/src/shared/widgets/sql_workspace/sql_editor/sql_editor_widget.dart:** implemented SQL copy action ([002c1ce](https://github.com/dariomatias-dev/sql_studio_app/commit/002c1ce52207eed4bbb34b1dc0d126de9163e036))
* **lib/src/shared/widgets/sql_workspace/sql_editor/sql_editor_widget.dart:** update method names ([b9717d5](https://github.com/dariomatias-dev/sql_studio_app/commit/b9717d58c12e660107aa092e92d495ff5e3de711))
* **lib/src/shared/widgets/sql_workspace/sql_editor/sql_suggestions_bars/sql_advanced_suggestions_bar_widget.dart:** added usage of `SqlAdvancedSuggestionsNotifier` ([8d10a50](https://github.com/dariomatias-dev/sql_studio_app/commit/8d10a50313170e60f727524bd49a2e50a1f1069f))
* **lib/src/shared/widgets/sql_workspace/sql_editor/sql_suggestions_bars/sql_advanced_suggestions_bar_widget.dart:** simplify component ([db8c6b9](https://github.com/dariomatias-dev/sql_studio_app/commit/db8c6b98f28882490a14437ad13f3da4d9e3bf77))
* **lib/src/shared/widgets/sql_workspace/sql_editor/sql_suggestions_bars:** add property to define item padding in `SqlSuggestionsBarBaseWidget` ([5155c93](https://github.com/dariomatias-dev/sql_studio_app/commit/5155c936dcb904f3d61f708cfda48814a1fc63e2))
* **lib/src/shared/widgets/sql_workspace/sql_editor/sql_suggestions_bars:** create base component for suggestion bars ([4fc6ae1](https://github.com/dariomatias-dev/sql_studio_app/commit/4fc6ae1cab937b70979ca7bc05f8fb9b45c8f4fe))
* **lib/src/shared/widgets/sql_workspace/sql_editor/sql_suggestions_bars:** implement `SqlSuggestionsBarBaseWidget` ([08c8e1c](https://github.com/dariomatias-dev/sql_studio_app/commit/08c8e1cd5882ecd8b3b1398fec8bd19b2ff19057))
* **lib/src/shared/widgets/sql_workspace/sql_editor:** added suggestions filtering ([31e1627](https://github.com/dariomatias-dev/sql_studio_app/commit/31e16276dfd8bd573c7a941c560aaf24dacadea5))
* **lib/src/shared/widgets/sql_workspace/sql_editor:** create character suggestion bar component ([5f9f7cd](https://github.com/dariomatias-dev/sql_studio_app/commit/5f9f7cda54a5327152223c07c885a83e66c278ba))
* **lib/src/shared/widgets/sql_workspace/sql_editor:** create quick SQL suggestions component ([fd96ae2](https://github.com/dariomatias-dev/sql_studio_app/commit/fd96ae25e1192f15adb3eb9f51e2097ee1841357))
* **lib/src/shared/widgets/sql_workspace/sql_editor:** created controller ([c5fb1e2](https://github.com/dariomatias-dev/sql_studio_app/commit/c5fb1e299ed8e2a941c661ca81932da4b8ba72ca))
* **lib/src/shared/widgets/sql_workspace/sql_editor:** standardize suggestion bar component names ([e2141d5](https://github.com/dariomatias-dev/sql_studio_app/commit/e2141d589c00522c65418091158b5f6218dfc2a3))
* **lib/src/shared/widgets/sql_workspace/sql_editor:** standardize suggestion elements style ([de46b25](https://github.com/dariomatias-dev/sql_studio_app/commit/de46b2580fe95aa793f57df1c330186a917b7cba))
* **lib/src/shared/widgets/sql_workspace/sql_workspace_widget.dart:** add layout customization ([76276d4](https://github.com/dariomatias-dev/sql_studio_app/commit/76276d4ea9abc67272bc9a4774ae3f5c4c5aee58))
* **lib/src/shared/widgets/sql_workspace:** add automatic tab navigation ([8bdffec](https://github.com/dariomatias-dev/sql_studio_app/commit/8bdffec9c556b6c11fd9a189e8a7d49cbe98dc7e))
* **lib/src/shared/widgets/sql_workspace:** add conditional display of maximize icon ([14248b1](https://github.com/dariomatias-dev/sql_studio_app/commit/14248b13e95aeb7e67267b06df00f44daa98e22b))
* **lib/src/shared/widgets/sql_workspace:** add optional panel title display ([529358e](https://github.com/dariomatias-dev/sql_studio_app/commit/529358e30c11b9e892b539d2bf67bb2a19ae5bca))
* **lib/src/shared/widgets/suggestions_settings_layout:** added save button enable/disable logic ([2f080a7](https://github.com/dariomatias-dev/sql_studio_app/commit/2f080a7b06b3415e13f3f295af0b08283b417b0d))
* **lib/src/shared/widgets:** create `Scaffold` component ([357116e](https://github.com/dariomatias-dev/sql_studio_app/commit/357116eeb5e7c852b52bc3d1c8c944b2fe4bd82d))
* **lib/src/shared/widgets:** created `CardWidget` component ([2e4e328](https://github.com/dariomatias-dev/sql_studio_app/commit/2e4e328ec4fd3a606970413db172ec4f7d1191c0))
* **lib/src/shared/widgets:** created `PopupMenuButtonWidget` component ([155324b](https://github.com/dariomatias-dev/sql_studio_app/commit/155324b04c2eed6540a84e49ae0d21571943267d))
* **lib/src/shared/widgets:** created button component ([f7f9d00](https://github.com/dariomatias-dev/sql_studio_app/commit/f7f9d00f51847c60a430f07a2341215950c847c0))
* **lib/src/shared/widgets:** created confirmation dialog component ([76f7add](https://github.com/dariomatias-dev/sql_studio_app/commit/76f7add755424749fcc14e7ce461e6f5901337e9))
* **lib/src/shared/widgets:** created dialog component ([262928c](https://github.com/dariomatias-dev/sql_studio_app/commit/262928ceaccf58c37fb5cd01f92a9d259e095f3b))
* **lib/src/shared/widgets:** created loading button ([db05bf7](https://github.com/dariomatias-dev/sql_studio_app/commit/db05bf7a7927db8b0e2e313ae2367bfc8a19bb59))
* **lib/src/shared/widgets:** created reusable text field component ([9115094](https://github.com/dariomatias-dev/sql_studio_app/commit/9115094c8088792754b3c26bb676c509e06dadfb))
* **lib/src/shared/widgets:** created SQL workspace component ([ab3d3f3](https://github.com/dariomatias-dev/sql_studio_app/commit/ab3d3f3fbb295899bed68f8a59015a0ce6321140))
* **lib/src/shared/widgets:** created suggestions management screen layout component ([e047615](https://github.com/dariomatias-dev/sql_studio_app/commit/e04761517632f3bffc335eb153a0e46514bab748))
* **lib/src/shared:** refactor button component design ([09d6f20](https://github.com/dariomatias-dev/sql_studio_app/commit/09d6f20f7fd180cde5ffdcfb61f6c364e6df7cde))
* **lib/src:** add database name passing to `DatabaseVisualizerScreen` ([821442b](https://github.com/dariomatias-dev/sql_studio_app/commit/821442bdc6ad92c1037484b2be8c1fa64762e4c1))
* **lib/src:** add dynamic command suggestion ([193b0a6](https://github.com/dariomatias-dev/sql_studio_app/commit/193b0a63bea0ead9a8fd00383a6e926b51e74260))
* **lib/src:** add full database drop on removal ([b98c921](https://github.com/dariomatias-dev/sql_studio_app/commit/b98c9215cb46bbde44ecf42b98fc16187d8911c3))
* **lib/src:** added `DatabaseModel` to `DrawerDatabaseListTileWidget` and new `isFavorite` property ([4ce5add](https://github.com/dariomatias-dev/sql_studio_app/commit/4ce5add01697f7e5388726f9e797f9ae95b6ee4f))
* **lib/src:** added `LoadingButtonWidget` to `InputDialogWidget` ([eb4d16f](https://github.com/dariomatias-dev/sql_studio_app/commit/eb4d16fd82550fb27d4c214c7d0abe2faf0cf613))
* **lib/src:** added `orderIndex` property ([55b160e](https://github.com/dariomatias-dev/sql_studio_app/commit/55b160e93f4a6947480787ad40259d96edbbcffa))
* **lib/src:** added `show` method ([4493c90](https://github.com/dariomatias-dev/sql_studio_app/commit/4493c908fe94ca3ca96f60d4dfd3a5f47101c241))
* **lib/src:** added boolean return to `onSubmit` in `InputDialogWidget` ([c243c01](https://github.com/dariomatias-dev/sql_studio_app/commit/c243c018d26d6acbd963ed4b1754f18184799b70))
* **lib/src:** added database model and validation to `CreateDatabaseDialogWidget` ([997f39f](https://github.com/dariomatias-dev/sql_studio_app/commit/997f39f885b96d8f93b3011d7ee842fa5894b45e))
* **lib/src:** added error handling to `DatabaseNotifier` ([573750d](https://github.com/dariomatias-dev/sql_studio_app/commit/573750d4b67685d8256ae42510c93a16457e959b))
* **lib/src:** added feedback when saving suggestions ([caeda0c](https://github.com/dariomatias-dev/sql_studio_app/commit/caeda0c0722534884ae9501ea82a580f53ec761c))
* **lib/src:** added persistence for selected database ([a6dfd14](https://github.com/dariomatias-dev/sql_studio_app/commit/a6dfd149f83933474b4d11349ff69306cfb8609e))
* **lib/src:** added persistence for selected database in `SqlCommandsNotifier` ([4d97ffc](https://github.com/dariomatias-dev/sql_studio_app/commit/4d97ffc7e7142c304abca2eba162740d427c0a2a))
* **lib/src:** added result handling support to `SqlAdvancedSuggestionsNotifier` ([f78e000](https://github.com/dariomatias-dev/sql_studio_app/commit/f78e00036ddbd3b5561cfdb117f368ebf88edf5a))
* **lib/src:** added translations to `SqlExecutionService` ([fdf810f](https://github.com/dariomatias-dev/sql_studio_app/commit/fdf810f6a2d04c3fd84ad1c8a7c3db03a96c4ecd))
* **lib/src:** componentized and expanded default databases variable ([cd8a9a4](https://github.com/dariomatias-dev/sql_studio_app/commit/cd8a9a481435cf57d3dfaf128a9e00cf583948af))
* **lib/src:** configure and add navigation for `WorkspaceLayoutScreen` ([7119bc2](https://github.com/dariomatias-dev/sql_studio_app/commit/7119bc2a86a7a8e415cf34161c1300ddd74cdd55))
* **lib/src:** create `WorkspaceLayoutNotifier` ([6045760](https://github.com/dariomatias-dev/sql_studio_app/commit/6045760e083ab14e6aa8b976775dabb16e0d6cd5))
* **lib/src:** create advanced SQL command suggestions management screen ([b830b15](https://github.com/dariomatias-dev/sql_studio_app/commit/b830b15383c2470c6e3202b857646e9e5d846f5f))
* **lib/src:** create advanced SQL suggestions model and default constant ([2b4886e](https://github.com/dariomatias-dev/sql_studio_app/commit/2b4886ebb6ae78162f2188ce4b1f08db151adc9c))
* **lib/src:** create and implement class for initializing default databases ([fadf0cb](https://github.com/dariomatias-dev/sql_studio_app/commit/fadf0cbc99e11139a5bf0376a36d80f1dbb20cbc))
* **lib/src:** create and implement color class ([21c1a6d](https://github.com/dariomatias-dev/sql_studio_app/commit/21c1a6de30ba25103874bc3b639fcdd76d93d593))
* **lib/src:** create base screen for visualizing database structure ([85dd23d](https://github.com/dariomatias-dev/sql_studio_app/commit/85dd23d3a9efb8b70a986dd588740cc172969d3e))
* **lib/src:** create method to retrieve database structure ([7dca7cc](https://github.com/dariomatias-dev/sql_studio_app/commit/7dca7cc1a56d3cce58ba6d41dd771af134903461))
* **lib/src:** create suggestion elements configuration screen ([a634e03](https://github.com/dariomatias-dev/sql_studio_app/commit/a634e03328371a554e5f1adf3db45d2a12e6cdc5))
* **lib/src:** created `default_sql_suggestions` folder ([09f20d3](https://github.com/dariomatias-dev/sql_studio_app/commit/09f20d36870594d69724393ae1cf50be535a34f4))
* **lib/src:** created `sqlCommands` constant ([9b662c9](https://github.com/dariomatias-dev/sql_studio_app/commit/9b662c9f47cdf88bd033b01937e130d7a2795987))
* **lib/src:** created cancel button component ([7a83587](https://github.com/dariomatias-dev/sql_studio_app/commit/7a835875f68506c65d45ab6d1a25402760d915a3))
* **lib/src:** created controller for `SuggestionsSettingsLayoutWidget` ([70093f0](https://github.com/dariomatias-dev/sql_studio_app/commit/70093f04037ef30d332e5633f17321eace3c32ad))
* **lib/src:** created default database screen ([2eea730](https://github.com/dariomatias-dev/sql_studio_app/commit/2eea730bb804fb8e8ba463c32eca084f3704bf19))
* **lib/src:** created global URLs class ([3bb169c](https://github.com/dariomatias-dev/sql_studio_app/commit/3bb169c1d0b075300f62e6f9cf1b082033a6593d))
* **lib/src:** created not found screen ([046bbfb](https://github.com/dariomatias-dev/sql_studio_app/commit/046bbfbcfc99bd4941f0dde961c597acef29316c))
* **lib/src:** created SQL command configuration screen ([08408a3](https://github.com/dariomatias-dev/sql_studio_app/commit/08408a32368470eb256c86979f27b557ed3dc3ef))
* **lib/src:** created SQL commands notifier ([0c50c79](https://github.com/dariomatias-dev/sql_studio_app/commit/0c50c7976655c9971483379083764848ee906546))
* **lib/src:** created utility for `SnackBar` ([b6de027](https://github.com/dariomatias-dev/sql_studio_app/commit/b6de0279c02d79c8189a3aa504d7d72ee1416cf2))
* **lib/src:** detail "database not selected" failure and fix table column retrieval ([a274247](https://github.com/dariomatias-dev/sql_studio_app/commit/a2742477d546785a8e1b96c369d405f7b891ea16))
* **lib/src:** implemented new global navigation structure ([cf5d100](https://github.com/dariomatias-dev/sql_studio_app/commit/cf5d100435650e877cb9e43f8f45073da72b532a))
* **lib/src:** implemented new navigation system ([a61d488](https://github.com/dariomatias-dev/sql_studio_app/commit/a61d4883f976a0adf337c97e9b8f85458e6d7e9f))
* **lib/src:** implemented new navigation system ([6cd1c75](https://github.com/dariomatias-dev/sql_studio_app/commit/6cd1c758e0d21c302ad40e0ea65fc60d0b706826))
* **lib/src:** improved `WorkspaceLayout` elements ([2e72f75](https://github.com/dariomatias-dev/sql_studio_app/commit/2e72f75500e64318a8c672440a132b0ecb395d03))
* **lib/src:** improved suggestion order saving flow ([4aed383](https://github.com/dariomatias-dev/sql_studio_app/commit/4aed383506b1834406200f06025b15c229d05f62))
* **lib/src:** minor fixes ([5a0ffb2](https://github.com/dariomatias-dev/sql_studio_app/commit/5a0ffb20d15b3eaa711dce44a6cbbf6b3c1ac18c))
* **lib/src:** move suggestion state management keys to `SharedPreferencesKeys` ([6a2aabe](https://github.com/dariomatias-dev/sql_studio_app/commit/6a2aabe31171e0408513045062383c6797abb679))
* **lib/src:** rename `DefaultDatabaseInitializer` class ([738b1a2](https://github.com/dariomatias-dev/sql_studio_app/commit/738b1a22bcdcfe4d51158d90c04fd3feba881b1d))
* **lib/src:** rename basic command suggestion settings screen ([6087022](https://github.com/dariomatias-dev/sql_studio_app/commit/60870227f9a5f10f75cc8ef93dfcfd4f8e5708d7))
* **lib/src:** renamed `DefaultDatabaseScreen` to `DatabaseScreen` ([e0f840f](https://github.com/dariomatias-dev/sql_studio_app/commit/e0f840fb4159c1f01ff2a9e8cc5bd89ceef64332))
* **lib/src:** renamed constant `sqlAdvancedSuggestionsDefault` ([6d11630](https://github.com/dariomatias-dev/sql_studio_app/commit/6d116301e2adc033baaa95685bd4647430b499c8))
* **lib/src:** renamed constant `sqlCommands` ([ef94908](https://github.com/dariomatias-dev/sql_studio_app/commit/ef9490870f893cca6bc5f8e860d6eaf6c49296d2))
* **lib/src:** reposition `DefaultDatabaseInitializer` ([6fed7e8](https://github.com/dariomatias-dev/sql_studio_app/commit/6fed7e82309ce2061fd0fa6b210bdbb52a18b3e4))
* **lib/src:** repositioned `DialogWidget` ([de5e474](https://github.com/dariomatias-dev/sql_studio_app/commit/de5e474771c94b2f8fc43f8e05b0835a097b86ec))
* **lib/src:** repositioned `SqlAdvancedSuggestionModel` ([58a32d6](https://github.com/dariomatias-dev/sql_studio_app/commit/58a32d67fc2492835f7140a468acfdc231ec2573))
* **lib/src:** repositioned and renamed `TableInfo` and `ColumnInfo` models ([3571a53](https://github.com/dariomatias-dev/sql_studio_app/commit/3571a539a4fdf05173403944b00e711cc3570e90))
* **lib/src:** simplified button components and moved to dedicated folder ([0c5163e](https://github.com/dariomatias-dev/sql_studio_app/commit/0c5163e4e6a356f7c87739da34c84f46dd8fc1cc))
* **lib/src:** simplified interactions ([3402523](https://github.com/dariomatias-dev/sql_studio_app/commit/34025230f25a915a9db2d7887f9193e6fb263e27))
* **lib/src:** simplified method names in `SqlBasicSuggestionsNotifier` ([239f7a8](https://github.com/dariomatias-dev/sql_studio_app/commit/239f7a8c2eca95b4aa7d6b24b1aa0ec30006da6a))
* **lib/src:** standardized `IconButton` property hierarchy ([aa4cb84](https://github.com/dariomatias-dev/sql_studio_app/commit/aa4cb84aa8e1a358496ee010dc1e7bdb3274ae77))
* **lib/src:** updated query results and fixes ([3a2d74c](https://github.com/dariomatias-dev/sql_studio_app/commit/3a2d74c0ba70ef4a9fddf74ec447da2e4b9586f2))
* **lib:** add internationalization support to `DatabaseCardWidget` component ([f82fffd](https://github.com/dariomatias-dev/sql_studio_app/commit/f82fffd7a03b86689d1e5f24ccc8bbca52d4aa31))
* **lib:** add internationalization support to `DatabaseDeleteDialogWidget` and translations for `Cancel` ([7a3c826](https://github.com/dariomatias-dev/sql_studio_app/commit/7a3c826e0174d3666e349a14097026b5b50ab473))
* **lib:** add internationalization support to `DrawerDatabaseCardWidget` component ([e47663c](https://github.com/dariomatias-dev/sql_studio_app/commit/e47663c4ff5a0ff6bc4dd6d8ceed683a99e9764d))
* **lib:** add internationalization support to `DrawerWidget` component ([0959443](https://github.com/dariomatias-dev/sql_studio_app/commit/095944350815d864ff335c86f6ae45412cbf209d))
* **lib:** add internationalization support to `RemoveSqlBasicSuggestionDialogWidget` ([cd27dbc](https://github.com/dariomatias-dev/sql_studio_app/commit/cd27dbcb38cf8f5e480a81c7200f473f62e68a1e))
* **lib:** add internationalization support to `SqlWorkspaceWidget` component ([5d2acc2](https://github.com/dariomatias-dev/sql_studio_app/commit/5d2acc2b6be29ebb1139abcc434c72dff3fa055c))
* **lib:** add internationalization support to bottom navigation bar ([1d75b1a](https://github.com/dariomatias-dev/sql_studio_app/commit/1d75b1a26a14bc8894a2d895cf753111efa5d16e))
* **lib:** add internationalization support to settings screen ([586620d](https://github.com/dariomatias-dev/sql_studio_app/commit/586620d15352e4cbbd034dd6eaf4a55f33a87305))
* **lib:** add internationalization to `CreateSqlBasicSuggestionDialogWidget` ([dfde286](https://github.com/dariomatias-dev/sql_studio_app/commit/dfde286f43589f3a2626181d8a8236f9abc92a83))
* **lib:** add internationalization to `SqlBasicSuggestionsSettingsScreen` and related components ([b1ff9a3](https://github.com/dariomatias-dev/sql_studio_app/commit/b1ff9a343d00461e830dc519656dbcfd7289c4ed))
* **lib:** add internationalization to `WorkspaceLayoutScreen` ([1b59f27](https://github.com/dariomatias-dev/sql_studio_app/commit/1b59f27318241c008c97579d190bb76ba29907b8))
* **lib:** add internationalization to default databases mapping ([fd1b343](https://github.com/dariomatias-dev/sql_studio_app/commit/fd1b343d3cca2667f9b781ccf001221890f2f25d))
* **lib:** add internationalization to SQL suggestions settings screen ([f163cd3](https://github.com/dariomatias-dev/sql_studio_app/commit/f163cd3fcb66c6a8fd6899dfeb86c751a9ea2678))
* **lib:** added contact option to settings screen ([f7d2ec1](https://github.com/dariomatias-dev/sql_studio_app/commit/f7d2ec183d730089c07d0fad3f0466034bc0864f))
* **lib:** added internationalization support to `CreateSqlAdvancedSuggestionDialogWidget` ([6b7c7fa](https://github.com/dariomatias-dev/sql_studio_app/commit/6b7c7fa787a0e7aa2b58735e06ab469167383b54))
* **lib:** added internationalization support to `DatabaseVisualizerScreen` ([3c520ef](https://github.com/dariomatias-dev/sql_studio_app/commit/3c520ef84ae675724ff52df822b74bce66a06931))
* **lib:** added internationalization support to `DeleteSqlAdvancedSuggestionDialogWidget` ([9a8a42b](https://github.com/dariomatias-dev/sql_studio_app/commit/9a8a42b60e6b69f99c99658bb3e2399feecd43fa))
* **lib:** added internationalization support to `InputDialogWidget` and expanded translation usage ([e332193](https://github.com/dariomatias-dev/sql_studio_app/commit/e332193ab6034532256b74f2ef34a7b258463907))
* **lib:** added internationalization support to `NotFoundScreen` ([beef431](https://github.com/dariomatias-dev/sql_studio_app/commit/beef43184d6f515aa09cadd5c99a87b7f4119ee8))
* **lib:** added internationalization support to `ResetSqlAdvancedSuggestionsDialogWidget` ([7aa7086](https://github.com/dariomatias-dev/sql_studio_app/commit/7aa7086fa503cb0c4caf2bc477ec7619bb287679))
* **lib:** added internationalization support to `ResetSqlBasicSuggestionsDialogWidget` ([4066b1f](https://github.com/dariomatias-dev/sql_studio_app/commit/4066b1f2e0544e572c3a0a981874d9fc9eb62f23))
* **lib:** added internationalization support to `SqlAdvancedSuggestionFormDialogWidget` ([b6aa6eb](https://github.com/dariomatias-dev/sql_studio_app/commit/b6aa6eb8861e74b2b51cd710ab24fa1afa58e5cc))
* **lib:** added internationalization support to `SuggestionsSettingsLayoutController` ([6029306](https://github.com/dariomatias-dev/sql_studio_app/commit/60293066991d580484f0cc39fde9c80b62c26923))
* **lib:** added internationalization support to `ThemeSwitcherButtonWidget` ([771813d](https://github.com/dariomatias-dev/sql_studio_app/commit/771813d6a0399b6d20d04cc9cde172f3242c01c7))
* **lib:** added internationalization support to `UpdateSqlAdvancedSuggestionDialogWidget` ([6c7f5bb](https://github.com/dariomatias-dev/sql_studio_app/commit/6c7f5bb64a1988a484120309aa68705618b56934))
* **lib:** added internationalization support to notifiers and services ([324becc](https://github.com/dariomatias-dev/sql_studio_app/commit/324becc7b2e488717d99e3958c4e6ea507f87508))
* **lib:** added internationalization to `CreateDatabaseDialogWidget` and language selection feedback to `LanguageSelectorSheetOptionWidget` ([fd829de](https://github.com/dariomatias-dev/sql_studio_app/commit/fd829debdb8e663b9e9aaecdfcfe43dbd1d921ef))
* **lib:** added internationalization to SQL copy texts ([647f91b](https://github.com/dariomatias-dev/sql_studio_app/commit/647f91b2c91af7af5115b32095d0bf865fee4556))
* **lib:** added internationalization to SQL sharing messages ([707f8ec](https://github.com/dariomatias-dev/sql_studio_app/commit/707f8ec3761b1b0f924b676fa3d28f64a1943532))
* **lib:** added internationalization to the `setLayout` error message in `WorkspaceLayoutNotifier` ([2718e35](https://github.com/dariomatias-dev/sql_studio_app/commit/2718e35172444f3b9bcb75b71d9a60b86b671730))
* **lib:** added internationalization to the new editor options ([26632c0](https://github.com/dariomatias-dev/sql_studio_app/commit/26632c02a2d10bce9a3efb3eafd5703d41cc9b5b))
* **lib:** added SQL copy action ([14a9264](https://github.com/dariomatias-dev/sql_studio_app/commit/14a92648cc12247904da62744bbe6c1d2a735532))
* **lib:** added translation for `loading` ([87ec79e](https://github.com/dariomatias-dev/sql_studio_app/commit/87ec79e91f7a78c58e77a65ed2a55a8a818a749d))
* **lib:** created initial structure ([3c020a8](https://github.com/dariomatias-dev/sql_studio_app/commit/3c020a87053b8a056a209716fa6793549057f945))
* **lib:** created notifier to handle reactivity of user-written SQL ([d074a59](https://github.com/dariomatias-dev/sql_studio_app/commit/d074a594361698c81972da2cab0f1064a459af72))
* **lib:** created notifier to switch main screen ([3403c53](https://github.com/dariomatias-dev/sql_studio_app/commit/3403c531d7967f61e4cb3e7c37b17cae123ce6ab))
* **lib:** expand internationalization ([03133a7](https://github.com/dariomatias-dev/sql_studio_app/commit/03133a741ab78ad53be6a6e6124b0c3ed7cd11b2))
* **lib:** expand internationalization ([0e8c89b](https://github.com/dariomatias-dev/sql_studio_app/commit/0e8c89bb8f2f83693dad3845c021e5bf73c907c6))
* **lib:** implement `WorkspaceLayoutNotifier` ([df983a6](https://github.com/dariomatias-dev/sql_studio_app/commit/df983a60b0ad7dd4698883a5b020908c9d817405))
* **lib:** implement language switching ([22ddfee](https://github.com/dariomatias-dev/sql_studio_app/commit/22ddfee162728e0de1117499c07dec028dbaebaf))
* **lib:** implemented `AppVersionNotifier` ([d231cf9](https://github.com/dariomatias-dev/sql_studio_app/commit/d231cf903573fcbbef0ac20496f98f86aac946d7))
* **lib:** implemented `SqlBasicSuggestionsNotifier` ([8648bfb](https://github.com/dariomatias-dev/sql_studio_app/commit/8648bfb35f2719b4777b84276cb23c66daa83162))
* **lib:** provided `DatabaseNotifier` in the widget tree and added data loading ([936cf3d](https://github.com/dariomatias-dev/sql_studio_app/commit/936cf3d9735718927becd7fcee1c582a8d79de2b))
* **lib:** refactored navigation notifier ([ff00f22](https://github.com/dariomatias-dev/sql_studio_app/commit/ff00f2202015614d7fbdece677b7c30eb6a92436))
* **lib:** rename workspace configuration screen ([7e35244](https://github.com/dariomatias-dev/sql_studio_app/commit/7e3524408d7603293c11a44dd61f2f64c6a682c5))
* **lib:** renamed `SqlCommandsNotifier` ([f371d4f](https://github.com/dariomatias-dev/sql_studio_app/commit/f371d4f69dc10bf20112ff16fb73cffa22a4e89e))
* **lib:** renamed language controller ([860f347](https://github.com/dariomatias-dev/sql_studio_app/commit/860f347cac7d9f0de60bdf3791587ffd8599da41))
* **lib:** repositioned `SharedPreferencesService` loading and app language initialization ([a908234](https://github.com/dariomatias-dev/sql_studio_app/commit/a90823409d2455a4ccd76b5b55377745fc29f552))
* **lib:** simplified `SqlEditorWidget` ([1ce7e6b](https://github.com/dariomatias-dev/sql_studio_app/commit/1ce7e6b2ec45734b4bf485469bce0cc645fb1e67))
* remove use of `SnackBar` ([7684dd0](https://github.com/dariomatias-dev/sql_studio_app/commit/7684dd0fa31da9fc7d9a3c6eb2b451c54807f08b))
* replace code field package and fix keyboard opening bug ([543e659](https://github.com/dariomatias-dev/sql_studio_app/commit/543e6594c363bbad6c03b7f520363dd7378b1e52))
* **screenshots:** generate localized screenshots for each README ([3e9de6f](https://github.com/dariomatias-dev/sql_studio_app/commit/3e9de6fb3c1a2da6299372d436f1c70ff4413eb9))
* **scripts:** add automated application screenshot capture ([3008e82](https://github.com/dariomatias-dev/sql_studio_app/commit/3008e8267a93619631c1ac5d076d22b38cf2e60a))
* set app icon and name ([95b2990](https://github.com/dariomatias-dev/sql_studio_app/commit/95b29907bf451efdd7f9eb594e6c9c4f4937dc2a))
* **settings:** add light, dark, and system theme support ([bd7f265](https://github.com/dariomatias-dev/sql_studio_app/commit/bd7f2653bdd025331c67a518cb12bcfb6381219e))
* **sql-editor:** add download and load last query actions ([6da1365](https://github.com/dariomatias-dev/sql_studio_app/commit/6da136548d245c0e07683bebbbbd200b94c01171))
* **theme:** add spacing and duration tokens ([71f9495](https://github.com/dariomatias-dev/sql_studio_app/commit/71f949537d9ba2b01716b65baa353b4b0776618c))
* **ui:** add standardized state widgets ([67f1444](https://github.com/dariomatias-dev/sql_studio_app/commit/67f14445693a33e2bcfe866314b4cd277019ee3f))
* **ui:** add transitions and micro-animations ([23e398e](https://github.com/dariomatias-dev/sql_studio_app/commit/23e398e3522978d1c55f626ee0fba6979edb0ded))
* **ui:** apply black-and-white minimal redesign to suggestion settings ([8c79316](https://github.com/dariomatias-dev/sql_studio_app/commit/8c793165cfe4ab1a38f7f96324060c8fc82076b0))
* update app icon ([abc9a2c](https://github.com/dariomatias-dev/sql_studio_app/commit/abc9a2cb868fd7a8a0330d42d18a90247876f2ba))


### Bug Fixes

* **android:** fall back to the debug signing key when key.properties is absent ([24a2f44](https://github.com/dariomatias-dev/sql_studio_app/commit/24a2f44cf045de5146d7ac37c84e3b061668156a))
* **app-icon:** improve adaptive icon rendering ([0bb3cdd](https://github.com/dariomatias-dev/sql_studio_app/commit/0bb3cdd658b46abeb25d41b162bf2eddc358dede))
* close stale database handles and improve SQL safety ([262f016](https://github.com/dariomatias-dev/sql_studio_app/commit/262f0164c821977c7e372929a88942b8898056b4))
* complete repaint checks and detect SQL types after comments ([8a9256c](https://github.com/dariomatias-dev/sql_studio_app/commit/8a9256caef4a3d4757a3bfcef0b1a9e28631f520))
* **create-database-dialog:** validate the original database name ([59fb58c](https://github.com/dariomatias-dev/sql_studio_app/commit/59fb58cd426c07ce806ff5529493847bcc70b156))
* **database_visualizer:** stop caching usecase in late field ([28f27a7](https://github.com/dariomatias-dev/sql_studio_app/commit/28f27a7ff26eb869b6b348f1e23357ce532d8ba8))
* **database-card:** improve table name preview ([3c7faca](https://github.com/dariomatias-dev/sql_studio_app/commit/3c7facab95b2cfa118679271e9b8a2f87b30c339))
* **database-visualizer:** adopt the `Result`/`Failure` repository contract ([cc3a27e](https://github.com/dariomatias-dev/sql_studio_app/commit/cc3a27e211f0899ce7aeee33dacbe2d776c5a064))
* **database-visualizer:** auto-dispose the view model provider ([6c3d02b](https://github.com/dariomatias-dev/sql_studio_app/commit/6c3d02bfe7559eea0ed3da016409b3135bf36ed1))
* **database-visualizer:** preserve table name casing ([03fe0ab](https://github.com/dariomatias-dev/sql_studio_app/commit/03fe0abcd63f7b2daf77ab50d61f66269b56aa7d))
* **database-visualizer:** recover from load errors ([f885551](https://github.com/dariomatias-dev/sql_studio_app/commit/f885551471a46d747b995245fdcf240a18d42088))
* **database:** cache initialization future to prevent duplicate connections ([d5c42b3](https://github.com/dariomatias-dev/sql_studio_app/commit/d5c42b3332830e0d55de18610f5b64bb171a6bc1))
* **database:** move database filtering into a view model ([871b0a9](https://github.com/dariomatias-dev/sql_studio_app/commit/871b0a9ced1bb459913f6c155bb9ddc52121bca2))
* **database:** quote table identifier in `dropTable` ([35eb0dd](https://github.com/dariomatias-dev/sql_studio_app/commit/35eb0dd1e6e5c94301b380f73240e95400302464))
* **default-database:** preserve user edits across a seed version bump ([7cf5b8d](https://github.com/dariomatias-dev/sql_studio_app/commit/7cf5b8dd9fd2e5d22f70e9a2c97adbe04342cd97))
* **default-database:** reuse the statement splitter ([4dd57ca](https://github.com/dariomatias-dev/sql_studio_app/commit/4dd57ca41f58d3b251c4ad921c75c29e188a4dd0))
* **default-database:** stop swallowing seed failures ([8c5f1a5](https://github.com/dariomatias-dev/sql_studio_app/commit/8c5f1a5b06aec2e7a83c31ff6ec5b6d4db0b88b1))
* **l10n:** localize the dialog action label ([f1d6b3d](https://github.com/dariomatias-dev/sql_studio_app/commit/f1d6b3d4382a0461fecc4962701e8dc29aeadea6))
* **l10n:** rename suggestion settings labels ([5bf93eb](https://github.com/dariomatias-dev/sql_studio_app/commit/5bf93ebb20aa209fe131d19a321332998e3ff62d))
* **lib/l10n:** fixed translations ([e798cbd](https://github.com/dariomatias-dev/sql_studio_app/commit/e798cbdaf57d0187435b4b388276ac9fc326e256))
* **lib/src/notifiers/sql_suggestions_notifiers/sql_advanced_suggestions_notifier.dart:** remove default value from `SqlAdvancedSuggestionsNotifier` ([1b5f271](https://github.com/dariomatias-dev/sql_studio_app/commit/1b5f2710c539fe1862209b12aedf6632e415e7ae))
* **lib/src/screens/main/widgets/drawer/create_database_dialog_widget.dart:** refactor database creation flow ([305f845](https://github.com/dariomatias-dev/sql_studio_app/commit/305f845e9a6e7ef6c3ef61c987253a8a2cdae189))
* **lib/src/shared/widgets/sql_workspace/console/console_widget.dart:** fixed loading element ([a3037ad](https://github.com/dariomatias-dev/sql_studio_app/commit/a3037ad14ee176fd6c961f673e65e08c21529593))
* **lib/src:** corrected screens folder name ([e6845b5](https://github.com/dariomatias-dev/sql_studio_app/commit/e6845b5e174f8ef9ebcbbd97856b43d2cd2e72d5))
* **logging:** stop logging SQL statements and database names ([e8068ea](https://github.com/dariomatias-dev/sql_studio_app/commit/e8068eaa829e681ebaf73314a8f00b3ccdd6d034))
* **navigation:** keep bottom navigation labels within the selection pill ([cf62b18](https://github.com/dariomatias-dev/sql_studio_app/commit/cf62b18e9426f891bbfb873e44caf09f0b19557e))
* **navigation:** keep the editor unfocused after overlays close ([defdfcb](https://github.com/dariomatias-dev/sql_studio_app/commit/defdfcbab85fda4e2803ffc00199e12c7efafe67))
* **navigation:** remove duplicated bottom padding ([4a69972](https://github.com/dariomatias-dev/sql_studio_app/commit/4a69972b7c7625a3cb6ab8636d4d9f148e34f1ee))
* **providers:** remove duplicate SQL execution service provider ([d8aa383](https://github.com/dariomatias-dev/sql_studio_app/commit/d8aa383db3538038d93a057011596401b16bd992))
* remove duplicate favorite toggle logic and incorrect error argument ([4f1cc48](https://github.com/dariomatias-dev/sql_studio_app/commit/4f1cc4818848aecd8cecddc59d95ae86e43584bc))
* reuse shared database connections for seed and reset ([eb5ddf4](https://github.com/dariomatias-dev/sql_studio_app/commit/eb5ddf42f9f9f823ac9a9c874209582bc9030cea))
* **root-drawer:** improve state handling and dialog behavior ([89c6758](https://github.com/dariomatias-dev/sql_studio_app/commit/89c6758bda60f0bbf809e97e39c07e59e65d4054))
* scope `DatabaseManager` through dependency injection ([262755c](https://github.com/dariomatias-dev/sql_studio_app/commit/262755c8b0ce86595e80fc7c2033bb66cb9d5778))
* **settings:** distinguish external links from internal navigation ([345e37a](https://github.com/dariomatias-dev/sql_studio_app/commit/345e37a58bde40344c5ae7eda9115289647a5d2e))
* **shared-widgets:** prevent stuck loading state and dispose controllers ([5a5d76b](https://github.com/dariomatias-dev/sql_studio_app/commit/5a5d76b2f729e368b6154a24f771a0cd80ba3c4e))
* **sql-editor:** dispose the code controller ([d0e28af](https://github.com/dariomatias-dev/sql_studio_app/commit/d0e28af37a9752c9a2f1f390795f5d3303af6357))
* **sql-execution:** close cached connections on dispose ([b668377](https://github.com/dariomatias-dev/sql_studio_app/commit/b6683779fc062778d160aeef0dfc7447c875ecd0))
* **sql-execution:** ignore semicolons inside SQL comments ([bc4f5a2](https://github.com/dariomatias-dev/sql_studio_app/commit/bc4f5a2ae052d73cdc14e1eefaeb59c3fe485e7c))
* **sql-execution:** safely split statements and reuse connections ([1b2d6f0](https://github.com/dariomatias-dev/sql_studio_app/commit/1b2d6f0934e01073b1b3b90e029117c9a518b83c))
* **sql-suggestions:** adopt the `Result`/`Failure` repository contract ([ed7daef](https://github.com/dariomatias-dev/sql_studio_app/commit/ed7daef6f93d7f7ad97ae3c455a462ca9c5c9b90))
* **sql-suggestions:** seed default advanced suggestions ([09c7f9d](https://github.com/dariomatias-dev/sql_studio_app/commit/09c7f9dd6df515813ec6d20557f5def3f7129807))
* **suggestions-settings:** reset change baseline after updates ([dcf07a6](https://github.com/dariomatias-dev/sql_studio_app/commit/dcf07a6638c9ac9d12d26683ef2f5fe37639fdbd))
* **theme:** replace default purple with the app color palette ([4d605b1](https://github.com/dariomatias-dev/sql_studio_app/commit/4d605b174a782207d99e397ec50990e51647b527))
* **workspace-layout:** remove rounded clipping from the workspace ([c006940](https://github.com/dariomatias-dev/sql_studio_app/commit/c0069406d77262e130dd1771c20304a0cb32688e))
* **workspace:** improve floating navigation bar behavior ([1c6b2cd](https://github.com/dariomatias-dev/sql_studio_app/commit/1c6b2cdf42c00e0d5e29000e4042c205230a640e))


### Performance Improvements

* **console:** stop building every result row eagerly ([378c207](https://github.com/dariomatias-dev/sql_studio_app/commit/378c207163c432be2ad35815ad80e08206d2fb60))
* run per-table PRAGMA queries concurrently ([9168f52](https://github.com/dariomatias-dev/sql_studio_app/commit/9168f525ddba49997f0530c51f97b311e538b511))

## [0.3.0] - 2026-07-31

### Added
- Light, dark, and system theme support.
- Search filter on the databases list.
- Empty states for query execution in the console.
- Navigate-to-table action from the database visualizer's schema diagram.
- Toast confirmation for database actions.
- Localized screenshots generated for each README.

### Changed
- Migrated `AppColors` to a `ThemeExtension`.
- `DatabaseManager` injected through Riverpod dependency injection.
- Per-table `PRAGMA` queries now run concurrently.
- Upgraded `flutter_riverpod` to v3, `go_router`, `package_info_plus`, and `share_plus`.
- Expanded test coverage across database, screens, navigation, and SQL workspace.

### Fixed
- Complete repaint checks and SQL type detection after comments.
- Reuse shared database connections for seed and reset instead of opening new ones.
- Closed stale database handles and improved SQL statement-splitting safety.
- Adopted the `Result`/`Failure` repository contract in SQL suggestions and the database visualizer.
- Removed duplicate favorite toggle logic, SQL execution service provider, and dead code.
- Auto-dispose the database visualizer view model provider and recover from load errors.
- Prevented stuck loading state and undisposed controllers in shared widgets.
- Reset the suggestions-settings change baseline after updates.
- Improved root drawer state handling and dialog behavior.

## [0.2.0] - 2026-07-26

### Added
- About screen with an app info card and a custom third-party licenses viewer.
- SQL editor download/export and load-last-query actions, plus copy schema/seed to clipboard.
- Database visualizer relation tracing and automatic diagram fit-to-viewport on load.
- Transitions and micro-animations across screens and components.
- English, Portuguese (Brazil), and Spanish README, CONTRIBUTING.md, and a GitHub Actions CI workflow.
- Automated screenshot capture script for the README, Play Store listing, and official website.
- Widget and unit test coverage across repositories, view models, use cases, and shared components.

### Changed
- Migrated app state management from Provider to Riverpod.
- Restructured the codebase into a feature-first architecture with core/features/shared layers.
- Redesigned the app UI with a centralized black-and-white minimal visual identity: unified colors, shadows, radii, and screen backgrounds.
- Redesigned the splash screen, switch component, popup menu headers, and suggestion FAB/button.
- Standardized toast notifications and loading/error/empty state widgets across the app.
- Simplified dialog presentation and separated query/database actions in the SQL editor.
- Adopted `very_good_analysis` lint rules.

### Fixed
- Adaptive app icon rendering.
- Editor losing focus incorrectly after overlays close.
- Bottom navigation label and padding issues.
- Floating navigation bar and workspace clipping behavior.
- Default color palette leaking through instead of the app theme.
- Database visualizer caching and table name casing/preview issues.
- External vs. internal link handling in Settings.
- SQL suggestion labels and default advanced suggestion seeding.

## [0.1.1] - 2025-12-03

### Added
- Advanced SQL suggestions (management screen and add/remove/reset dialogs).
- Full internationalization (English, Spanish, Portuguese) across screens, dialogs, and notifiers.
- Language switching support and a language selector.
- Contact option and a global URLs class in Settings.
- `DatabaseSuccess` result type and result handling in `SqlExecutionService`.
- Versioned schema/seed execution in `DefaultDatabaseInitializer`.
- Option to view database structure from the database card.

### Changed
- Refactored SQL execution result handling in the console widget.
- Repositioned `SharedPreferencesService` loading and app language initialization.
- Renamed and repositioned `TableInfo`/`ColumnInfo` models.

### Fixed
- Various translation issues across the app.

## [0.1.0] - 2025-10-26

### Added
- Initial application structure: navigation, drawer, and routing.
- Database creation, listing, favoriting, and deletion.
- SQL editor and console workspace.
- Basic SQL suggestions.
- Settings screen and reusable dialog/button components.
