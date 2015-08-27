﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Reflector
{
    public class XslUtils
    {
        public string Iif(bool expression, string trueValue, string falseValue)
        {
            return expression ? trueValue : falseValue;
        }

        public string HttpMethod(bool get, bool post, bool put, bool patch, bool delete, bool options)
        {
            if (get)
                return "GET";
            else if (post)
                return "POST";
            else if (put)
                return "PUT";
            else if (patch)
                return "PATCH";
            else if (delete)
                return "DELETE";

            return "OPTIONS";
        }

        public string CapitalizeWords(string value)
        {
            var capitalized = string.Empty;
            if (!string.IsNullOrEmpty(value))
            {
                for(var i=0; i<value.Length; i++)
                {
                    if (i == 0)
                        capitalized = value[i].ToString().ToUpper();
                    else if (Char.IsUpper(value[i]))
                        capitalized += " " + value[i];
                    else
                        capitalized += value[i];
                }
            }

            return capitalized;
        }
    }
}