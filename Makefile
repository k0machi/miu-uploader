install:
	mkdir -p ${HOME}/.local/share/applications
	cp -v miu.desktop ${HOME}/.local/share/applications
	mkdir -p ${HOME}/.local/bin
	cp -vf upload.sh ${HOME}/.local/bin/miupload
	mkdir -p ${HOME}/.local/share/icons/hicolor
	cp -rv icons/. ${HOME}/.local/share/icons/hicolor 
	touch ${HOME}/.miukey
	chmod 600 ${HOME}/.miukey
