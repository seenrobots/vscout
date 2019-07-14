import 'package:args/command_runner.dart';
import 'package:vscout_cli/vscout_cli.dart';
class TeamEntryCommand extends Command {
  @override
  String get name => 'team-entry';

  @override
  String get description => 'Add team entry to database';

  var databaseHandler;
  
  // @override
  // String get usageFooter => 'This is usage';

   @override
  String get usage => ("$description\n\n" + 
"""Usage: vscout add team-entry [team-id]
-h, --help            Print this usage information.
    --[no-]verbose

EG: vscout add team-entry 2381

Run "vscout help" to see global options.""");

  TeamEntryCommand(database) {
    argParser..addFlag('verbose', defaultsTo: false);
    this.databaseHandler = database;
  }
  @override
  run() async {
    // TODO: Replace with actual command.
    String team = argResults.rest[0];
    var result = await databaseHandler.addTeamEntry(team);
    if (argResults['verbose'] == true) {
      print(result);
    }
  }
}
