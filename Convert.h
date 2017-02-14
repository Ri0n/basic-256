#pragma once

#include <string.h>
#include <stdio.h>
#include <stdlib.h>
#include <cmath>
#include <limits>

#include <QString>
#include <QLocale>
#include <QVariant>
#include <QDebug>

#include "Settings.h"
#include "Error.h"
#include "DataElement.h"
#include "Constants.h"

// convert and compare functions
// to change DataElement into float, int, or QString and to do string and
// numeric comparison (using epislon)
// forward error or warning to the error object

class Convert
{
	public:

		Convert(Error *, QLocale *);
		~Convert();

		void setdecimaldigits(int);

		bool isNumeric(DataElement*);

		int getInt(DataElement*);
		long getLong(DataElement*);
		double getFloat(DataElement*);
		QString getString(DataElement*);
		QString getString(DataElement*, int);
        double getMusicalNote(DataElement*);
		int getBool(DataElement*);

		int compare(DataElement*, DataElement*);
		int compareFloats(double, double);

	private:
		Error *error;
		QLocale *locale;
        QRegExp *isnumeric;
        QRegExp *musicalnote;
        QMap<QString, int> notesmap{{"do", 0}, {"re", 2}, {"mi", 4}, {"fa", 5}, {"sol", 7}, {"la", 9}, {"si", 11}, {"c", 0}, {"d", 2}, {"e", 4}, {"f", 5}, {"g", 7}, {"a", 9}, {"b", 11}, {"h", 11}, {"ni", 0}, {"pa", 2}, {"vu", 4}, {"ga", 5}, {"di", 7}, {"ke", 9}, {"zo", 11},};
        int ec(int, int);
		int decimaldigits;	// display n decinal digits 12 default - 8 to 15 valid
		bool floattail;		// display floats with a tail of ".0" if whole numbers
        bool replaceDecimalPoint; // user can chose if INPUT and PRINT should use localized decimal point
        QChar decimalPoint;

};
