// eval: Code Review Report Generator
// Vanderbilt University School of Engineering
// Team Members: Jason Brito, Tony Lin, Lawrence Kwok, Nick Michuda
// Sponsor: Dave Lane of Inventiv

// perform code review with phplint Node wrapper
var phplint = require("phplint").lint;
const { exec } = require('child_process');

// get path to directory from command line
directory = process.argv.slice(2)[0];

phplint(directory, (err, stdout, stderr) => {

	// write errors to command line
	if (err) {
		exec(err.cmd, (err, stdout, stderr) => {
			console.log(stdout, stderr);
		});
	}
	else { console.log('no syntax errors detected') }

	// log output and error to stdout and stderr if available
	if (stdout) console.log(stdout);
	if (stderr) console.log(stderr);
});
