#pragma once

#include <string.h>
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <cmath>
#include <limits>

#include <QString>

#include "Settings.h"
#include "Error.h"
#include "Types.h"

// convert and compare functions
// to change DataElement into float, int, or QString and to do string and
// numeric comparison (using epislon)
// forward error or warning to the error object

class Convert
{
	public:

		Convert(Error *);
		
		void settypeconverror(int);
		void setdecimaldigits(int);

		
		int getInt(DataElement*);
		double getFloat(DataElement*);
		QString getString(DataElement*);
		QString getString(DataElement*, int);
		  
		int compare(DataElement*, DataElement*);
		int compareFloats(double, double);
		
		static const double EPSILON = 0.00000001;
		
	private:
		Error *error;
		int ec(int, int);
		int typeconverror;	// 0-return no errors on type conversion, 1-warn, 2-error
		int decimaldigits;	// display n decinal digits 12 default - 8 to 15 valid
		
};
