#!/bin/bash
echo "$(tput setaf 3)Hallo Master,"
while read -p "$(tput setaf 3)please give your creation a name: " desc; do
		 if [[ -z "${desc}" ]]; then
					echo "$(tput setaf 1)you have to name it or we never find it again!"
		 else
					echo "$(tput setaf 1)burning the name on its ass..."
					break
		 fi
done
echo "$(tput setaf 2) "
path=$(dirname $(readlink -f $0))"/grunt"
echo $path
cd $path
grunt jscomp
grunt sasscomp
cd ..
cd ..
echo "$(tput setaf 3) "
git add . && \
git add -u && \
git add -A && \
git status
read -r -p "$(tput setaf 1)sure you want to set this monster free? [Y/n]: " response
response=${response,,} # tolower
if [[ $response =~ ^(yes|y| ) ]] | [ -z $response ]; then
	echo "$(tput setaf 2) "
	git commit -m "$desc" && \
	git push
	echo ""
	echo "$(tput setaf 3)the monster is free... lets hope you did it right this time!"
	echo ""
	read -r -p "$(tput setaf 1)want to be rly dumb and push it to the real world? [y/N]: " response2
	response2=${response2,,}  # tolower
	if [[ $response2 =~ ^(no|n| ) ]] | [ -z $response2 ]; then
		echo ""
		echo "$(tput setaf 3)ok smart, lets test it a bit first! $(tput setaf 1)(commit is not live!)"
	else
	echo "$(tput setaf 2) "
		git ftp push
		echo ""
		echo "$(tput setaf 3)the monster is now roaming free... and is running straight to tokyo! $(tput setaf 2)(commit is now LIVE!)"
	fi
else
	echo "$(tput setaf 9)"
	git reset
	echo ""
	echo "$(tput setaf 1)ok I get the monster back in its cage!"
fi
