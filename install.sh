function usage()
{
	echo "Install nengo and it's requirements"
	echo ""
	echo "-h --help"
	echo "-o offline install"
	echo "-f force reinstall"
	echo ""
}

# All installation will be done in the current directory of the script, unless an argument is passed
if [ -z "$1" ]; then
	# taken from https://stackoverflow.com/questions/59895/can-a-bash-script-tell-what-directory-its-stored-in
	dir = "$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
else
	dir = "$1"
fi

# If nengo is not installed, install Anaconda depending on version so that
# the dependencies can be installed. This should be able to proceed without 
# replacing the python distribution?
result = "$(python -c 'import nengo')"
if[$? -ne 0 || force_install -eq True]; then
	if["$(uname -m)" == "x86_64"]; then
		arch = "64_bit"
	else
		arch = "32_bit"
	fi

	if [ "$(uname)" == "Darwin" ]; then
		# Do something under Mac OS X platform
	elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
		# Do something under Linux platform
	elif [ "$(expr substr $(uname -s) 1 10)" == "MINGW32_NT" ]; then
		echo "This is not the script for running in Windows. Use the batch file"
	fi
fi

# if the user checked the offline install option


# Install Nengo
# TODO: Is this the best way?
python ./nengo/setup.py develop