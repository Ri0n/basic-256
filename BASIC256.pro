
lessThan(QT_MAJOR_VERSION, 5) {
  message( FATAL_ERROR "BASIC-256 requires QT 5 or better." )
}


TEMPLATE					=	app
TARGET						=	basic256
DEPENDPATH					+=	.
INCLUDEPATH					+=	.
QMAKE_CXXFLAGS				+=	-g
QMAKE_CXXFLAGS				+=	-std=c++11
CONFIG						+=	 qt debug_and_release link_pkgconfig
OBJECTS_DIR					=	tmp/obj
MOC_DIR						=	tmp/moc

#QT						+=	webkitwidgets
#QT						+=	webkit
QT						+=	gui
QT						+=	sql
QT						+=	widgets
QT						+=	printsupport
QT						+=	serialport

RESOURCES					+=	resources/resource.qrc
TRANSLATIONS				=	Translations/basic256_en.ts \
								Translations/basic256_de.ts \
								Translations/basic256_ru.ts \
								Translations/basic256_es.ts \
								Translations/basic256_fr.ts \
								Translations/basic256_pt.ts \
								Translations/basic256_nl.ts \
								Translations/basic256_it.ts

win32 {
        DEFINES 				+=	WIN32
	DEFINES 				+=	USEQMEDIAPLAYER
        RC_FILE					=	resources/windows.rc
        LIBS					+=	-lole32 \
								-lws2_32 \
								-lwinmm

        ###CONFIG += console  ## enable for printf debugging in windows
###QMAKE_CXXFLAGS				+=-DYYDEBUG=1
	QMAKE_CXXFLAGS			+=	-mstackrealign
	QMAKE_CXXFLAGS_RELEASE	+=	-mstackrealign

	########
	# TTS control - How Say statement works
	########
	# uncomment one of the options

	## TTS Option 1 - ececute 'espak' command to speak
	#DEFINES				+=	ESPEAK_EXECUTE

	## TTS Option 2 - use the espeak library
	DEFINES					+=	ESPEAK
	LIBS					+=	-lespeak-ng

	########
	# Sound class - How Sound statement works
	########
	QT						+=	multimedia
	INCLUDEPATH				+=	QtMultimediaKit
	INCLUDEPATH				+=	QtMobility
	CONFIG					+=	mobility
	MOBILITY				+=	multimedia


}

unix:!macx {
	## this is the LINUX (unix-non-mac)
	DEFINES					+=	LINUX
        QMAKE_CXXFLAGS				+=	-std=c++11

	########
	# TTS control - How Say statement works
	########
	# uncomment one of the options

	## TTS Option 1 - ececute 'espeak-ng' command to speak
	#DEFINES				+=	ESPEAK_EXECUTE

	## TTS Option 2 - use the espeak library
	PKGCONFIG += espeak-ng
	DEFINES					+=	ESPEAK

	LIBS					+=	-lm

	########
	# Sound class - How Sound statement works
	########
	QT						+=	multimedia
	INCLUDEPATH				+=	QtMultimediaKit
	INCLUDEPATH				+=	QtMobility

	isEmpty(PREFIX) {
		PREFIX = /usr
	}
	DEFINES                 += FS_PREFIX=$$PREFIX
	########
	# rules for make install
	########
	exampleFiles.files		=	./Examples
	exampleFiles.path		=	$$PREFIX/share/basic256
	INSTALLS				+=	exampleFiles

	helpHTMLFiles.files		=	./wikihelp/help
	helpHTMLFiles.path		=	$$PREFIX/share/basic256
	INSTALLS				+=	helpHTMLFiles

	transFiles.files		=	./Translations/*.qm
	transFiles.path			=	$$PREFIX/share/basic256
	INSTALLS				+=	transFiles

	# main program executable
	target.path				=	$$PREFIX/bin
	INSTALLS				+=	target

	desktopFile.extra       =   sed -e \"s|Icon=.*|Icon=$${PREFIX}/share/pixmaps/basic256.xpm|\" $${PWD}/debian/basic256.desktop > $$PREFIX/share/applications/basic256.desktop
	desktopFile.path        =   $$PREFIX/share/applications
	INSTALLS                +=  desktopFile

	iconFile.files          = ./debian/basic256.xpm
	iconFile.path           = $$PREFIX/share/pixmaps
	INSTALLS                += iconFile
}

macx {
	# macintosh
	DEFINES					+=	MACX
	DEFINES					+=	MACX_SAY

	ICON					=	resources/basic256.icns

	LIBS					+=	-L/opt/local/lib
	INCLUDEPATH				+=	/opt/local/include

    # Sound - QT Mobility Multimedia AudioOut
    QT						+=	multimedia
    INCLUDEPATH				+=	QtMultimediaKit
    INCLUDEPATH				+=	QtMobility


}

exists( ./LEX/Makefile ) {
	message( Running make for ./LEX/Makefile )
	system( make -C ./LEX )
} else {
        error( Could not make LEX project - aborting... )
}


# Input
HEADERS 					+=	LEX/basicParse.tab.h
HEADERS 					+=	*.h

SOURCES 					+=	LEX/lex.yy.c
SOURCES 					+=	LEX/basicParse.tab.c
SOURCES 					+=	*.cpp
