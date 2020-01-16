var phplint = require("phplint").lint;
const { exec } = require('child_process');

phplint(["./*.php"], (err, stdout, stderr) => {
	if (err) { exec(err.cmd, (err, stdout, stderr) => { console.log(stdout, stderr); }); }
	else { console.log('no syntax errors detected') }
	if (stdout) console.log(stdout);
	if (stderr) console.log(stderr);
});
