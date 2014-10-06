#!/bin/bash

# callback for fetching the raw package data
function h3pkg_script_get_raw () {
	#
	local PUB_PATH="/home/pub/prof/padberg_julia/Home_GKA_WiSe14"

	rsync -aP "${H3PKG_USER}@${H3PKG_REMOTE_HOME}:${PUB_PATH}" "${H3PKG_PACKAGE_HOME}/.cache"

	return $?
}

# callback for building the package
function h3pkg_script_build_package () {
	local raw_base=${H3PKG_PACKAGE_HOME}/.cache/WS2014-AI
	#
	cd ${H3PKG_PACKAGE_HOME} && {
		rm -rf gka
		mkdir -p gka
		cd gka && {
			mkdir -p doc lab etc

			cp ${raw_base}/Folien/* doc
			cp ${raw_base}/PDF/* etc
			cp ${raw_base}/Stuff/* lab
			mv etc/aufgaben.pdf lab

			tar -jcf gka.tar doc lab etc
		}
	}

	return 0
}
