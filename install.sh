# I'm going to assume that if you're using this script, you're installing offline. Otherwise, you should just be following the README instructions.
function usage()
{
	echo "Install nengo and it's requirements"
	echo ""
	echo "-h --help"
	echo "-f force reinstall"
	echo ""
}

# All installation will be done in the current directory of the script, unless an argument is passed
if [ -z "$1" ]; then
	# taken from https://stackoverflow.com/questions/59895/can-a-bash-script-tell-what-directory-its-stored-in
	dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
else
	dir="$1"
fi

# If nengo is not installed, install Anaconda depending on version so that
# the dependencies can be installed. This should be able to proceed without 
# replacing the python distribution?
result="$(python -c 'import nengo')"
if[$? -ne 0 || force_install -eq True]; then
	if["$(uname -m)" == "x86_64"]; then
		arch="64_bit"
	else
		arch="32_bit"
	fi
	result="$(python -V)"
	# if python is installed, then just install miniconda and requirements
	# so that the user's install isn't over-written
	if[$? -ne 0]; then
		dist="Miniconda"
	else
		dist="Anaconda"
	fi

	if [ "$(uname)" == "Darwin" ]; then
		# Do something under Mac OS X platform
	elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
		# Do something under Linux platform
	elif [ "$(expr substr $(uname -s) 1 10)" == "MINGW32_NT" ]; then
		echo "This is not the script for running in Windows. Use the batch file"
	fi

	if[dist -eq "Miniconda"]; then
		# TODO: check which requirements aren't met and install them
	fi
fi


# Install Nengo
# TODO: Is this the best way?
python ./nengo/setup.py develop