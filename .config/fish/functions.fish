function ..    ; cd .. ; end
function ...   ; cd ../.. ; end
function ....  ; cd ../../.. ; end
function ..... ; cd ../../../.. ; end

function backup
	set format (basename (pwd))-(date +%Y-%m-%d.%H:%M:%S)
	tar -zcvf ../$format.tar.gz ../(basename (pwd))/ 1>/dev/null 2>&1
end

function beep --description "make two beeps"
	echo -e '\a'; sleep 0.1; echo -e '\a';
end

function rn
	set new_name $argv[1]
	set current_dir (pwd)
	cd ..
	mv $current_dir $new_name
	cd $new_name
end

function gap
	git add . && git commit -m "$argv[1]" && git push
end

function ghcl
	if test -z $argv[2]
		gh repo clone $argv && cd (basename $argv[1] .git)
	else
		gh repo clone $argv && cd $argv[2]
	end
end

function gcl
	if test -z $argv[2]
		g clone $argv && cd (basename $argv[1] .git)
	else
		g clone $argv && cd $argv[2]
	end
end

function gcld
	if test -z $argv[2]
		g clone --depth 1 $argv && cd (basename $argv[1] .git)
	else
		g clone --depth 1 $argv && cd $argv[2]
	end
end

function mc
	mkdir -p $argv[1]
	cd $argv[1]
end

function sudo!!
	eval sudo $history[1]
end

function bind_bang
	switch (commandline -t)[-1]
		case "!"
			commandline -t -- $history[1]
			commandline -f repaint
		case "*"
			commandline -i !
	end
end

function bind_dollar
	switch (commandline -t)[-1]
		case "!"
			commandline -f backward-delete-char history-token-search-backward
		case "*"
			commandline -i '$'
	end
end

function fish_user_key_bindings
	bind ! bind_bang
	bind '$' bind_dollar
end
