#pragma once
#include<string>
#include "FunctionObjects.h"

namespace CR
{
	namespace Utility
	{
		struct UnicodeToAscii
		{
			char operator()(wchar_t _char)
			{
				char result;
				wctomb(&result,_char);
				return result;
			}
		};

		struct Convert
		{
			std::string operator()(const std::wstring &_original)
			{
				std::string result;
				result.resize(_original.size());
				Transform(_original,result,UnicodeToAscii());
				return result;
			}
		};
	}
}

