var _ = require('underscore');
var fs = require('fs');
var gaze = require('gaze');

var compile = function() {
	var commands = {
		include: function(file) {

			// If the paht doesnt have a .p8 extension, add it
			if (file.substring(file.length-3, file.length) !== '.p8') {
				file += '.p8';
			}

			return fs.readFileSync(file);
		}
	};

	var data = fs.readFileSync('./main.p8', 'utf8');
	var regex = new RegExp(/\-\-\>\>(.*)/g);
	// var regex = new RegExp(/\-\-\>\>(.*)\r?\n/g); // Include new line

	// Iterate through all ocurances of '-->>'
	var search = data.replace(regex, function(match, text, index) {

		// Split the matched text by spaces
		var input = text.trim().split(' ');

		// The first part of the string should be a command
		var command = input[0];

		// The rest are arguments for the command
		var args = input.splice(1, input.length);

		// If the command exists
		if (commands[command]) {

			// Apply the argument array as function arguments and call it
			return commands[command].apply(this, args);
		}
	});

	fs.writeFileSync('compiled.p8', search);
}

gaze(['**/*.p8', '!compiled.p8'], function() {
	this.on('changed', function(path) {
		console.log(path, 'was changed');
		compile();
	});
});