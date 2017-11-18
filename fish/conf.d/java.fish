# Wrap jjs to make keyboard navigation work properly
alias jjs='rlwrap /Library/Java/JavaVirtualMachines/jdk1.8.0.jdk/Contents/Home/bin/jjs'

function jls
	echo "Use ´j6, j7, j8 and j9´ to conventiently switch between Java versions."
	echo "For a specific version use ´ju <version>´ where available versions are listed below:"
	/usr/libexec/java_home -V 2>&1 | grep -E "\d.\d.\d" | cut -d , -f 1 | colrm 1 4 | grep -v Home
end

function ju
  # remove from path
  if test -n "$JAVA_HOME"
    set PATH (echo $PATH | string replace --all "$JAVA_HOME/bin" "REMOVE__" | string split ' ' | grep -v 'REMOVE__')
  end
  set -gx JAVA_HOME (/usr/libexec/java_home -v $argv[1])
	set PATH "$JAVA_HOME/bin" $PATH
  if test (count $argv) -eq 1
	  java -version
  end
end

# Add aliases for changing java runtime
alias j7='ju 1.7'
alias j8='ju 1.8'
alias j9='ju 9'

j8 quiet
